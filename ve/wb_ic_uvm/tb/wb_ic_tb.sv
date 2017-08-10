/****************************************************************************
 * wb_ic_tb.sv
 ****************************************************************************/

/**
 * Module: wb_ic_tb
 * 
 * TODO: Add module documentation
 */
`include "uvm_macros.svh"
module wb_ic_tb;
	import uvm_pkg::*;
	import wb_ic_tests_pkg::*;
	import wb_master_agent_pkg::*;
	
	reg 		clk = 0;
	reg[7:0]	rst_cnt=0;
	reg			rstn = 0;
	
	initial begin
		forever begin
			#10ns;
			clk <= ~clk;
		end
	end
	
	always @(posedge clk) begin
		if (rst_cnt == 20) begin
			rstn <= 1;
		end else begin
			rst_cnt <= rst_cnt + 1;
		end
	end
	
	localparam int WB_ADDR_WIDTH = 32;
	localparam int WB_DATA_WIDTH = 32;
	
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
	
	wb_master_bfm #(
		.WB_ADDR_WIDTH  (WB_ADDR_WIDTH ), 
		.WB_DATA_WIDTH  (WB_DATA_WIDTH )
		) m0 (
		.clk            (clk           ), 
		.rstn           (rstn          ), 
		.master         (m02ic.master  ));
	
	wb_master_bfm #(
		.WB_ADDR_WIDTH  (WB_ADDR_WIDTH ), 
		.WB_DATA_WIDTH  (WB_DATA_WIDTH )
		) m1 (
		.clk            (clk           ), 
		.rstn           (rstn          ), 
		.master         (m12ic.master  ));

	wb_sram #(
		.MEM_ADDR_BITS     (10    ), 
		.WB_ADDRESS_WIDTH  (WB_ADDR_WIDTH ), 
		.WB_DATA_WIDTH     (WB_DATA_WIDTH )
		) u_s0 (
		.clk               (clk              ), 
		.rstn              (rstn             ), 
		.s                 (ic2s0.slave     ));
	
	wb_sram #(
		.MEM_ADDR_BITS     (10    ), 
		.WB_ADDRESS_WIDTH  (WB_ADDR_WIDTH ), 
		.WB_DATA_WIDTH     (WB_DATA_WIDTH )
		) u_s1 (
		.clk               (clk              ), 
		.rstn              (rstn             ), 
		.s                 (ic2s1.slave     ));
	
	wb_sram #(
		.MEM_ADDR_BITS     (10    ), 
		.WB_ADDRESS_WIDTH  (WB_ADDR_WIDTH ), 
		.WB_DATA_WIDTH     (WB_DATA_WIDTH )
		) u_s2 (
		.clk               (clk              ), 
		.rstn              (rstn             ), 
		.s                 (ic2s2.slave     ));
	
	wb_sram #(
		.MEM_ADDR_BITS     (10    ), 
		.WB_ADDRESS_WIDTH  (WB_ADDR_WIDTH ), 
		.WB_DATA_WIDTH     (WB_DATA_WIDTH )
		) u_s3 (
		.clk               (clk              ), 
		.rstn              (rstn             ), 
		.s                 (ic2s3.slave     ));
	
	wire[31:0] io_addr_base_0 = 'h0000_0000;
	wire[31:0] io_addr_limit_0 = 'h0000_0FFF;
	wire[31:0] io_addr_base_1 = 'h0000_1000;
	wire[31:0] io_addr_limit_1 = 'h0000_1FFF;
	wire[31:0] io_addr_base_2 = 'h0000_2000;
	wire[31:0] io_addr_limit_2 = 'h0000_2FFF;
	wire[31:0] io_addr_base_3 = 'h0000_3000;
	wire[31:0] io_addr_limit_3 = 'h0000_3FFF;
	
	wishbone_ic_32_32_2x4 u_ic (
		.clock            (clk           ), 
		.reset            (~rstn           ), 
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
	
	typedef wb_master_config #(WB_ADDR_WIDTH, WB_DATA_WIDTH) wb_master_config_t;
	
	initial begin
		automatic wb_master_config_t m0_cfg = wb_master_config_t::type_id::create("m0_cfg");
		automatic wb_master_config_t m1_cfg = wb_master_config_t::type_id::create("m1_cfg");
		
		m0_cfg.vif = m0.u_core;
		m1_cfg.vif = m1.u_core;
		
		
		
		run_test();
	end

endmodule

