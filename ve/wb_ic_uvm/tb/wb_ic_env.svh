
class wb_ic_env extends uvm_env;
	`uvm_component_utils(wb_ic_env)

	localparam ADDRESS_WIDTH = 32;
	localparam DATA_WIDTH = 32;
	typedef wb_master_agent #(ADDRESS_WIDTH, DATA_WIDTH) wb_master_agent_t;
	
	wb_master_agent_t				m_m0_agent;
	wb_master_agent_t				m_m1_agent;

	function new(string name, uvm_component parent=null);
		super.new(name, parent);
	endfunction
	
	/**
	 * Function: build_phase
	 *
	 * Override from class uvm_component
	 */
	virtual function void build_phase(input uvm_phase phase);
		super.build_phase(phase);
		
		m_m0_agent = wb_master_agent_t::type_id::create("m_m0_agent", this);
		m_m1_agent = wb_master_agent_t::type_id::create("m_m1_agent", this);
	endfunction

	/**
	 * Function: connect_phase
	 *
	 * Override from class uvm_component
	 */
	virtual function void connect_phase(input uvm_phase phase);
		super.connect_phase(phase);
	endfunction
	
	
endclass
