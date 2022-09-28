`ifndef AMP_ENV_REFM_SV
`define AMP_ENV_REFM_SV

import "DPI-C" context function int amplifier(input int base_number, int scaler);

class amp_env_refm extends uvm_component;
    `uvm_component_utils(amp_env_refm)

    uvm_blocking_get_port #(amp_seq_item)	gp;
    uvm_analysis_port #(amp_seq_item)		ap;

    amp_seq_item t;
    amp_seq_item scb_t;

    int res;

    extern function      new(string name = "amp_env_refm", uvm_component parent = null);
    extern function void build_phase(uvm_phase phase);
    extern task          main_phase(uvm_phase phase);
endclass : amp_env_refm

function amp_env_refm::new(string name = "amp_env_refm", uvm_component parent = null);
	super.new(name, parent);

	`uvm_info(get_type_name(), "created", UVM_LOW)
endfunction : new

function void amp_env_refm::build_phase(uvm_phase phase);
	super.build_phase(phase);

	gp = new("gp", this);
	ap = new("ap", this);
endfunction : build_phase

task amp_env_refm::main_phase(uvm_phase phase);
	super.main_phase(phase);

	while(1) begin
		t = new("t");
		scb_t = new("scb_t");

		gp.get(t);
		scb_t.copy(t);

		res = amplifier(t.base_number, t.rd_scaler);	// use DPI-C

		scb_t.rd_data = res;
		ap.write(scb_t);
	end
endtask : main_phase

`endif // AMP_ENV_REFM_SV
