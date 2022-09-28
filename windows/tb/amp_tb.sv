`timescale 1ns/1ps

import uvm_pkg::*;

`include "uvm_macros.svh"
`include "amp_pkg.svh"

parameter T = 10;

module amp_tb;
    bit clk, rst_n;

    amp_interface itf(clk, rst_n);

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
        rst_n <= 1'b0;
        #(10*T);
        rst_n <= 1'b1;
    end

    initial begin
        clk <= 1'b0;
        forever begin
            #(T/2) clk <= ~clk;
        end
    end

    initial begin
        uvm_config_db #(virtual amp_interface)::set(null, "uvm_test_top.env.i_agt", "vif", itf);
        uvm_config_db #(virtual amp_interface)::set(null, "uvm_test_top.env.o_agt", "vif", itf);
        `uvm_info("amp_tb", "set virtual interface completed, but in amp_do.do", UVM_LOW)
    end

    initial begin
        uvm_root::get().set_report_verbosity_level_hier(UVM_LOW);
        run_test("amp_testcase1");
    end
endmodule : amp_tb