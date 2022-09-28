`ifndef AMP_ENV_SCB_SV
`define AMP_ENV_SCB_SV

class amp_env_scb extends uvm_scoreboard;
    `uvm_component_utils(amp_env_scb);

    uvm_blocking_get_port #(amp_seq_item) exp_gp;
    uvm_blocking_get_port #(amp_seq_item) act_gp;

    amp_seq_item exp_t, act_t;

    int success_num, failure_num;

    extern function      new(string name = "amp_env_scb", uvm_component parent = null);
    extern function void build_phase(uvm_phase phase);
    extern task          main_phase(uvm_phase phase);
    extern function void report_phase(uvm_phase phase);
endclass : amp_env_scb

function amp_env_scb::new(string name = "amp_env_scb", uvm_component parent = null);
	super.new(name, parent);

	`uvm_info(get_type_name(), "created", UVM_LOW)
endfunction : new

function void amp_env_scb::build_phase(uvm_phase phase);
	super.build_phase(phase);

	exp_gp = new("exp_gp", this);
	act_gp = new("act_gp", this);

	success_num = 0;
	failure_num = 0;
endfunction : build_phase

task amp_env_scb::main_phase(uvm_phase phase);
	super.main_phase(phase);

	while(1) begin
		exp_gp.get(exp_t);
		act_gp.get(act_t);
		if(exp_t.no != act_t.no)
			`uvm_info(get_type_name(), $sformatf("no is different, exp_t.no: %0d, act_t.no: %0d", exp_t.no, act_t.no), UVM_LOW)
		else begin
			if(exp_t.rd_data == act_t.rd_data)
				success_num += 1;
			else begin
				failure_num += 1;
				`uvm_info(get_type_name(), $sformatf("exp_t: scaler: %0d, base_number: %0d, exp_res: %0d", exp_t.rd_scaler, exp_t.base_number, exp_t.rd_data), UVM_LOW)
				`uvm_info(get_type_name(), $sformatf("act_t: scaler: %0d, base_number: %0d, act_res: %0d", act_t.rd_scaler, act_t.base_number, act_t.rd_data), UVM_LOW)
				`uvm_error("SCORE ERROR", "actual rd_data is not equal with expect rd_data")
			end
		end
	end
endtask : main_phase

function void amp_env_scb::report_phase(uvm_phase phase);
	super.report_phase(phase);

	`uvm_info(get_type_name(), $sformatf("success_num: %0d", success_num), UVM_LOW)
	`uvm_info(get_type_name(), $sformatf("failure_num: %0d", failure_num), UVM_LOW)
endfunction : report_phase

`endif // AMP_ENV_SCB_SV