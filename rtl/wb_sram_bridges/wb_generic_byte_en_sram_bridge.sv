/****************************************************************************
 * wb_generic_byte_en_sram_bridge.sv
 ****************************************************************************/

/**
 * Module: wb_generic_byte_en_sram_bridge
 * 
 * TODO: Add module documentation
 */
module wb_generic_byte_en_sram_bridge #(
		parameter int			ADDRESS_WIDTH=10,
		parameter int			DATA_WIDTH=32
		) (
			input									clk,
			input									rstn,
			wb_if.slave								wb_s,
			generic_sram_byte_en_if.sram_client		sram_m
		);
	
	reg[1:0] state = 0;

	always @(posedge clk) begin
		if (rstn == 0) begin
			state <= 0;
		end else begin
			case (state)
				0:
					if (wb_s.CYC && wb_s.STB) begin
						state <= 1;
					end
				1:
					state <= 2;
				2:
					state <= 0;
				default:
					state <= 0;
			endcase
		end
	end
	
	initial begin
		$display("%m: ADDRESS_WIDTH=%0d DATA_WIDTH=%0d ADR[%0d:%0d]",
				ADDRESS_WIDTH, DATA_WIDTH,
				ADDRESS_WIDTH+(DATA_WIDTH/32),(DATA_WIDTH/32)+1);
	end
	
	assign sram_m.addr = wb_s.ADR[ADDRESS_WIDTH+(DATA_WIDTH/32):(DATA_WIDTH/32)+1];
	assign sram_m.read_en = (wb_s.CYC & wb_s.STB & !wb_s.WE);
	assign sram_m.write_en = (wb_s.CYC & wb_s.STB & wb_s.WE);
//	assign sram_m.read_en = (wb_s.CYC & wb_s.SEL & !wb_s.WE);
//	assign sram_m.write_en = (wb_s.CYC & wb_s.SEL & wb_s.WE);
	assign sram_m.byte_en = wb_s.SEL;
	assign sram_m.write_data = wb_s.DAT_W;
	assign wb_s.DAT_R = sram_m.read_data;

//	assign wb_s.ACK = (sram_m.read_en)?req_1:req;
	assign wb_s.ACK = (state == 2);
	assign wb_s.ERR = 0; // no errors
	
	assign wb_s.TGD_R = 0;

endmodule


