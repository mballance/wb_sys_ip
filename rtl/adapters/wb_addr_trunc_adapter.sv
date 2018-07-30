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
			assign out.ADR[WB_ADDR_PASSTHROUGH-1:0] = i.ADR[WB_ADDR_PASSTHROUGH-1:0];
			assign out.ADR[WB_ADDR_WIDTH-1:WB_ADDR_PASSTHROUGH] = 0;
		end else begin
			// Very boring... They're the same.
			assign out.ADR = i.ADR;
		end
	endgenerate
	
	assign out.TGA = i.TGA;
	assign out.CTI = i.CTI;
	assign out.BTE = i.BTE;
	assign out.DAT_W = i.DAT_W;
	assign out.TGD_W = i.TGD_W;
	assign i.DAT_R = out.DAT_R;
	assign out.TGD_R = i.TGD_R;
	assign out.CYC = i.CYC;
	assign out.TGC = i.TGC;
	assign i.ERR = out.ERR;
	assign out.SEL = i.SEL;
	assign out.STB = i.STB;
	assign i.ACK = out.ACK;
	assign out.WE = i.WE;

endmodule


