`timescale 1ns/1ps
`include "../DUT/param_def.v"

parameter T = 10;

module basic_tb;
    bit                         clk_i, rstn_i;
    
    logic                       wr_en_i;
    logic                       set_scaler_i;
    logic [`WR_DATA_WIDTH-1:0]  wr_data_i;
    
    logic                       rd_val_o;
    logic [`RD_DATA_WIDTH-1:0]  rd_data_o;
    logic [`SCALER_WIDTH-1:0]   scaler_o;

    amplifier dut(
        .clk_i          (clk_i)         ,
        .rstn_i         (rstn_i)        ,
        .wr_en_i        (wr_en_i)       ,
        .set_scaler_i   (set_scaler_i)  ,
        .wr_data_i      (wr_data_i)     ,
        .rd_val_o       (rd_val_o)      ,
        .rd_data_o      (rd_data_o)     ,
        .scaler_o       (scaler_o)
    );

    initial begin
        rstn_i <= 1'b0;
        #(10*T);
        rstn_i <= 1'b1;
    end

    initial begin
        clk_i <= 1'b0;
        forever begin
            #(T/2) clk_i <= ~clk_i;
        end
    end

    // 简单的检查
    initial begin
        wait(rstn_i);   // 等待复位结束

        #T; // 是否有延时会对打印结果产生影响，这也说明了时序图的重要性
        $display("====prepare...====");
        wr_en_i         <= 1'b0;
        set_scaler_i    <= 1'b0;
        wr_data_i       <= 16'd0;
        
        #T;
        $display("====input scaler====");
        wr_en_i         <= 1'b1;
        set_scaler_i    <= 1'b1;
        wr_data_i       <= 16'd100;

        #T;
        $display("scaler = %d\n", wr_data_i);

        $display("rd_val_o = %d", rd_val_o);
        $display("rd_data_o = %d", rd_data_o);
        $display("scaler_o = %d", scaler_o);

        #T;
        wr_en_i         <= 1'b1;
        set_scaler_i    <= 1'b0;
        wr_data_i       <= {8'd5, 8'd25};

        #T;
        $display("====input base number====");
        $display("no = %d", wr_data_i[15:8]);
        $display("base number = %d\n", wr_data_i[7:0]);

        $display("rd_val_o = %d", rd_val_o);
        $display("rd_data_o(no) = %d", rd_data_o[31:24]);
        $display("rd_data_o(res) = %d", rd_data_o[23:0]);
        $display("scaler_o = %d", scaler_o);
        #T;
        $display("====after a clock cycle====");
        $display("rd_val_o = %d", rd_val_o);
        $display("rd_data_o(no) = %d", rd_data_o[31:24]);
        $display("rd_data_o(res) = %d", rd_data_o[23:0]);
        $display("scaler_o = %d", scaler_o);
        $display("====finish====");
    end
endmodule : basic_tb