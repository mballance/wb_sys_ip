/****************************************************************************
 * wb_addr_width_adapter.sv
 ****************************************************************************/

/**
 * Module: wb_addr_width_adapter
 * 
 * TODO: Add module documentation
 */
module wb_addr_width_adapter #(
		parameter int		WB_ADDR_WIDTH_IN=32,
		parameter int		WB_ADDR_WIDTH_OUT=32
		) (
		wb_if.slave			i,
		wb_if.master		out
		);

	generate 
		if (WB_ADDR_WIDTH_IN < WB_ADDR_WIDTH_OUT) begin
			// The input is smaller than the output. Need to pad output
			assign out.ADR[WB_ADDR_WIDTH_IN-1:0] = in.ADR;
			assign out.ADR[WB_ADDR_WIDTH_OUT-1:WB_ADDR_WIDTH_IN] = 0;
		end else if (WB_ADDR_WIDTH_IN > WB_ADDR_WIDTH_OUT) begin
			// The output is smaller than the input. Just truncate
			assign out.ADR = in.ADR[WB_ADDR_WIDTH_OUT-1:0];
		end else begin
			// Very boring... They're the same width
			assign out.ADR = in.ADR;
		end
	endgenerate
	
	assign out.TGA = in.TGA;
	assign out.CTI = in.CTI;
	assign out.BTE = in.BTE;
	assign out.DAT_W = in.DAT_W;
	assign out.TGD_W = in.TGD_W;
	assign in.DAT_R = out.DAT_R;
	assign out.TGD_R = in.TGD_R;
	assign out.CYC = in.CYC;
	assign out.TGC = in.TGC;
	assign in.ERR = out.ERR;
	assign out.SEL = in.SEL;
	assign out.STB = in.STB;
	assign in.ACK = out.ACK;
	assign out.WE = in.WE;

endmodule


