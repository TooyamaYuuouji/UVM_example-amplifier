`ifndef AMP_DRIVER_SV
`define AMP_DRIVER_SV

class amp_driver extends uvm_driver #(amp_seq_item);
    virtual amp_interface vif = null;

    `uvm_component_utils(amp_driver)

    extern function         new(string name = "amp_driver", uvm_component parent = null);
    extern function void    build_phase(uvm_phase phase);
    extern task             run_phase(uvm_phase phase);

    extern protected task   reset_dut();
    extern protected task   idle(amp_seq_item t);
    extern protected task   set_scaler(amp_seq_item t);
    extern protected task   set_base_number(amp_seq_item t);
    extern protected task   do_transaction(amp_seq_item t);
endclass : amp_driver

function amp_driver::new(string name = "amp_driver", uvm_component parent = null);
	super.new(name, parent);

	`uvm_info(get_type_name(), "created", UVM_LOW)
endfunction : new

function void amp_driver::build_phase(uvm_phase phase);
	super.build_phase(phase);

endfunction : build_phase

task amp_driver::run_phase(uvm_phase phase);
	super.run_phase(phase);

	vif.wr_en_i			= 1'b0;
	vif.set_scaler_i	= 1'b0;
	vif.wr_data_i		= 16'd0;
	vif.rd_val_o		= 1'b0;
	vif.rd_data_o		= 32'd0;
	vif.scaler_o		= 16'd0;

	while(!vif.rstn_i)
		@(posedge vif.clk_i);

	fork
		this.reset_dut();
		forever begin
			seq_item_port.get_next_item(req);
			`uvm_info(get_type_name(), {"req item:\n", req.sprint()}, UVM_FULL)
			this.do_transaction(req);
			void'($cast(rsp, req.clone()));
			rsp.set_sequence_id(req.get_sequence_id());
			seq_item_port.item_done(rsp);
		end
	join
endtask : run_phase

task amp_driver::reset_dut();
	forever begin
		@(negedge vif.rstn_i);
		vif.wr_en_i 		= 1'b0;
		vif.set_scaler_i	= 1'b0;
		vif.wr_data_i 		= 16'd0;
	end
endtask : reset_dut

task amp_driver::idle(amp_seq_item t);
	repeat(t.delay) @vif.ck_drv;
	vif.ck_drv.wr_en_i 		<= 1'b0;
	vif.ck_drv.wr_data_i	<= 16'd0;
endtask : idle

task amp_driver::set_scaler(amp_seq_item t);
	@vif.ck_drv;
	vif.ck_drv.wr_en_i		<= 1'b1;
	vif.ck_drv.set_scaler_i <= 1'b1;
	vif.ck_drv.wr_data_i	<= t.scaler;
endtask : set_scaler

task amp_driver::set_base_number(amp_seq_item t);
	@vif.ck_drv;
	vif.ck_drv.wr_en_i		<= 1'b1;
	vif.ck_drv.set_scaler_i	<= 1'b0;
	vif.ck_drv.wr_data_i	<= {t.no, t.base_number};
	
	t.rd_scaler				<= vif.ck_drv.scaler_o;
endtask : set_base_number

task amp_driver::do_transaction(amp_seq_item t);
	case(t.ttype)
		amp_seq_item::IDLE:				this.idle(t);
		amp_seq_item::SET_SCALER:		this.set_scaler(t);
		amp_seq_item::SET_BASE_NUMBER:	this.set_base_number(t);
		default:						`uvm_error("ERROR STATE", "an undefined state in do_transaction")
	endcase
endtask : do_transaction

`endif // AMP_DRIVER_SV