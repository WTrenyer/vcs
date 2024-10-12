`timescale 1ns / 1ps

module dataReuseTest_tb();
    reg           clk;
    reg           rst_n;
    wire [127:0]  ramImage_dout;
    wire [127:0]  ramWeight_dout;

    dataReuse_test dataReuse_test(
        clk,
        rst_n,
        ramImage_dout,
        ramWeight_dout
    );

    always #10 clk=~clk;
    initial begin
        clk=0;
        rst_n=0;
        #100 rst_n=1;
        #1000000 $finish;
    end
endmodule
