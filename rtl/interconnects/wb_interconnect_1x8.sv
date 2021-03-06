/****************************************************************************
 * wb_interconnect_1x8.sv
 ****************************************************************************/

/**
 * Module: wb_interconnect_1x8
 * 
 * TODO: Add module documentation
 */
module wb_interconnect_1x8 #(
		parameter int WB_ADDR_WIDTH=32,
		parameter int WB_DATA_WIDTH=32,
		parameter bit[WB_ADDR_WIDTH-1:0] SLAVE0_ADDR_BASE='h0,
		parameter bit[WB_ADDR_WIDTH-1:0] SLAVE0_ADDR_LIMIT='h0,
		parameter bit[WB_ADDR_WIDTH-1:0] SLAVE1_ADDR_BASE='h0,
		parameter bit[WB_ADDR_WIDTH-1:0] SLAVE1_ADDR_LIMIT='h0,
		parameter bit[WB_ADDR_WIDTH-1:0] SLAVE2_ADDR_BASE='h0,
		parameter bit[WB_ADDR_WIDTH-1:0] SLAVE2_ADDR_LIMIT='h0,
		parameter bit[WB_ADDR_WIDTH-1:0] SLAVE3_ADDR_BASE='h0,
		parameter bit[WB_ADDR_WIDTH-1:0] SLAVE3_ADDR_LIMIT='h0,
		parameter bit[WB_ADDR_WIDTH-1:0] SLAVE4_ADDR_BASE='h0,
		parameter bit[WB_ADDR_WIDTH-1:0] SLAVE4_ADDR_LIMIT='h0,
		parameter bit[WB_ADDR_WIDTH-1:0] SLAVE5_ADDR_BASE='h0,
		parameter bit[WB_ADDR_WIDTH-1:0] SLAVE5_ADDR_LIMIT='h0,
		parameter bit[WB_ADDR_WIDTH-1:0] SLAVE6_ADDR_BASE='h0,
		parameter bit[WB_ADDR_WIDTH-1:0] SLAVE6_ADDR_LIMIT='h0,
		parameter bit[WB_ADDR_WIDTH-1:0] SLAVE7_ADDR_BASE='h0,
		parameter bit[WB_ADDR_WIDTH-1:0] SLAVE7_ADDR_LIMIT='h0
		) (
		input						clk,
		input						rstn,
		wb_if.slave					m0,
		wb_if.master					s0,
		wb_if.master					s1,
		wb_if.master					s2,
		wb_if.master					s3,
		wb_if.master					s4,
		wb_if.master					s5,
		wb_if.master					s6,
		wb_if.master					s7
		);
	
	
	localparam int WB_DATA_MSB = (WB_DATA_WIDTH-1);
	localparam int N_MASTERS = 1;
	localparam int N_SLAVES = 8;
	localparam int N_MASTERID_BITS = (N_MASTERS>1)?$clog2(N_MASTERS):1;
	localparam int N_SLAVEID_BITS = $clog2(N_SLAVES+1);
	localparam bit[N_SLAVEID_BITS:0]		NO_SLAVE  = {(N_SLAVEID_BITS+1){1'b1}};
	localparam bit[N_MASTERID_BITS:0]		NO_MASTER = {(N_MASTERID_BITS+1){1'b1}};
	
	wire[WB_ADDR_WIDTH-1:0]						ADR[N_MASTERS-1:0];
	wire[2:0]									CTI[N_MASTERS-1:0];
	wire[1:0]									BTE[N_MASTERS-1:0];
	wire[WB_DATA_WIDTH-1:0]						DAT_W[N_MASTERS-1:0];
	wire[WB_DATA_WIDTH-1:0]						DAT_R[N_MASTERS-1:0];
	wire										CYC[N_MASTERS-1:0];
	wire										ERR[N_MASTERS-1:0];
	wire[(WB_DATA_WIDTH/8)-1:0]					SEL[N_MASTERS-1:0];
	wire										STB[N_MASTERS-1:0];
	wire										ACK[N_MASTERS-1:0];
	wire										WE[N_MASTERS-1:0];
	
	wire[WB_ADDR_WIDTH-1:0]						SADR[N_SLAVES:0];
	wire[2:0]									SCTI[N_SLAVES:0];
	wire[1:0]									SBTE[N_SLAVES:0];
	wire[WB_DATA_WIDTH-1:0]						SDAT_W[N_SLAVES:0];
	wire[WB_DATA_WIDTH-1:0]						SDAT_R[N_SLAVES:0];
	wire										SCYC[N_SLAVES:0];
	wire										SERR[N_SLAVES:0];
	wire[(WB_DATA_WIDTH/8)-1:0]					SSEL[N_SLAVES:0];
	wire										SSTB[N_SLAVES:0];
	wire										SACK[N_SLAVES:0];
	wire										SWE[N_SLAVES:0];
	
	wb_interconnect_NxN #(
			.WB_ADDR_WIDTH(WB_ADDR_WIDTH),
			.WB_DATA_WIDTH(WB_DATA_WIDTH),
			.N_MASTERS(N_MASTERS),
			.N_SLAVES(N_SLAVES),
			.ADDR_RANGES({SLAVE0_ADDR_BASE, SLAVE0_ADDR_LIMIT,SLAVE1_ADDR_BASE, SLAVE1_ADDR_LIMIT,SLAVE2_ADDR_BASE, SLAVE2_ADDR_LIMIT,SLAVE3_ADDR_BASE, SLAVE3_ADDR_LIMIT,SLAVE4_ADDR_BASE, SLAVE4_ADDR_LIMIT,SLAVE5_ADDR_BASE, SLAVE5_ADDR_LIMIT,SLAVE6_ADDR_BASE, SLAVE6_ADDR_LIMIT,SLAVE7_ADDR_BASE, SLAVE7_ADDR_LIMIT})
		) ic0 (
			.clk(clk),
			.rstn(rstn),
			.ADR(ADR),
			.CTI(CTI),
			.BTE(BTE),
			.DAT_W(DAT_W),
			.DAT_R(DAT_R),
			.CYC(CYC),
			.ERR(ERR),
			.SEL(SEL),
			.STB(STB),
			.ACK(ACK),
			.WE(WE),
			
			.SADR(SADR),
			.SCTI(SCTI),
			.SBTE(SBTE),
			.SDAT_W(SDAT_W),
			.SDAT_R(SDAT_R),
			.SCYC(SCYC),
			.SERR(SERR),
			.SSEL(SSEL),
			.SSTB(SSTB),
			.SACK(SACK),
			.SWE(SWE)
		);
	
	// master assigns
	assign ADR[0] = m0.ADR;
	assign CTI[0] = m0.CTI;
	assign BTE[0] = m0.BTE;
	assign DAT_W[0] = m0.DAT_W;
	assign CYC[0] = m0.CYC;
	assign SEL[0] = m0.SEL;
	assign STB[0] = m0.STB;
	assign WE[0] = m0.WE;
	assign m0.DAT_R = DAT_R[0];
	assign m0.ERR = ERR[0];
	assign m0.ACK = ACK[0];

	
	// Slave requests
	assign SDAT_R[0] = s0.DAT_R;
	assign SDAT_R[1] = s1.DAT_R;
	assign SDAT_R[2] = s2.DAT_R;
	assign SDAT_R[3] = s3.DAT_R;
	assign SDAT_R[4] = s4.DAT_R;
	assign SDAT_R[5] = s5.DAT_R;
	assign SDAT_R[6] = s6.DAT_R;
	assign SDAT_R[7] = s7.DAT_R;
	assign SERR[0] = s0.ERR;
	assign SERR[1] = s1.ERR;
	assign SERR[2] = s2.ERR;
	assign SERR[3] = s3.ERR;
	assign SERR[4] = s4.ERR;
	assign SERR[5] = s5.ERR;
	assign SERR[6] = s6.ERR;
	assign SERR[7] = s7.ERR;
	assign SACK[0] = s0.ACK;
	assign SACK[1] = s1.ACK;
	assign SACK[2] = s2.ACK;
	assign SACK[3] = s3.ACK;
	assign SACK[4] = s4.ACK;
	assign SACK[5] = s5.ACK;
	assign SACK[6] = s6.ACK;
	assign SACK[7] = s7.ACK;
	assign s0.ADR = SADR[0];
	assign s1.ADR = SADR[1];
	assign s2.ADR = SADR[2];
	assign s3.ADR = SADR[3];
	assign s4.ADR = SADR[4];
	assign s5.ADR = SADR[5];
	assign s6.ADR = SADR[6];
	assign s7.ADR = SADR[7];
	assign s0.CTI = SCTI[0];
	assign s1.CTI = SCTI[1];
	assign s2.CTI = SCTI[2];
	assign s3.CTI = SCTI[3];
	assign s4.CTI = SCTI[4];
	assign s5.CTI = SCTI[5];
	assign s6.CTI = SCTI[6];
	assign s7.CTI = SCTI[7];
	assign s0.BTE = SBTE[0];
	assign s1.BTE = SBTE[1];
	assign s2.BTE = SBTE[2];
	assign s3.BTE = SBTE[3];
	assign s4.BTE = SBTE[4];
	assign s5.BTE = SBTE[5];
	assign s6.BTE = SBTE[6];
	assign s7.BTE = SBTE[7];
	assign s0.DAT_W = SDAT_W[0];
	assign s1.DAT_W = SDAT_W[1];
	assign s2.DAT_W = SDAT_W[2];
	assign s3.DAT_W = SDAT_W[3];
	assign s4.DAT_W = SDAT_W[4];
	assign s5.DAT_W = SDAT_W[5];
	assign s6.DAT_W = SDAT_W[6];
	assign s7.DAT_W = SDAT_W[7];
	assign s0.CYC = SCYC[0];
	assign s1.CYC = SCYC[1];
	assign s2.CYC = SCYC[2];
	assign s3.CYC = SCYC[3];
	assign s4.CYC = SCYC[4];
	assign s5.CYC = SCYC[5];
	assign s6.CYC = SCYC[6];
	assign s7.CYC = SCYC[7];
	assign s0.SEL = SSEL[0];
	assign s1.SEL = SSEL[1];
	assign s2.SEL = SSEL[2];
	assign s3.SEL = SSEL[3];
	assign s4.SEL = SSEL[4];
	assign s5.SEL = SSEL[5];
	assign s6.SEL = SSEL[6];
	assign s7.SEL = SSEL[7];
	assign s0.STB = SSTB[0];
	assign s1.STB = SSTB[1];
	assign s2.STB = SSTB[2];
	assign s3.STB = SSTB[3];
	assign s4.STB = SSTB[4];
	assign s5.STB = SSTB[5];
	assign s6.STB = SSTB[6];
	assign s7.STB = SSTB[7];
	assign s0.WE = SWE[0];
	assign s1.WE = SWE[1];
	assign s2.WE = SWE[2];
	assign s3.WE = SWE[3];
	assign s4.WE = SWE[4];
	assign s5.WE = SWE[5];
	assign s6.WE = SWE[6];
	assign s7.WE = SWE[7];



endmodule
	

