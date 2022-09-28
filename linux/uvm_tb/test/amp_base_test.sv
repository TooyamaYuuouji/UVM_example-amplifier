`ifndef AMP_BASE_TEST_SV
`define AMP_BASE_TEST_SV

class amp_base_test extends uvm_test;
    amp_env          env;
    amp_agent_config agt_cfg;

    `uvm_component_utils(amp_base_test)

    extern function      new(string name = "amp_base_test", uvm_component parent);
    extern function void build_phase(uvm_phase phase);
    extern function void end_of_elaboration_phase(uvm_phase phase);
endclass : amp_base_test

function amp_base_test::new(string name = "amp_base_test", uvm_component parent);
    super.new(name, parent);

    `uvm_info(get_type_name(), "created", UVM_LOW)
endfunction : new

function void amp_base_test::build_phase(uvm_phase phase);
    super.build_phase(phase);

    env = amp_env::type_id::create("env", this);
    agt_cfg = amp_agent_config::type_id::create("agt_cfg");
    agt_cfg.i_agt_is_active = UVM_ACTIVE;

    uvm_config_db #(amp_agent_config)::set(this, "env", "agt_cfg", agt_cfg);
endfunction : build_phase

function void amp_base_test::end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);

    uvm_top.print_topology();
    `uvm_info(get_type_name(), $sformatf("Verbosity level is set to: %d", get_report_verbosity_level()), UVM_LOW)
    factory.print();
endfunction : end_of_elaboration_phase

`endif // AMP_BASE_TEST_SV