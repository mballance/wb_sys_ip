/****************************************************************************
 * wb_addr_trunc_adapter.sv
 ****************************************************************************/

/**
 * Module: wb_addr_trunc_adapter
 * 
 * Truncates the address on the outgoing address
 */
module wb_addr_trunc_adapter #(
		parameter int		WB_ADDR_WIDTH=32,
		parameter int		WB_ADDR_PASSTHROUGH = 32
		) (
		wb_if.slave			i,
		wb_if.master		out
		);

	generate 
		if (WB_ADDR_PASSTHROUGH < WB_ADDR_WIDTH) begin
			// The output is smaller than the input. Pad the output with zero
			assign out.ADR[WB_ADDR_PASSTHROUGH-1:0] = in.ADR[WB_ADDR_PASSTHROUGH-1:0];
			assign out.ADR[WB_ADDR_WIDTH-1:WB_ADDR_PASSTHROUGH] = 0;
		end else begin
			// Very boring... They're the same.
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


