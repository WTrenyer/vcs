`timescale 1ns / 1ps

module convUnit(
    input                     clk,
    input                     rst_n,
    input                     stateC1_in,
    input                     convStart,
    input                     computeClear,
    input           [127:0]   dataImage_in,
    input           [127:0]   dataWeight_in,
    output signed   [31:0]    convResult_0,
    output signed   [31:0]    convResult_1,
    output signed   [31:0]    convResult_2,
    output signed   [31:0]    convResult_3,
    output signed   [31:0]    convResult_4,
    output signed   [31:0]    convResult_5,
    output signed   [31:0]    convResult_6,
    output signed   [31:0]    convResult_7,
    output signed   [31:0]    convResult_8,
    output signed   [31:0]    convResult_9,
    output signed   [31:0]    convResult_10,
    output signed   [31:0]    convResult_11,
    output signed   [31:0]    convResult_12,
    output signed   [31:0]    convResult_13,
    output signed   [31:0]    convResult_14,
    output signed   [31:0]    convResult_15
    );
    
    computeUnit computeUnit_0(
        .clk(clk),
        .rst_n(rst_n),
        .stateC1_in(stateC1_in),
        .convStart(convStart),
        .computeClear(computeClear),
        .convA_in(dataImage_in[7:0]),
        .convB_in(dataWeight_in[7:0]),
        .convResult_out(convResult_0)
    );
    
    computeUnit computeUnit_1(
        .clk(clk),
        .rst_n(rst_n),
        .stateC1_in(stateC1_in),
        .convStart(convStart),
        .computeClear(computeClear),
        .convA_in(dataImage_in[7:0]),
        .convB_in(dataWeight_in[15:8]),
        .convResult_out(convResult_1)
    );

    computeUnit computeUnit_2(
        .clk(clk),
        .rst_n(rst_n),
        .stateC1_in(stateC1_in),
        .convStart(convStart),
        .computeClear(computeClear),
        .convA_in(dataImage_in[7:0]),
        .convB_in(dataWeight_in[23:16]),
        .convResult_out(convResult_2)
    );

    computeUnit computeUnit_3(
        .clk(clk),
        .rst_n(rst_n),
        .stateC1_in(stateC1_in),
        .convStart(convStart),
        .computeClear(computeClear),
        .convA_in(dataImage_in[7:0]),
        .convB_in(dataWeight_in[31:24]),
        .convResult_out(convResult_3)
    );

    computeUnit computeUnit_4(
        .clk(clk),
        .rst_n(rst_n),
        .stateC1_in(stateC1_in),
        .convStart(convStart),
        .computeClear(computeClear),
        .convA_in(dataImage_in[7:0]),
        .convB_in(dataWeight_in[39:32]),
        .convResult_out(convResult_4)
    );

    computeUnit computeUnit_5(
        .clk(clk),
        .rst_n(rst_n),
        .stateC1_in(stateC1_in),
        .convStart(convStart),
        .computeClear(computeClear),
        .convA_in(dataImage_in[7:0]),
        .convB_in(dataWeight_in[47:40]),
        .convResult_out(convResult_5)
    );

    computeUnit computeUnit_6(
        .clk(clk),
        .rst_n(rst_n),
        .stateC1_in(stateC1_in),
        .convStart(convStart),
        .computeClear(computeClear),
        .convA_in(dataImage_in[55:48]),
        .convB_in(dataWeight_in[55:48]),
        .convResult_out(convResult_6)
    );

    computeUnit computeUnit_7(
        .clk(clk),
        .rst_n(rst_n),
        .stateC1_in(stateC1_in),
        .convStart(convStart),
        .computeClear(computeClear),
        .convA_in(dataImage_in[63:54]),
        .convB_in(dataWeight_in[63:54]),
        .convResult_out(convResult_7)
    );

    computeUnit computeUnit_8(
        .clk(clk),
        .rst_n(rst_n),
        .stateC1_in(stateC1_in),
        .convStart(convStart),
        .computeClear(computeClear),
        .convA_in(dataImage_in[71:64]),
        .convB_in(dataWeight_in[71:64]),
        .convResult_out(convResult_8)
    );

    computeUnit computeUnit_9(
        .clk(clk),
        .rst_n(rst_n),
        .stateC1_in(stateC1_in),
        .convStart(convStart),
        .computeClear(computeClear),
        .convA_in(dataImage_in[79:72]),
        .convB_in(dataWeight_in[79:72]),
        .convResult_out(convResult_9)
    );

    computeUnit computeUnit_10(
        .clk(clk),
        .rst_n(rst_n),
        .stateC1_in(stateC1_in),
        .convStart(convStart),
        .computeClear(computeClear),
        .convA_in(dataImage_in[87:80]),
        .convB_in(dataWeight_in[87:80]),
        .convResult_out(convResult_10)
    );

    computeUnit computeUnit_11(
        .clk(clk),
        .rst_n(rst_n),
        .stateC1_in(stateC1_in),
        .convStart(convStart),
        .computeClear(computeClear),
        .convA_in(dataImage_in[95:88]),
        .convB_in(dataWeight_in[95:88]),
        .convResult_out(convResult_11)
    );

    computeUnit computeUnit_12(
        .clk(clk),
        .rst_n(rst_n),
        .stateC1_in(stateC1_in),
        .convStart(convStart),
        .computeClear(computeClear),
        .convA_in(dataImage_in[103:96]),
        .convB_in(dataWeight_in[103:96]),
        .convResult_out(convResult_12)
    );

    computeUnit computeUnit_13(
        .clk(clk),
        .rst_n(rst_n),
        .stateC1_in(stateC1_in),
        .convStart(convStart),
        .computeClear(computeClear),
        .convA_in(dataImage_in[111:104]),
        .convB_in(dataWeight_in[111:104]),
        .convResult_out(convResult_13)
    );

    computeUnit computeUnit_14(
        .clk(clk),
        .rst_n(rst_n),
        .stateC1_in(stateC1_in),
        .convStart(convStart),
        .computeClear(computeClear),
        .convA_in(dataImage_in[119:112]),
        .convB_in(dataWeight_in[119:112]),
        .convResult_out(convResult_14)
    );

    computeUnit computeUnit_15(
        .clk(clk),
        .rst_n(rst_n),
        .stateC1_in(stateC1_in),
        .convStart(convStart),
        .computeClear(computeClear),
        .convA_in(dataImage_in[127:120]),
        .convB_in(dataWeight_in[127:120]),
        .convResult_out(convResult_15)
    );



endmodule
