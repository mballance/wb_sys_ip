/****************************************************************************
 * wb_test_master_tb.sv
 ****************************************************************************/

/**
 * Module: wb_test_master_tb
 * 
 * TODO: Add module documentation
 */
`include "uvm_macros.svh"
module wb_test_master_tb;
	import uvm_pkg::*;
	import wb_test_master_tests_pkg::*;
	
	reg clk = 0;
	reg rstn = 0;
	reg[7:0] rstn_cnt = 0;
	
	initial begin
		forever begin
			#10ns;
			clk <= ~clk;
		end
	end
	
	always @(posedge clk) begin
		if (rstn_cnt == 10) begin
			rstn <= 1;
		end else begin
			rstn_cnt <= rstn_cnt + 1;
		end
	end
	
	parameter WB_ADDR_WIDTH = 32;
	parameter WB_DATA_WIDTH = 32;
	
	wb_if #(
		.WB_ADDR_WIDTH  (WB_ADDR_WIDTH ), 
		.WB_DATA_WIDTH  (WB_DATA_WIDTH )
		) m2s ();
	
	wire [31:0] io_addr_base_0 = 'h0000_0000;
	wire [31:0] io_addr_base_1 = 'h0000_0100;
	wire [31:0] io_addr_base_2 = 'h0000_0200;
	wire [31:0] io_addr_base_3 = 'h0000_0300;
	
	wishbone_test_master_32_32_4 u_dut (
		.clock           (clk          ), 
		.reset           (!rstn          ), 
		.io_addr_base_0  (io_addr_base_0 ), 
		.io_addr_base_1  (io_addr_base_1 ), 
		.io_addr_base_2  (io_addr_base_2 ), 
		.io_addr_base_3  (io_addr_base_3 ), 
		.io_m_ADR        (m2s.ADR       ), 
		.io_m_TGA        (m2s.TGA       ), 
		.io_m_CTI        (m2s.CTI       ), 
		.io_m_BTE        (m2s.BTE       ), 
		.io_m_DAT_W      (m2s.DAT_W     ), 
		.io_m_TGD_W      (m2s.TGD_W     ), 
		.io_m_DAT_R      (m2s.DAT_R     ), 
		.io_m_TGD_R      (m2s.TGD_R     ), 
		.io_m_CYC        (m2s.CYC       ), 
		.io_m_TGC        (m2s.TGC       ), 
		.io_m_ERR        (m2s.ERR       ), 
		.io_m_SEL        (m2s.SEL       ), 
		.io_m_STB        (m2s.STB       ), 
		.io_m_ACK        (m2s.ACK       ), 
		.io_m_WE         (m2s.WE        ));
	
	wb_sram #(
		.MEM_ADDR_BITS     (14    ), 
		.WB_ADDRESS_WIDTH  (WB_ADDR_WIDTH ), 
		.WB_DATA_WIDTH     (WB_DATA_WIDTH ) 
		) wb_sram (
		.clk               (clk              ), 
		.rstn              (rstn             ), 
		.s                 (m2s.slave        ));
	
	initial begin
		run_test();
	end

endmodule

