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
	reg [DELAY-1:0] req_d;

	always @(posedge clk) begin
		if (rstn == 0) begin
			req <= 0;
			req_1 <= 0;
		end else begin
			if (wb_s.CYC && wb_s.STB && !req) begin
				req <= 1;
			end else begin
				req <= 0;
			end
			req_1 <= req;
		end
	end
	
	wire access = (sram_m.read_en || sram_m.write_en);
	
	assign sram_m.addr = (access)?wb_s.ADR[ADDRESS_WIDTH-1:(DATA_WIDTH/32)+1]:0;
	assign sram_m.read_en = (wb_s.CYC & wb_s.STB & !wb_s.WE);
	assign sram_m.write_en = (wb_s.CYC & wb_s.STB & wb_s.WE);
	assign sram_m.write_data = wb_s.DAT_W;
	assign wb_s.DAT_R = sram_m.read_data;

//	assign wb_s.ACK = (sram_m.read_en)?req_1:req;
	assign wb_s.ACK = req_1; // (sram_m.read_en)?req_1:req;
	assign wb_s.ERR = 0;

endmodule


