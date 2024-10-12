`timescale 1ns / 1ps

module convLayer_test(
    input           clk,
    input           rst_n,
    output [127:0]  data_out
    );

    wire  [2:0]    cnn_state;
    wire           convStart;
    wire  [5:0]    W;
    wire  [5:0]    H;
    wire  [4:0]    C;

    wire           ramImage_en;
    wire           ramImage_we;
    wire  [9:0]    ramImage_addrW;
    wire  [127:0]  ramImage_din;
    
    wire           ramWeight_en;
    wire           ramWeight_we;
    wire  [4:0]    ramWeight_addrW;
    wire  [127:0]  ramWeight_din;

    wire           wfifo_wen;
    wire           convFinish;

    ramWrite ramWrite(
        .clk(clk),
        .rst_n(rst_n),
        .convFinish(convFinish),
        .cnn_state(cnn_state),
        .convStart(convStart),
        .W(W),
        .H(H),
        .C(C),

        .ramImage_en(ramImage_en),
        .ramImage_we(ramImage_we),
        .ramImage_addrW(ramImage_addrW),
        .ramImage_din(ramImage_din),
    
        .ramWeight_en(ramWeight_en),
        .ramWeight_we(ramWeight_we),
        .ramWeight_addrW(ramWeight_addrW),
        .ramWeight_din(ramWeight_din)
    );

    convLayer convLayer(
        .clk(clk),
        .rst_n(rst_n),
        .cnn_state(cnn_state),  //七个阶段
        .convStart(convStart),  //当图像和权重数据都存入ram后，开始卷积
        .W(W),     //最大值为32
        .H(H),
        .C(C),     //最大值为16

        .ramImage_en(ramImage_en),
        .ramImage_we(ramImage_we),
        .ramImage_addrW(ramImage_addrW),
        .ramImage_din(ramImage_din),

        .ramWeight_en(ramWeight_en),
        .ramWeight_we(ramWeight_we),
        .ramWeight_addrW(ramWeight_addrW),
        .ramWeight_din(ramWeight_din),

        .convFinish(convFinish),
        .wfifo_wen(wfifo_wen),
        .data_out(data_out)
    );

endmodule
