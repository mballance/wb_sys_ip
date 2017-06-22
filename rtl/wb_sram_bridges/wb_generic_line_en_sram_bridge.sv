/****************************************************************************
 * wb_generic_line_en_sram_bridge.sv
 ****************************************************************************/

/**
 * Module: wb_generic_line_en_sram_bridge
 * 
 * TODO: Add module documentation
 */
module wb_generic_line_en_sram_bridge #(
		parameter int					ADDRESS_WIDTH=10,
		parameter int					DATA_WIDTH=32
		) (
			input									clk,
			input									rstn,
			wb_if.slave								wb_s,
			generic_sram_line_en_if.sram_client		sram_m
		);

	parameter DELAY = 2;
	reg req, req_1;
	reg [DELAY-1:0] 	req_d;
	reg [1:0]			state;

	always @(posedge clk or negedge rstn) begin
		if (rstn == 0) begin
			state <= 0;
			req <= 0;
			req_1 <= 0;
		end else begin
			case (state)
				0: begin
					if (wb_s.CYC && wb_s.STB) begin
						if (wb_s.WE) begin
							state <= 1;
						end else begin
							state <= 2;
						end
					end
				end
				
				1: begin // Write ack
					state <= 0;
				end
				
				2: begin // Read ack (1)
					state <= 3;
				end
				
				3: begin // Read ack (2)
					state <= 0;
				end
			endcase
		end
	end
	
//	wire access = (sram_m.read_en || sram_m.write_en);
	wire access = (wb_s.CYC && wb_s.STB);
	
	assign sram_m.addr = (access)?wb_s.ADR[ADDRESS_WIDTH-1:(DATA_WIDTH/32)+1]:0;
	assign sram_m.read_en = (access & !wb_s.WE);
	assign sram_m.write_en = (access && state == 0 && wb_s.WE);
	assign sram_m.write_data = wb_s.DAT_W;
	assign wb_s.DAT_R = sram_m.read_data;

	assign wb_s.ACK = (state == 1 || state == 3);
	assign wb_s.ERR = 0;
	
	assign wb_s.TGD_R = 0;

endmodule


