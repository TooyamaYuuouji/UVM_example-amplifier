`ifndef AMP_INTERFACE_SV
`define AMP_INTERFACE_SV

interface amp_interface(input bit clk_i, bit rstn_i);
    logic        wr_en_i;
    logic        set_scaler_i;
    logic [15:0] wr_data_i;

    logic        rd_val_o;
    logic [31:0] rd_data_o;
    logic [15:0] scaler_o;

    clocking ck_drv @(posedge clk_i);
		default input #1ps output #1ps;

		output 	wr_en_i, set_scaler_i, wr_data_i;
		input	rd_val_o, rd_data_o, scaler_o;
	endclocking : ck_drv

	clocking ck_mon @(posedge clk_i);
		default input #1ps output #1ps;

		input wr_en_i, set_scaler_i, wr_data_i, rd_val_o, rd_data_o, scaler_o;
	endclocking : ck_mon

endinterface : amp_interface

`endif // AMP_INTERFACE_SV