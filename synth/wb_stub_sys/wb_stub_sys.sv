/****************************************************************************
 * wb_stub_sys.sv
 ****************************************************************************/

`define CHISEL_WB_IC

/**
 * Module: wb_stub_sys
 * 
 * TODO: Add module documentation
 */
module wb_stub_sys(
		input		clk_i,
		output		led0,
		output		led1,
		output		led2,
		output		led3
		);

//	reg clk;
	wire clk = clk_i;
	reg rstn_1 = 0;
	reg[7:0] rstn_1_cnt = 0;
	reg [15:0] clken_cnt = 0;
	reg rstn = 0;
	reg[7:0] rstn_cnt = 0;
	
	reg[3:0] led;
	reg[31:0] s0_acc_cnt;
	reg[31:0] s1_acc_cnt;
	reg[31:0] s2_acc_cnt;
	reg[31:0] s3_acc_cnt;
	
	assign led0 = led[0];
	assign led1 = led[1];
	assign led2 = led[2];
	assign led3 = led[3];
	
	always @(posedge clk_i) begin
		if (rstn_cnt == 100) begin
			rstn <= 1;
		end else begin
			rstn_cnt <= rstn_cnt + 1;
		end
	end
	
//	always @(posedge clk_i) begin
//		if (rstn_1_cnt == 100) begin
//			rstn_1 <= 1;
//		end else begin
//			rstn_1_cnt <= rstn_1_cnt + 1;
//		end
//	end
//
//	localparam DIV = 25000;
////	localparam DIV = 10;
//	always @(posedge clk_i) begin
//		if (rstn_1 == 0) begin
//			clken_cnt <= 0;
//			clk <= 0;
//		end else begin
//			if (clken_cnt == DIV) begin
//				clken_cnt <= 0;
//				clk <= ~clk;
//			end else begin
//				clken_cnt <= clken_cnt + 1;
//			end
//		end
//	end
//	
//	always @(posedge clk) begin
//		if (rstn_cnt == 10) begin
//			rstn <= 1;
//		end else begin
//			rstn_cnt <= rstn_cnt + 1;
//		end
//	end
	
	
	parameter WB_ADDR_WIDTH = 32;
	parameter WB_DATA_WIDTH = 32;
	
	wb_if #(
			.WB_ADDR_WIDTH  (WB_ADDR_WIDTH ), 
			.WB_DATA_WIDTH  (WB_DATA_WIDTH )
		) m02ic ();
	wb_if #(
			.WB_ADDR_WIDTH  (WB_ADDR_WIDTH ), 
			.WB_DATA_WIDTH  (WB_DATA_WIDTH )
		) m12ic ();
	
	wb_if #(
			.WB_ADDR_WIDTH  (WB_ADDR_WIDTH ), 
			.WB_DATA_WIDTH  (WB_DATA_WIDTH )
		) ic2s0 ();
	
	wb_if #(
			.WB_ADDR_WIDTH  (WB_ADDR_WIDTH ), 
			.WB_DATA_WIDTH  (WB_DATA_WIDTH )
		) ic2s1 ();
	
	wb_if #(
			.WB_ADDR_WIDTH  (WB_ADDR_WIDTH ), 
			.WB_DATA_WIDTH  (WB_DATA_WIDTH )
		) ic2s2 ();
	
	wb_if #(
			.WB_ADDR_WIDTH  (WB_ADDR_WIDTH ), 
			.WB_DATA_WIDTH  (WB_DATA_WIDTH )
		) ic2s3 ();
	
	
	wire [31:0] io_addr_base_0 = 'h0000_0000;
	wire [31:0] io_addr_limit_0 = (io_addr_base_0 + 'h0000_00FF);
	wire [31:0] io_addr_base_1 = 'h0000_0100;
	wire [31:0] io_addr_limit_1 = (io_addr_base_1 + 'h0000_00FF);
	wire [31:0] io_addr_base_2 = 'h0000_0200;
	wire [31:0] io_addr_limit_2 = (io_addr_base_2 + 'h0000_00FF);
	wire [31:0] io_addr_base_3 = 'h0000_0300;
	wire [31:0] io_addr_limit_3 = (io_addr_base_3 + 'h0000_00FF);
	
	wishbone_test_master_32_32_4 u_m0 (
			.clock           (clk          ), 
			.reset           (!rstn          ), 
			.io_addr_base_0  (io_addr_base_0 ), 
			.io_addr_base_1  (io_addr_base_1 ), 
			.io_addr_base_2  (io_addr_base_2 ), 
			.io_addr_base_3  (io_addr_base_3 ), 
			.io_m_ADR        (m02ic.ADR       ), 
			.io_m_TGA        (m02ic.TGA       ), 
			.io_m_CTI        (m02ic.CTI       ), 
			.io_m_BTE        (m02ic.BTE       ), 
			.io_m_DAT_W      (m02ic.DAT_W     ), 
			.io_m_TGD_W      (m02ic.TGD_W     ), 
			.io_m_DAT_R      (m02ic.DAT_R     ), 
			.io_m_TGD_R      (m02ic.TGD_R     ), 
			.io_m_CYC        (m02ic.CYC       ), 
			.io_m_TGC        (m02ic.TGC       ), 
			.io_m_ERR        (m02ic.ERR       ), 
			.io_m_SEL        (m02ic.SEL       ), 
			.io_m_STB        (m02ic.STB       ), 
			.io_m_ACK        (m02ic.ACK       ), 
			.io_m_WE         (m02ic.WE        ));

	wishbone_test_master_32_32_4 u_m1 (
			.clock           (clk          ), 
			.reset           (!rstn          ), 
			.io_addr_base_0  (io_addr_base_0 ), 
			.io_addr_base_1  (io_addr_base_1 ), 
			.io_addr_base_2  (io_addr_base_2 ), 
			.io_addr_base_3  (io_addr_base_3 ), 
			.io_m_ADR        (m12ic.ADR       ), 
			.io_m_TGA        (m12ic.TGA       ), 
			.io_m_CTI        (m12ic.CTI       ), 
			.io_m_BTE        (m12ic.BTE       ), 
			.io_m_DAT_W      (m12ic.DAT_W     ), 
			.io_m_TGD_W      (m12ic.TGD_W     ), 
			.io_m_DAT_R      (m12ic.DAT_R     ), 
			.io_m_TGD_R      (m12ic.TGD_R     ), 
			.io_m_CYC        (m12ic.CYC       ), 
			.io_m_TGC        (m12ic.TGC       ), 
			.io_m_ERR        (m12ic.ERR       ), 
			.io_m_SEL        (m12ic.SEL       ), 
			.io_m_STB        (m12ic.STB       ), 
			.io_m_ACK        (m12ic.ACK       ), 
			.io_m_WE         (m12ic.WE        ));

`ifdef CHISEL_WB_IC
	wishbone_ic_32_32_2x4 wishbone_ic_32_32_2x4 (
		.clock            (clk           ), 
		.reset            (!rstn           ), 
		.io_addr_base_0   (io_addr_base_0  ), 
		.io_addr_base_1   (io_addr_base_1  ), 
		.io_addr_base_2   (io_addr_base_2  ), 
		.io_addr_base_3   (io_addr_base_3  ), 
		.io_addr_limit_0  (io_addr_limit_0 ), 
		.io_addr_limit_1  (io_addr_limit_1 ), 
		.io_addr_limit_2  (io_addr_limit_2 ), 
		.io_addr_limit_3  (io_addr_limit_3 ), 
		.io_m_0_ADR       (m02ic.ADR      ), 
		.io_m_0_TGA       (m02ic.TGA      ), 
		.io_m_0_CTI       (m02ic.CTI      ), 
		.io_m_0_BTE       (m02ic.BTE      ), 
		.io_m_0_DAT_W     (m02ic.DAT_W    ), 
		.io_m_0_TGD_W     (m02ic.TGD_W    ), 
		.io_m_0_DAT_R     (m02ic.DAT_R    ), 
		.io_m_0_TGD_R     (m02ic.TGD_R    ), 
		.io_m_0_CYC       (m02ic.CYC      ), 
		.io_m_0_TGC       (m02ic.TGC      ), 
		.io_m_0_ERR       (m02ic.ERR      ), 
		.io_m_0_SEL       (m02ic.SEL      ), 
		.io_m_0_STB       (m02ic.STB      ), 
		.io_m_0_ACK       (m02ic.ACK      ), 
		.io_m_0_WE        (m02ic.WE       ), 
		.io_m_1_ADR       (m12ic.ADR      ), 
		.io_m_1_TGA       (m12ic.TGA      ), 
		.io_m_1_CTI       (m12ic.CTI      ), 
		.io_m_1_BTE       (m12ic.BTE      ), 
		.io_m_1_DAT_W     (m12ic.DAT_W    ), 
		.io_m_1_TGD_W     (m12ic.TGD_W    ), 
		.io_m_1_DAT_R     (m12ic.DAT_R    ), 
		.io_m_1_TGD_R     (m12ic.TGD_R    ), 
		.io_m_1_CYC       (m12ic.CYC      ), 
		.io_m_1_TGC       (m12ic.TGC      ), 
		.io_m_1_ERR       (m12ic.ERR      ), 
		.io_m_1_SEL       (m12ic.SEL      ), 
		.io_m_1_STB       (m12ic.STB      ), 
		.io_m_1_ACK       (m12ic.ACK      ), 
		.io_m_1_WE        (m12ic.WE       ), 
		.io_s_0_ADR       (ic2s0.ADR      ), 
		.io_s_0_TGA       (ic2s0.TGA      ), 
		.io_s_0_CTI       (ic2s0.CTI      ), 
		.io_s_0_BTE       (ic2s0.BTE      ), 
		.io_s_0_DAT_W     (ic2s0.DAT_W    ), 
		.io_s_0_TGD_W     (ic2s0.TGD_W    ), 
		.io_s_0_DAT_R     (ic2s0.DAT_R    ), 
		.io_s_0_TGD_R     (ic2s0.TGD_R    ), 
		.io_s_0_CYC       (ic2s0.CYC      ), 
		.io_s_0_TGC       (ic2s0.TGC      ), 
		.io_s_0_ERR       (ic2s0.ERR      ), 
		.io_s_0_SEL       (ic2s0.SEL      ), 
		.io_s_0_STB       (ic2s0.STB      ), 
		.io_s_0_ACK       (ic2s0.ACK      ), 
		.io_s_0_WE        (ic2s0.WE       ), 
		.io_s_1_ADR       (ic2s1.ADR      ), 
		.io_s_1_TGA       (ic2s1.TGA      ), 
		.io_s_1_CTI       (ic2s1.CTI      ), 
		.io_s_1_BTE       (ic2s1.BTE      ), 
		.io_s_1_DAT_W     (ic2s1.DAT_W    ), 
		.io_s_1_TGD_W     (ic2s1.TGD_W    ), 
		.io_s_1_DAT_R     (ic2s1.DAT_R    ), 
		.io_s_1_TGD_R     (ic2s1.TGD_R    ), 
		.io_s_1_CYC       (ic2s1.CYC      ), 
		.io_s_1_TGC       (ic2s1.TGC      ), 
		.io_s_1_ERR       (ic2s1.ERR      ), 
		.io_s_1_SEL       (ic2s1.SEL      ), 
		.io_s_1_STB       (ic2s1.STB      ), 
		.io_s_1_ACK       (ic2s1.ACK      ), 
		.io_s_1_WE        (ic2s1.WE       ), 
		.io_s_2_ADR       (ic2s2.ADR      ), 
		.io_s_2_TGA       (ic2s2.TGA      ), 
		.io_s_2_CTI       (ic2s2.CTI      ), 
		.io_s_2_BTE       (ic2s2.BTE      ), 
		.io_s_2_DAT_W     (ic2s2.DAT_W    ), 
		.io_s_2_TGD_W     (ic2s2.TGD_W    ), 
		.io_s_2_DAT_R     (ic2s2.DAT_R    ), 
		.io_s_2_TGD_R     (ic2s2.TGD_R    ), 
		.io_s_2_CYC       (ic2s2.CYC      ), 
		.io_s_2_TGC       (ic2s2.TGC      ), 
		.io_s_2_ERR       (ic2s2.ERR      ), 
		.io_s_2_SEL       (ic2s2.SEL      ), 
		.io_s_2_STB       (ic2s2.STB      ), 
		.io_s_2_ACK       (ic2s2.ACK      ), 
		.io_s_2_WE        (ic2s2.WE       ), 
		.io_s_3_ADR       (ic2s3.ADR      ), 
		.io_s_3_TGA       (ic2s3.TGA      ), 
		.io_s_3_CTI       (ic2s3.CTI      ), 
		.io_s_3_BTE       (ic2s3.BTE      ), 
		.io_s_3_DAT_W     (ic2s3.DAT_W    ), 
		.io_s_3_TGD_W     (ic2s3.TGD_W    ), 
		.io_s_3_DAT_R     (ic2s3.DAT_R    ), 
		.io_s_3_TGD_R     (ic2s3.TGD_R    ), 
		.io_s_3_CYC       (ic2s3.CYC      ), 
		.io_s_3_TGC       (ic2s3.TGC      ), 
		.io_s_3_ERR       (ic2s3.ERR      ), 
		.io_s_3_SEL       (ic2s3.SEL      ), 
		.io_s_3_STB       (ic2s3.STB      ), 
		.io_s_3_ACK       (ic2s3.ACK      ), 
		.io_s_3_WE        (ic2s3.WE       ));
