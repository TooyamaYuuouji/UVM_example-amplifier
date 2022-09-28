`ifndef AMP_AGENT_CONFIG_SV
`define AMP_AGENT_CONFIG_SV

class amp_agent_config extends uvm_object;
    uvm_active_passive_enum i_agt_is_active = UVM_PASSIVE;
    uvm_active_passive_enum o_agt_is_active = UVM_PASSIVE;

    `uvm_object_utils(amp_agent_config)

    extern function new(string name = "amp_agent_config");
endclass : amp_agent_config

function amp_agent_config::new(string name = "amp_agent_config");
    super.new(name);
    
    `uvm_info(get_type_name(), "created", UVM_LOW)
endfunction : new

`endif // AMP_AGENT_CONFIG_SV