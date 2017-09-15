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
	
	wire s_0_CYC;
	
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
		.io_m_0_req_ADR       (m02ic.ADR      ), 
		.io_m_0_req_TGA       (m02ic.TGA      ), 
		.io_m_0_req_CTI       (m02ic.CTI      ), 
		.io_m_0_req_BTE       (m02ic.BTE      ), 
		.io_m_0_req_DAT_W     (m02ic.DAT_W    ), 
		.io_m_0_req_TGD_W     (m02ic.TGD_W    ), 
		.io_m_0_rsp_DAT_R     (m02ic.DAT_R    ), 
		.io_m_0_rsp_TGD_R     (m02ic.TGD_R    ), 
		.io_m_0_req_CYC       (m02ic.CYC      ), 
		.io_m_0_req_TGC       (m02ic.TGC      ), 
		.io_m_0_rsp_ERR       (m02ic.ERR      ), 
		.io_m_0_req_SEL       (m02ic.SEL      ), 
		.io_m_0_req_STB       (m02ic.STB      ), 
		.io_m_0_rsp_ACK       (m02ic.ACK      ), 
		.io_m_0_req_WE        (m02ic.WE       ), 
		.io_m_1_req_ADR       (m12ic.ADR      ), 
		.io_m_1_req_TGA       (m12ic.TGA      ), 
		.io_m_1_req_CTI       (m12ic.CTI      ), 
		.io_m_1_req_BTE       (m12ic.BTE      ), 
		.io_m_1_req_DAT_W     (m12ic.DAT_W    ), 
		.io_m_1_req_TGD_W     (m12ic.TGD_W    ), 
		.io_m_1_rsp_DAT_R     (m12ic.DAT_R    ), 
		.io_m_1_rsp_TGD_R     (m12ic.TGD_R    ), 
		.io_m_1_req_CYC       (m12ic.CYC      ), 
		.io_m_1_req_TGC       (m12ic.TGC      ), 
		.io_m_1_rsp_ERR       (m12ic.ERR      ), 
		.io_m_1_req_SEL       (m12ic.SEL      ), 
		.io_m_1_req_STB       (m12ic.STB      ), 
		.io_m_1_rsp_ACK       (m12ic.ACK      ), 
		.io_m_1_req_WE        (m12ic.WE       ), 
		.io_s_0_req_ADR       (ic2s0.ADR      ), 
		.io_s_0_req_TGA       (ic2s0.TGA      ), 
		.io_s_0_req_CTI       (ic2s0.CTI      ), 
		.io_s_0_req_BTE       (ic2s0.BTE      ), 
		.io_s_0_req_DAT_W     (ic2s0.DAT_W    ), 
		.io_s_0_req_TGD_W     (ic2s0.TGD_W    ), 
		.io_s_0_rsp_DAT_R     (ic2s0.DAT_R    ), 
		.io_s_0_rsp_TGD_R     (ic2s0.TGD_R    ), 
		.io_s_0_req_CYC       (ic2s0.CYC      ), 
