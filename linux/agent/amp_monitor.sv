`ifndef AMP_MONITOR_SV
`define AMP_MONITOR_SV

class amp_monitor extends uvm_monitor;
    `uvm_component_utils(amp_monitor)

    int mon_item_num;
    bit mon_input = 0;	// defualt: monitor belongs to output agent
	
    amp_seq_item t;

    virtual amp_interface vif = null;

    uvm_analysis_port #(amp_seq_item) ap;

    extern function 	 new(string name = "amp_monitor", uvm_component parent = null);
    extern function void build_phase(uvm_phase phase);
    extern task 		 main_phase(uvm_phase phase);
    extern function void report_phase(uvm_phase phase);

    extern protected task collect_item(amp_seq_item t);
endclass : amp_monitor

function amp_monitor::new(string name = "amp_monitor", uvm_component parent = null);
	super.new(name, parent);

	`uvm_info(get_type_name(), "created", UVM_LOW)
endfunction : new

function void amp_monitor::build_phase(uvm_phase phase);
	super.build_phase(phase);

	ap = new("ap", this);
	mon_item_num = 0;
endfunction : build_phase

task amp_monitor::main_phase(uvm_phase phase);
	super.main_phase(phase);

	forever begin
		@vif.ck_mon;
		t = amp_seq_item::type_id::create("t");
		this.collect_item(t);
		`uvm_info(get_type_name(), {"collect item t:\n", t.sprint()}, UVM_FULL)

		if(mon_input && t.ttype == amp_seq_item::SET_BASE_NUMBER) begin
			mon_item_num += 1;
			ap.write(t);
			`uvm_info(get_type_name(), {"i_mon catch t:\n", t.sprint()}, UVM_FULL)
		end
		else if(t.rd_valid) begin
			mon_item_num += 1;
			ap.write(t);
			`uvm_info(get_type_name(), {"o_mon catch t:\n", t.sprint()}, UVM_FULL)
		end
	end
endtask : main_phase

function void amp_monitor::report_phase(uvm_phase phase);
	super.report_phase(phase);

	`uvm_info(get_type_name(), $sformatf("mon_item_num: %0d", mon_item_num), UVM_LOW)
endfunction : report_phase

task amp_monitor::collect_item(amp_seq_item t);
	if(mon_input) begin	// i_agt
		// set scaler
		if(vif.ck_mon.wr_en_i && vif.ck_mon.set_scaler_i) begin
			t.ttype 		= amp_seq_item::SET_SCALER;
			t.no			= 0;
			t.base_number	= 0;
			t.scaler		= vif.ck_mon.wr_data_i;
			t.rd_scaler		= vif.ck_mon.scaler_o;
		end
		// set base number
		else if(vif.ck_mon.wr_en_i && !vif.ck_mon.set_scaler_i) begin
			t.ttype 		= amp_seq_item::SET_BASE_NUMBER;
			t.no			= vif.ck_mon.wr_data_i[15:8];
			t.base_number	= vif.ck_mon.wr_data_i[7:0];
			t.rd_scaler		= vif.ck_mon.scaler_o;
		end
		// idle
		else begin
			t.ttype			= amp_seq_item::IDLE;
		end
	end
	else begin // o_agt
		t.rd_valid	= vif.ck_mon.rd_val_o;
		t.no		= vif.ck_mon.rd_data_o[31:24];
		t.rd_data	= vif.ck_mon.rd_data_o[23:0];
	end
endtask : collect_item

`endif // AMP_MONITOR_SV
