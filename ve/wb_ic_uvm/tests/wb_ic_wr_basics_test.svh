
class wb_ic_wr_basics_test extends wb_ic_test_base;
	
	`uvm_component_utils(wb_ic_wr_basics_test)
	
	function new(string name, uvm_component parent=null);
		super.new(name,parent);
	endfunction
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction

	/**
	 * Task: run_phase
	 *
	 * Override from class 
	 */
	virtual task run_phase(input uvm_phase phase);
		sv_bfms_rw_api_if m0_api, m1_api;
		
		phase.raise_objection(this, "Main");
		
		m0_api = m_env.m_m0_agent.get_api();
		m1_api = m_env.m_m1_agent.get_api();
		
		fork 
			begin
				for (int i=0; i<16; i++) begin
					int base = ((i%4) * 'h1000);
					bit[31:0] data;
					m0_api.write32(base+4*(i+1), (i+1));
					m0_api.read32(base+4*(i+1), data);
					
					if (data != (i+1)) begin
						$display("Error [M0]: expect 'h%04h received 'h%04h",
								(i+1), data);
					end
				end
			end
			begin
				for (int i=0; i<16; i++) begin
					int base = ((i%4) * 'h1000) + 'h100;
					bit[31:0] data;
					m1_api.write32(base+8*(i+1), (i+2));
					m1_api.read32(base+8*(i+1), data);
					if (data != (i+2)) begin
						$display("Error [M1]: expect 'h%04h received 'h%04h",
								(i+2), data);
					end
				end
			end
		join
		
		phase.drop_objection(this, "Main");
	endtask

	
	
endclass