`else
	wb_interconnect_2x4 #(
		.WB_ADDR_WIDTH      (WB_ADDR_WIDTH     ), 
		.WB_DATA_WIDTH      (WB_DATA_WIDTH     ), 
		.SLAVE0_ADDR_BASE   ('h0000_0000  ), 
		.SLAVE0_ADDR_LIMIT  ('h0000_00FF ), 
		.SLAVE1_ADDR_BASE   ('h0000_0100  ), 
		.SLAVE1_ADDR_LIMIT  ('h0000_01FF ), 
		.SLAVE2_ADDR_BASE   ('h0000_0200  ), 
		.SLAVE2_ADDR_LIMIT  ('h0000_02FF ), 
		.SLAVE3_ADDR_BASE   ('h0000_0300  ), 
		.SLAVE3_ADDR_LIMIT  ('h0000_03FF )
		) u_ic (
		.clk                (clk               ), 
		.rstn               (rstn              ), 
		.m0                 (m02ic.slave           ), 
		.m1                 (m12ic.slave                ), 
		.s0                 (ic2s0.master                ), 
		.s1                 (ic2s1.master                ), 
		.s2                 (ic2s2.master                ), 
		.s3                 (ic2s3.master                ));
		
`endif
	
//	localparam CNT_BIT = 4;
	localparam CNT_BIT = 13;

	always @(posedge clk) begin
		if (rstn == 0) begin
			led <= 0; 
			s0_acc_cnt <= 0;
			s1_acc_cnt <= 0;
			s2_acc_cnt <= 0;
			s3_acc_cnt <= 0;
		end else begin
			if (ic2s0.CYC && ic2s0.ACK) begin
				if (s0_acc_cnt[CNT_BIT]) begin
					led[0] <= ~led[0];
					s0_acc_cnt <= 0;
				end else begin
					s0_acc_cnt <= s0_acc_cnt+1;
				end
			end
			if (ic2s1.CYC && ic2s1.ACK) begin
				if (s1_acc_cnt[CNT_BIT]) begin
					led[1] <= ~led[1];
					s1_acc_cnt <= 0;
				end else begin
					s1_acc_cnt <= s1_acc_cnt+1;
				end
			end
			if (ic2s2.CYC && ic2s2.ACK) begin
				if (s2_acc_cnt[CNT_BIT]) begin
					led[2] <= ~led[2];
					s2_acc_cnt <= 0;
				end else begin
					s2_acc_cnt <= s2_acc_cnt+1;
				end
			end
			if (ic2s3.CYC && ic2s3.ACK) begin
				if (s3_acc_cnt[CNT_BIT]) begin
					led[3] <= ~led[3];
					s3_acc_cnt <= 0;
				end else begin
					s3_acc_cnt <= s3_acc_cnt+1;
				end
			end
		end
	end
