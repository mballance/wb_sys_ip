/****************************************************************************
 * wb_stub_sys_tb.sv
 ****************************************************************************/

/**
 * Module: wb_stub_sys_tb
 * 
 * TODO: Add module documentation
 */
`include "uvm_macros.svh"
module wb_stub_sys_tb;
	import uvm_pkg::*;
	import wb_stub_sys_tests_pkg::*;
	
	reg clk_i=0;
	
	initial begin
		forever begin
			#10ns;
			clk_i <= ~clk_i;
		end
	end
	
	wire led0, led1, led2, led3;
	
	wb_stub_sys wb_stub_sys (
		.clk_i  (clk_i ), 
		.led0   (led0  ), 
		.led1   (led1  ), 
		.led2   (led2  ), 
		.led3   (led3  ));
	
	
	initial begin
		run_test();
	end

endmodule

