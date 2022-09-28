`ifndef AMP_SEQ_ITEM_SV
`define AMP_SEQ_ITEM_SV

class amp_seq_item extends uvm_sequence_item;

    typedef enum{IDLE, SET_SCALER, SET_BASE_NUMBER} trans_type;

    rand trans_type ttype;

    rand bit [7:0]  no;
    rand bit [7:0]  base_number;
    rand bit [15:0] scaler;

    rand int delay;

        bit [15:0]  rd_scaler;
        bit [31:0]  rd_data;
        bit         rd_valid;

    // Constraints
    constraint delay_bounds {
        soft delay       dist {0:=50, 1:=25, 2:=25};
        soft base_number inside {[1:50]};
        soft scaler      dist {1:/50, [2:5]:/50};
    }

    `uvm_object_utils_begin(amp_seq_item)
        `uvm_field_enum	(trans_type, ttype, UVM_ALL_ON)
        `uvm_field_int	(no, UVM_ALL_ON)
        `uvm_field_int	(base_number, UVM_ALL_ON)
        `uvm_field_int	(scaler, UVM_ALL_ON)
        `uvm_field_int	(delay, UVM_ALL_ON)
        `uvm_field_int	(rd_scaler, UVM_ALL_ON)
        `uvm_field_int	(rd_data, UVM_ALL_ON)
        `uvm_field_int	(rd_valid, UVM_ALL_ON)
    `uvm_object_utils_end

    extern function new(string name = "amp_seq_item");
endclass : amp_seq_item

function amp_seq_item::new(string name = "amp_seq_item");
    super.new(name);
    
    `uvm_info(get_type_name(), "created", UVM_HIGH)
endfunction : new

`endif // AMP_SEQ_ITEM_SV