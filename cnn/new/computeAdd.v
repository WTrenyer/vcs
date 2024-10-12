`timescale 1ns / 1ps

module computeAdd(
    input   signed  [31:0]  addA_in,
    input   signed  [31:0]  addB_in,
    output  signed  [31:0]  addResult_out
    );

    assign addResult_out = addA_in + addB_in;

endmodule
