`ifndef AMP_AGENT_SV
`define AMP_AGENT_SV

class amp_agent extends uvm_agent;
    virtual amp_interface vif;

    amp_sequencer   sqr;
    amp_driver      drv;
    amp_monitor     mon;

    `uvm_component_utils(amp_agent)

    extern function      new(string name = "amp_agent", uvm_component parent = null);
    extern function void build_phase(uvm_phase phase);
    extern function void connect_phase(uvm_phase phase);
endclass : amp_agent

function amp_agent::new(string name = "amp_agent", uvm_component parent = null);
    super.new(name, parent);

    `uvm_info(get_type_name(), "created", UVM_LOW)
endfunction : new

function void amp_agent::build_phase(uvm_phase phase);
    super.build_phase(phase);

    if(!uvm_config_db #(virtual amp_interface)::get(this, "", "vif", vif))
        `uvm_error("NO VIF", {"virtual interface must be set for: ", get_full_name()})

    mon = amp_monitor::type_id::create("mon", this);
    mon.vif = vif;
    
    if(is_active == UVM_ACTIVE) begin
        sqr = amp_sequencer::type_id::create("sqr", this);
        drv = amp_driver::type_id::create("drv", this);
        drv.vif = vif;
        mon.mon_input = 1;
    end
endfunction : build_phase

function void amp_agent::connect_phase(uvm_phase phase);
	super.connect_phase(phase);

	if(is_active == UVM_ACTIVE) begin
		drv.seq_item_port.connect(sqr.seq_item_export);
		`uvm_info(get_type_name(), "driver and sequencer connected", UVM_LOW)
	end
endfunction : connect_phase

`endif // AMP_AGENT_SV