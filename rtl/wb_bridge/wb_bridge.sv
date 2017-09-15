/****************************************************************************
 * wb_bridge.sv
 ****************************************************************************/

/**
 * Module: wb_bridge
 * 
 * Parameterized bridge to do width conversion
 */
module wb_bridge #(
		parameter int		ADDRESS_WIDTH=32,
		parameter int		IN_DATA_WIDTH=32,
		parameter int		OUT_DATA_WIDTH=8) (
		input			clk,
		input			rstn,
		wb_if.slave		in,
		wb_if.master	out);
	

	if (IN_DATA_WIDTH == 32) begin
		if (OUT_DATA_WIDTH == 8) begin
			// Bridge 32-bit to 8-bit bus
			// Low 2 bits of address change based on data mask
			// Error out on accesses != 8 (for now)
			
			// Just bridge control signals
			assign out.CYC = in.CYC;
			assign out.WE = in.WE;
			
			wire adr_low[1:0] = //priority encoder
				(in.SEL[1])?1:
				(in.SEL[2])?2:
				(in.SEL[3])?3:0;
				
			assign out.SEL = in.SEL[adr_low+:1];
			assign out.DAT_W = in.DAT_W[8*adr_low+:8]; // select 8 bits of data
		
			// How do we get appropriate lane?
			assign in.DAT_R = out.DAT_R;
			assign in.ACK = out.ACK;
			assign in.ERR = out.ERR;
		end else begin
			initial begin
				$display("Error %m: Unsupported OUT_DATA_WIDTH %0d", OUT_DATA_WIDTH);
			end
		end
	end else begin
		initial begin
			$display("Error %m: Unsupported IN_DATA_WIDTH %0d", IN_DATA_WIDTH);
		end
	end


endmodule


