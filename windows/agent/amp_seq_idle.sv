`ifndef AMP_SEQ_IDLE_SV
`define AMP_SEQ_IDLE_SV 

class amp_seq_idle extends uvm_sequence #(amp_seq_item);
	`uvm_object_utils(amp_seq_idle)

	rand int delay;

	extern function new(string name = "amp_seq_idle");
	extern virtual task	body();
endclass : amp_seq_idle

function amp_seq_idle::new(string name = "amp_seq_idle");
	super.new(name);

	`uvm_info(get_type_name(), "created", UVM_HIGH)
endfunction : new

task amp_seq_idle::body();
	`uvm_do_with(req, {
		ttype 		== amp_seq_item::IDLE;
		no			== 0;
		delay		== local::delay;
	})
	get_response(rsp);
endtask : body

`endif // AMP_SEQ_IDLE_SV