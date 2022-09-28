`ifndef AMP_SEQ_SET_BASE_NUMBER_SV
`define AMP_SEQ_SET_BASE_NUMBER_SV 

class amp_seq_set_base_number extends uvm_sequence #(amp_seq_item);
	`uvm_object_utils(amp_seq_set_base_number)

	rand bit [7:0] base_number;
	rand int delay;

	extern function new(string name = "amp_seq_set_base_number");
	extern virtual task	body();
endclass : amp_seq_set_base_number

function amp_seq_set_base_number::new(string name = "amp_seq_set_base_number");
	super.new(name);

	`uvm_info(get_type_name(), "created", UVM_HIGH)
endfunction : new

task amp_seq_set_base_number::body();
	`uvm_do_with(req, {
		ttype 		== amp_seq_item::SET_BASE_NUMBER;
		no			== 0;
		base_number	== local::base_number;
		scaler		== 0;
		delay		== 0;
	})
	get_response(rsp);
endtask : body

`endif // AMP_SEQ_SET_BASE_NUMBER_SV