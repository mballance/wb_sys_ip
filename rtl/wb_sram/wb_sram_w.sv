

module wb_sram_w #(
		parameter int			MEM_ADDR_BITS=10,
		parameter int			WB_ADDRESS_WIDTH=32,
		parameter int			WB_DATA_WIDTH=32,
		parameter				INIT_FILE=""
		) (
			input							clk,
			input							rst,
			input[WB_ADDRESS_WIDTH-1:0]		ADR,
			input[0:0]						TGA,
			input[2:0]						CTI,
			input[1:0]						BTE,
			input[WB_DATA_WIDTH-1:0]		DAT_W,
			input[0:0]						TGD_W,
			output[WB_DATA_WIDTH-1:0]		DAT_R,
			output[0:0]						TGD_R,
			input							CYC,
			input[0:0]						TGC,
			output							ERR,
			input[(WB_DATA_WIDTH/8)-1:0]	SEL,
			input							STB,
			output							ACK,
			input							WE
		);
	
	wb_if #(
		.WB_ADDR_WIDTH  (WB_ADDRESS_WIDTH), 
		.WB_DATA_WIDTH  (WB_DATA_WIDTH )
		) u_if ();
	
	assign u_if.ADR = ADR;
	assign u_if.TGA = TGA;
	assign u_if.CTI = CTI;
	assign u_if.BTE = BTE;
	assign u_if.DAT_W = DAT_W;
	assign u_if.TGD_W = TGD_W;
	assign DAT_R = u_if.DAT_R;
	assign TGD_R = u_if.TGD_R;
	assign u_if.CYC = CYC;
	assign u_if.TGC = TGC;
	assign ERR = u_if.ERR;
	assign u_if.SEL = SEL;
	assign u_if.STB = STB;
	assign ACK = u_if.ACK;
	assign u_if.WE = WE;
	
	wb_sram #(
		.MEM_ADDR_BITS     (MEM_ADDR_BITS    ), 
		.WB_ADDRESS_WIDTH  (WB_ADDRESS_WIDTH ), 
		.WB_DATA_WIDTH     (WB_DATA_WIDTH    ), 
		.INIT_FILE         (INIT_FILE        )
		) u_ram (
		.clk               (clk              ), 
		.rstn              (~rst             ), 
		.s                 (u_if.slave       ));
	
endmodule
