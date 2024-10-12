`timescale 1ns / 1ps

module convLayer(
    input           clk,
    input           rst_n,
    input  [2:0]    cnn_state,  //七个阶段
    input           convStart,  //当图像和权重数据都存入ram后，开始卷积
    input  [5:0]    W,     //最大值为32
    input  [5:0]    H,
    input  [4:0]    C,     //最大值为16

    input           ramImage_en,
    input           ramImage_we,
    input  [9:0]    ramImage_addrW,
    input  [127:0]  ramImage_din,

    input           ramWeight_en,
    input           ramWeight_we,
    input  [4:0]    ramWeight_addrW,
    input  [127:0]  ramWeight_din,

    output          convFinish,
    output reg      wfifo_wen,
    output [127:0]  data_out
    );

    wire [127:0]  dataImage_in;
    wire [127:0]  dataWeight_in;
    wire          computeClear;    //每25个时钟对计算单元输出结果清零一次
    wire          stateC1_in;
    wire          convFinish_flag;    //电平信号
    wire          quantifyFinish;
    wire          fifo_wen;

    wire signed   [31:0]    convResult_0;
    wire signed   [31:0]    convResult_1;
    wire signed   [31:0]    convResult_2;
    wire signed   [31:0]    convResult_3;
    wire signed   [31:0]    convResult_4;
    wire signed   [31:0]    convResult_5;
    wire signed   [31:0]    convResult_6;
    wire signed   [31:0]    convResult_7;
    wire signed   [31:0]    convResult_8;
    wire signed   [31:0]    convResult_9;
    wire signed   [31:0]    convResult_10;
    wire signed   [31:0]    convResult_11;
    wire signed   [31:0]    convResult_12;
    wire signed   [31:0]    convResult_13;
    wire signed   [31:0]    convResult_14;
    wire signed   [31:0]    convResult_15;

    wire signed   [31:0]    quantization_0 ;
    wire signed   [31:0]    quantization_1 ;
    wire signed   [31:0]    quantization_2 ;
    wire signed   [31:0]    quantization_3 ;
    wire signed   [31:0]    quantization_4 ;
    wire signed   [31:0]    quantization_5 ;
    wire signed   [31:0]    quantization_6 ;
    wire signed   [31:0]    quantization_7 ;
    wire signed   [31:0]    quantization_8 ;
    wire signed   [31:0]    quantization_9 ;
    wire signed   [31:0]    quantization_10;
    wire signed   [31:0]    quantization_11;
    wire signed   [31:0]    quantization_12;
    wire signed   [31:0]    quantization_13;
    wire signed   [31:0]    quantization_14;
    wire signed   [31:0]    quantization_15;
    wire signed   [31:0]    maxAbs;

    assign stateC1_in = (cnn_state==1'b1);

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            wfifo_wen<=1'b0;
        end
        else if (fifo_wen && (!quantifyFinish)) begin
            wfifo_wen<=1'b1;
        end
        else begin
            wfifo_wen<=1'b0;
        end
    end

    dataReuse dataReuse(
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
        .ramImage_dout(dataImage_in),

        .ramWeight_en(ramWeight_en),
        .ramWeight_we(ramWeight_we),
        .ramWeight_addrW(ramWeight_addrW),
        .ramWeight_din(ramWeight_din),
        .ramWeight_dout(dataWeight_in),

        .convFinish(convFinish),
        .computeClear(computeClear)    //每25个时钟对计算单元输出结果清零一次
    );

    convUnit convUnit(
        .clk(clk),
        .rst_n(rst_n),
        .stateC1_in(stateC1_in),
        .convStart(convStart),
        .computeClear(computeClear),
        .dataImage_in(dataImage_in),
        .dataWeight_in(dataWeight_in),
        .convResult_0 (convResult_0 ),
        .convResult_1 (convResult_1 ),
        .convResult_2 (convResult_2 ),
        .convResult_3 (convResult_3 ),
        .convResult_4 (convResult_4 ),
        .convResult_5 (convResult_5 ),
        .convResult_6 (convResult_6 ),
        .convResult_7 (convResult_7 ),
        .convResult_8 (convResult_8 ),
        .convResult_9 (convResult_9 ),
        .convResult_10(convResult_10),
        .convResult_11(convResult_11),
        .convResult_12(convResult_12),
        .convResult_13(convResult_13),
        .convResult_14(convResult_14),
        .convResult_15(convResult_15)
    );

    maxValue maxValue(
        .clk(clk),
        .rst_n(rst_n),
        .convFinish(convFinish),
        .computeClear(computeClear),
        .convResult_0 (convResult_0 ),
        .convResult_1 (convResult_1 ),
        .convResult_2 (convResult_2 ),
        .convResult_3 (convResult_3 ),
        .convResult_4 (convResult_4 ),
        .convResult_5 (convResult_5 ),
        .convResult_6 (convResult_6 ),
        .convResult_7 (convResult_7 ),
        .convResult_8 (convResult_8 ),
        .convResult_9 (convResult_9 ),
        .convResult_10(convResult_10),
        .convResult_11(convResult_11),
        .convResult_12(convResult_12),
        .convResult_13(convResult_13),
        .convResult_14(convResult_14),
        .convResult_15(convResult_15),
        .maxAbs(maxAbs),
        .convFinish_flag(convFinish_flag)
    );

    ramResult ramResult(
        .clk(clk),
        .rst_n(rst_n),
        .stateC1_in(stateC1_in),
        .convStart(convStart),
        .computeClear(computeClear),
        .convFinish_flag(convFinish_flag),
        .convResult_0 (convResult_0),
        .convResult_1 (convResult_1),
        .convResult_2 (convResult_2),
        .convResult_3 (convResult_3 ),
        .convResult_4 (convResult_4 ),
        .convResult_5 (convResult_5 ),
        .convResult_6 (convResult_6 ),
        .convResult_7 (convResult_7 ),
        .convResult_8 (convResult_8 ),
        .convResult_9 (convResult_9 ),
        .convResult_10(convResult_10),
        .convResult_11(convResult_11),
        .convResult_12(convResult_12),
        .convResult_13(convResult_13),
        .convResult_14(convResult_14),
        .convResult_15(convResult_15),

        .quantization_0 (quantization_0 ),
        .quantization_1 (quantization_1 ),
        .quantization_2 (quantization_2 ),
        .quantization_3 (quantization_3 ),
        .quantization_4 (quantization_4 ),
        .quantization_5 (quantization_5 ),
        .quantization_6 (quantization_6 ),
        .quantization_7 (quantization_7 ),
        .quantization_8 (quantization_8 ),
        .quantization_9 (quantization_9 ),
        .quantization_10(quantization_10),
        .quantization_11(quantization_11),
        .quantization_12(quantization_12),
        .quantization_13(quantization_13),
        .quantization_14(quantization_14),
        .quantization_15(quantization_15),
        .quantifyFinish(quantifyFinish)
    );

    quantify quantify(
        .clk(clk),
        .rst_n(rst_n),
        .convFinish_flag(convFinish_flag),
        .maxAbs(maxAbs),
        .quantization_0 (quantization_0),
        .quantization_1 (quantization_1 ),
        .quantization_2 (quantization_2 ),
        .quantization_3 (quantization_3 ),
        .quantization_4 (quantization_4 ),
        .quantization_5 (quantization_5 ),
        .quantization_6 (quantization_6 ),
        .quantization_7 (quantization_7 ),
        .quantization_8 (quantization_8 ),
        .quantization_9 (quantization_9 ),
        .quantization_10(quantization_10),
        .quantization_11(quantization_11),
        .quantization_12(quantization_12),
        .quantization_13(quantization_13),
        .quantization_14(quantization_14),
        .quantization_15(quantization_15),
        .wfifo_en(fifo_wen),
        .data_out(data_out)
    );

endmodule