//		.io_s_0_CYC       (s_0_CYC      ), 
		.io_s_0_req_TGC       (ic2s0.TGC      ), 
		.io_s_0_rsp_ERR       (ic2s0.ERR      ), 
		.io_s_0_req_SEL       (ic2s0.SEL      ), 
		.io_s_0_req_STB       (ic2s0.STB      ), 
		.io_s_0_rsp_ACK       (ic2s0.ACK      ), 
		.io_s_0_req_WE        (ic2s0.WE       ), 
		.io_s_1_req_ADR       (ic2s1.ADR      ), 
		.io_s_1_req_TGA       (ic2s1.TGA      ), 
		.io_s_1_req_CTI       (ic2s1.CTI      ), 
		.io_s_1_req_BTE       (ic2s1.BTE      ), 
		.io_s_1_req_DAT_W     (ic2s1.DAT_W    ), 
		.io_s_1_req_TGD_W     (ic2s1.TGD_W    ), 
		.io_s_1_rsp_DAT_R     (ic2s1.DAT_R    ), 
		.io_s_1_rsp_TGD_R     (ic2s1.TGD_R    ), 
		.io_s_1_req_CYC       (ic2s1.CYC      ), 
		.io_s_1_req_TGC       (ic2s1.TGC      ), 
		.io_s_1_rsp_ERR       (ic2s1.ERR      ), 
		.io_s_1_req_SEL       (ic2s1.SEL      ), 
		.io_s_1_req_STB       (ic2s1.STB      ), 
		.io_s_1_rsp_ACK       (ic2s1.ACK      ), 
		.io_s_1_req_WE        (ic2s1.WE       ), 
		.io_s_2_req_ADR       (ic2s2.ADR      ), 
		.io_s_2_req_TGA       (ic2s2.TGA      ), 
		.io_s_2_req_CTI       (ic2s2.CTI      ), 
		.io_s_2_req_BTE       (ic2s2.BTE      ), 
		.io_s_2_req_DAT_W     (ic2s2.DAT_W    ), 
		.io_s_2_req_TGD_W     (ic2s2.TGD_W    ), 
		.io_s_2_rsp_DAT_R     (ic2s2.DAT_R    ), 
		.io_s_2_rsp_TGD_R     (ic2s2.TGD_R    ), 
		.io_s_2_req_CYC       (ic2s2.CYC      ), 
		.io_s_2_req_TGC       (ic2s2.TGC      ), 
		.io_s_2_rsp_ERR       (ic2s2.ERR      ), 
		.io_s_2_req_SEL       (ic2s2.SEL      ), 
		.io_s_2_req_STB       (ic2s2.STB      ), 
		.io_s_2_rsp_ACK       (ic2s2.ACK      ), 
		.io_s_2_req_WE        (ic2s2.WE       ), 
		.io_s_3_req_ADR       (ic2s3.ADR      ), 
		.io_s_3_req_TGA       (ic2s3.TGA      ), 
		.io_s_3_req_CTI       (ic2s3.CTI      ), 
		.io_s_3_req_BTE       (ic2s3.BTE      ), 
		.io_s_3_req_DAT_W     (ic2s3.DAT_W    ), 
		.io_s_3_req_TGD_W     (ic2s3.TGD_W    ), 
		.io_s_3_rsp_DAT_R     (ic2s3.DAT_R    ), 
		.io_s_3_rsp_TGD_R     (ic2s3.TGD_R    ), 
		.io_s_3_req_CYC       (ic2s3.CYC      ), 
		.io_s_3_req_TGC       (ic2s3.TGC      ), 
		.io_s_3_rsp_ERR       (ic2s3.ERR      ), 
		.io_s_3_req_SEL       (ic2s3.SEL      ), 
		.io_s_3_req_STB       (ic2s3.STB      ), 
		.io_s_3_rsp_ACK       (ic2s3.ACK      ), 
		.io_s_3_req_WE        (ic2s3.WE       ));
	
	typedef wb_master_config #(WB_ADDR_WIDTH, WB_DATA_WIDTH) wb_master_config_t;
	
	initial begin
		automatic wb_master_config_t m0_cfg = wb_master_config_t::type_id::create("m0_cfg");
		automatic wb_master_config_t m1_cfg = wb_master_config_t::type_id::create("m1_cfg");
		
		m0_cfg.vif = m0.u_core;
		m1_cfg.vif = m1.u_core;
	
		uvm_config_db #(wb_master_config_t)::set(uvm_top, "*m_m0_agent*", 
				wb_master_config_t::report_id, m0_cfg);
		uvm_config_db #(wb_master_config_t)::set(uvm_top, "*m_m1_agent*", 
				wb_master_config_t::report_id, m1_cfg);
		
		
		run_test();
	end

endmodule

