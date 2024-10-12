`timescale 1ns / 1ps
//卷积一层C1中A通道进入的全部是0~255的灰度数据，其余情况下都是-128~127的特征图数据
module computeMult(
    input                   stateC1_in,
    input   signed  [7:0]   multA_in,
    input   signed  [7:0]   multB_in,
    output  signed  [31:0]  multResult_out
    );
    
    wire signed [8:0] multA_extend;
    wire signed [8:0] multB_extend;

    assign multA_extend = stateC1_in ? {1'b0,multA_in} : {multA_in[7],multA_in};
    assign multB_extend = {multB_in[7],multB_in};
    assign multResult_out = multA_extend * multB_extend;

endmodule
