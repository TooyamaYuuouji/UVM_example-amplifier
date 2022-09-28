`ifndef AMP_SEQUENCER_SV
`define AMP_SEQUENCER_SV

class amp_sequencer extends uvm_sequencer #(amp_seq_item);
    `uvm_component_utils(amp_sequencer)

    extern function new(string name = "amp_sequencer", uvm_component parent = null);
endclass : amp_sequencer

function amp_sequencer::new(string name = "amp_sequencer", uvm_component parent = null);
    super.new(name, parent);
    
    `uvm_info(get_type_name(), "created", UVM_LOW)
endfunction : new

`endif // AMP_SEQUENCER_SV