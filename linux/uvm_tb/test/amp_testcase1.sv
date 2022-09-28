`ifndef AMP_TESTCASE1_SV
`define AMP_TESTCASE1_SV

class amp_testcase1 extends amp_base_test;
    `uvm_component_utils(amp_testcase1)

    extern function new(string name = "amp_testcase1", uvm_component parent = null);
    extern function void build_phase(uvm_phase phase);
endclass : amp_testcase1

function amp_testcase1::new(string name = "amp_testcase1", uvm_component parent = null);
	super.new(name, parent);

	`uvm_info(get_type_name(), "created", UVM_LOW)
endfunction : new

function void amp_testcase1::build_phase(uvm_phase phase);
	super.build_phase(phase);

	uvm_config_db #(uvm_object_wrapper)::set(this, "env.i_agt.sqr.main_phase", "default_sequence", amp_case1_seq::type_id::get());
endfunction : build_phase

`endif // AMP_TESTCASE1_SV