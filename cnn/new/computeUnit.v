`timescale 1ns / 1ps

module computeUnit(
    input                       clk,
    input                       rst_n,
    input                       stateC1_in,
    input                       convStart,
    input                       computeClear,
    input       signed  [7:0]   convA_in,
    input       signed  [7:0]   convB_in,
    output      signed  [31:0]  convResult_out
    );
    
    wire signed [31:0] multResult_out;
    reg  signed [31:0] multResult;

    wire signed [31:0] addResult_out;
    reg  signed [31:0] addResult;

    reg         [1:0]  convStart_r;
    wire               convStart_flag;

    assign convResult_out = computeClear ? addResult : 32'd0;
    assign convStart_flag = convStart_r[0]&(!convStart_r[1]);

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            convStart_r[0]<=1'b0;
            convStart_r[1]<=1'b0;
        end
        else begin
            convStart_r[1]<=convStart_r[0];
            convStart_r[0]<=convStart;
        end
    end

    computeMult computeMult(
        .stateC1_in(stateC1_in),
        .multA_in(convA_in),
        .multB_in(convB_in),
        .multResult_out(multResult_out)
    );

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            multResult<=32'd0;
        end
        else begin
            multResult<=multResult_out;
        end
    end

    computeAdd computeAdd(
        .addA_in(multResult),
        .addB_in(addResult),
        .addResult_out(addResult_out)
    );

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            addResult<=32'd0;
        end
        else if (convStart_flag) begin
            addResult<=32'd0;
        end
        else if (computeClear) begin
            addResult<=multResult;
        end
        else begin
            addResult<=addResult_out;
        end
    end

endmodule
