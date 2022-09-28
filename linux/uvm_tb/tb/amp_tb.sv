module amp_tb;

	import uvm_pkg::*;
	`include "uvm_macros.svh"

	import amp_test_pkg::*;

    logic clk, rst_n;

    amp_interface itf(.clk_i(clk), .rstn_i(rst_n));

    amplifier dut(
        .clk_i          (clk)               ,
        .rstn_i         (rst_n)             ,
        .wr_en_i        (itf.wr_en_i)       ,
        .set_scaler_i   (itf.set_scaler_i)  ,
        .wr_data_i      (itf.wr_data_i)     ,
        .rd_val_o       (itf.rd_val_o)      ,
        .rd_data_o      (itf.rd_data_o)     ,
        .scaler_o       (itf.scaler_o)
    );

    initial begin
		clk = 0;
        rst_n = 0;
		repeat(10) begin
			#1ns clk = ~clk;
		end
		rst_n = 1;
		forever begin
			#1ns clk = ~clk;
		end
    end

    initial begin
        uvm_config_db #(virtual amp_interface)::set(null, "uvm_test_top.env.i_agt", "vif", itf);
        uvm_config_db #(virtual amp_interface)::set(null, "uvm_test_top.env.o_agt", "vif", itf);
        `uvm_info("amp_tb", "set virtual interface completed, but in amp_do.do", UVM_LOW)
    end

    initial begin
        run_test();
    end

endmodule : amp_tb
