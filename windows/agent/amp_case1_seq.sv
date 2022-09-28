`ifndef AMP_CASE1_SEQ_SV
`define AMP_CASE1_SEQ_SV

class amp_case1_seq extends uvm_sequence #(amp_seq_item);
	`uvm_object_utils(amp_case1_seq)

	randc bit [7:0] base_number;
		  bit [7:0] no;

	randc int burst_num;

	amp_seq_set_scaler 		seq_scaler;
	amp_seq_set_base_number seq_base_number;
	amp_seq_idle 			seq_idle;

	extern function new(string name = "amp_case1_seq");
	extern task body();
endclass : amp_case1_seq

function amp_case1_seq::new(string name = "amp_case1_seq");
	super.new(name);

	`uvm_info(get_type_name(), "sequence created", UVM_LOW)
endfunction : new

task amp_case1_seq::body();
	if(starting_phase != null) 
		starting_phase.raise_objection(this);

	`uvm_do_with(seq_idle, {delay == 10;})

	no = 0;
	repeat(10) begin
		`uvm_do(seq_scaler)
		`uvm_do_with(seq_idle, {delay == 1;})
		void'(std::randomize(burst_num) with {burst_num inside {[1:5]};});
		`uvm_info(get_type_name(), $sformatf("burst_num is: %0d", burst_num), UVM_LOW)

		repeat(burst_num) begin
			no += 1;
			`uvm_do_with(seq_base_number, {
				no			== local::no;
				base_number == local::base_number;
			})
		end
		`uvm_do_with(seq_idle, {delay == 1;})
	end

	repeat(3) `uvm_do_with(seq_idle, {delay == 1;})

	if(starting_phase != null) 
		starting_phase.drop_objection(this);
endtask : body

`endif // AMP_CASE1_SEQ_SV