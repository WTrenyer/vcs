`timescale 1ns / 1ps

module convLayerTest_tb();
    reg           clk;
    reg           rst_n;
    wire [127:0]  data_out;

    convLayer_test convLayer_test(
        clk,
        rst_n,
        data_out
    );

    always #10 clk=~clk;
    initial begin
        clk=0;
        rst_n=0;
        #100 rst_n=1;
        #500000 $finish;
    end
    
endmodule