//	assign led0 = (ic2s0.CYC & ^ic2s0.DAT_R);
//	assign led1 = (ic2s1.CYC & ^ic2s1.DAT_R);
//	assign led2 = (ic2s2.CYC & ^ic2s2.DAT_R);
//	assign led3 = (ic2s3.CYC & ^ic2s3.DAT_R);
	
	wb_sram #(
			.MEM_ADDR_BITS     (14    ), 
			.WB_ADDRESS_WIDTH  (WB_ADDR_WIDTH ), 
			.WB_DATA_WIDTH     (WB_DATA_WIDTH ) 
		) u_sram0 (
			.clk               (clk              ), 
			.rstn              (rstn             ), 
			.s                 (ic2s0.slave        ));	
	wb_sram #(
			.MEM_ADDR_BITS     (14    ), 
			.WB_ADDRESS_WIDTH  (WB_ADDR_WIDTH ), 
			.WB_DATA_WIDTH     (WB_DATA_WIDTH ) 
		) u_sram1 (
			.clk               (clk              ), 
			.rstn              (rstn             ), 
			.s                 (ic2s1.slave        ));	
	wb_sram #(
			.MEM_ADDR_BITS     (14    ), 
			.WB_ADDRESS_WIDTH  (WB_ADDR_WIDTH ), 
			.WB_DATA_WIDTH     (WB_DATA_WIDTH ) 
		) u_sram2 (
			.clk               (clk              ), 
			.rstn              (rstn             ), 
			.s                 (ic2s2.slave        ));	
	wb_sram #(
			.MEM_ADDR_BITS     (14    ), 
			.WB_ADDRESS_WIDTH  (WB_ADDR_WIDTH ), 
			.WB_DATA_WIDTH     (WB_DATA_WIDTH ) 
		) u_sram3 (
			.clk               (clk              ), 
			.rstn              (rstn             ), 
			.s                 (ic2s3.slave        ));	

endmodule


