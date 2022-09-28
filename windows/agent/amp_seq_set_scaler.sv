`ifndef AMP_SEQ_SET_SCALER_SV
`define AMP_SEQ_SET_SCALER_SV

class amp_seq_set_scaler extends uvm_sequence #(amp_seq_item);
	`uvm_object_utils(amp_seq_set_scaler)

	rand bit [15:0] scaler;

	extern function new(string name = "amp_seq_set_scaler");
	extern virtual task	body();
endclass : amp_seq_set_scaler

function amp_seq_set_scaler::new(string name = "amp_seq_set_scaler");
	super.new(name);

	`uvm_info(get_type_name(), "created", UVM_HIGH)
endfunction : new

task amp_seq_set_scaler::body();
	`uvm_do_with(req, {
		ttype 		== amp_seq_item::SET_SCALER;
		no			== 0;
		base_number	== 0;
		scaler		== local::scaler;
		delay		== 0;
	})
	get_response(rsp);
endtask : body

`endif // AMP_SEQ_SET_SCALER_SV