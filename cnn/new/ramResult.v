`timescale 1ns / 1ps

module ramResult(
    input                      clk,
    input                      rst_n,
    input                      stateC1_in,
    input                      convStart,
    input                      computeClear,
    input                      convFinish_flag,
    input   signed   [31:0]    convResult_0 ,
    input   signed   [31:0]    convResult_1 ,
    input   signed   [31:0]    convResult_2 ,
    input   signed   [31:0]    convResult_3 ,
    input   signed   [31:0]    convResult_4 ,
    input   signed   [31:0]    convResult_5 ,
    input   signed   [31:0]    convResult_6 ,
    input   signed   [31:0]    convResult_7 ,
    input   signed   [31:0]    convResult_8 ,
    input   signed   [31:0]    convResult_9 ,
    input   signed   [31:0]    convResult_10,
    input   signed   [31:0]    convResult_11,
    input   signed   [31:0]    convResult_12,
    input   signed   [31:0]    convResult_13,
    input   signed   [31:0]    convResult_14,
    input   signed   [31:0]    convResult_15,

    output  signed   [31:0]    quantization_0 ,
    output  signed   [31:0]    quantization_1 ,
    output  signed   [31:0]    quantization_2 ,
    output  signed   [31:0]    quantization_3 ,
    output  signed   [31:0]    quantization_4 ,
    output  signed   [31:0]    quantization_5 ,
    output  signed   [31:0]    quantization_6 ,
    output  signed   [31:0]    quantization_7 ,
    output  signed   [31:0]    quantization_8 ,
    output  signed   [31:0]    quantization_9 ,
    output  signed   [31:0]    quantization_10,
    output  signed   [31:0]    quantization_11,
    output  signed   [31:0]    quantization_12,
    output  signed   [31:0]    quantization_13,
    output  signed   [31:0]    quantization_14,
    output  signed   [31:0]    quantization_15,
    output  reg                quantifyFinish
    );

    reg     [9:0]waddr;
    reg     [9:0]raddr;
    wire    [9:0]addr;
    wire         ram100_en;
    reg     [2:0]quantifyFinish_d;

    assign addr = convStart ? waddr : raddr;
    assign ram100_en = rst_n && (!stateC1_in);

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            waddr<=10'd0;
        end
        else if (convStart) begin
            if (stateC1_in) begin
                if ((waddr<10'd784) && computeClear) begin
                    waddr<=waddr+1'b1;
                end
                else begin
                    waddr<=waddr;
                end
            end
            else begin
                if ((waddr<10'd100) && computeClear) begin
                    waddr<=waddr+1'b1;
                end
                else begin
                    waddr<=waddr;
                end
            end
        end
        else begin
            waddr<=10'd0;
        end
    end

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            raddr<=10'd0;
        end
        else if (convFinish_flag) begin
            if (stateC1_in) begin
                if (raddr<10'd783) begin
                    raddr<=raddr+1'b1;
                end
                else begin
                    raddr<=raddr;
                end
            end
            else begin
                if (raddr<10'd99) begin
                    raddr<=raddr+1'b1;
                end
                else begin
                    raddr<=raddr;
                end
            end
        end
        else begin
            raddr<=10'd0;
        end
    end

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            quantifyFinish_d<=3'd0;
            quantifyFinish<=1'b0;
        end
        else if (convStart) begin
            quantifyFinish_d<=3'd0;
            quantifyFinish<=1'b0;
        end
        else if ((stateC1_in)&&(raddr==10'd783)) begin
            quantifyFinish_d[0]<=1'b1;
            quantifyFinish_d[1]<=quantifyFinish_d[0];
            quantifyFinish_d[2]<=quantifyFinish_d[1];
            quantifyFinish<=quantifyFinish_d[2];
        end
        else if ((!stateC1_in)&&(raddr==10'd99)) begin
            quantifyFinish_d[0]<=1'b1;
            quantifyFinish_d[1]<=quantifyFinish_d[0];
            quantifyFinish_d[2]<=quantifyFinish_d[1];
            quantifyFinish<=quantifyFinish_d[2];
        end
    end

    ram784 ram784_0(
        .clka(clk),    // input wire clka
        .ena(rst_n),      // input wire ena
        .wea(convStart),      // input wire [0 : 0] wea
        .addra(addr),  // input wire [9 : 0] addra
        .dina(convResult_0),    // input wire [31 : 0] dina
        .douta(quantization_0)  // output wire [31 : 0] douta
    );

    ram784 ram784_1(
        .clka(clk),    // input wire clka
        .ena(rst_n),      // input wire ena
        .wea(convStart),      // input wire [0 : 0] wea
        .addra(addr),  // input wire [9 : 0] addra
        .dina(convResult_1),    // input wire [31 : 0] dina
        .douta(quantization_1)  // output wire [31 : 0] douta
    );

    ram784 ram784_2(
        .clka(clk),    // input wire clka
        .ena(rst_n),      // input wire ena
        .wea(convStart),      // input wire [0 : 0] wea
        .addra(addr),  // input wire [9 : 0] addra
        .dina(convResult_2),    // input wire [31 : 0] dina
        .douta(quantization_2)  // output wire [31 : 0] douta
    );

    ram784 ram784_3(
        .clka(clk),    // input wire clka
        .ena(rst_n),      // input wire ena
        .wea(convStart),      // input wire [0 : 0] wea
        .addra(addr),  // input wire [9 : 0] addra
        .dina(convResult_3),    // input wire [31 : 0] dina
        .douta(quantization_3)  // output wire [31 : 0] douta
    );

    ram784 ram784_4(
        .clka(clk),    // input wire clka
        .ena(rst_n),      // input wire ena
        .wea(convStart),      // input wire [0 : 0] wea
        .addra(addr),  // input wire [9 : 0] addra
        .dina(convResult_4),    // input wire [31 : 0] dina
        .douta(quantization_4)  // output wire [31 : 0] douta
    );

    ram784 ram784_5(
        .clka(clk),    // input wire clka
        .ena(rst_n),      // input wire ena
        .wea(convStart),      // input wire [0 : 0] wea
        .addra(addr),  // input wire [9 : 0] addra
        .dina(convResult_5),    // input wire [31 : 0] dina
        .douta(quantization_5)  // output wire [31 : 0] douta
    );

    ram100 ram100_6(
        .clka(clk),    // input wire clka
        .ena(ram100_en),      // input wire ena
        .wea(convStart),      // input wire [0 : 0] wea
        .addra(addr),  // input wire [6 : 0] addra
        .dina(convResult_6),    // input wire [31 : 0] dina
        .douta(quantization_6)  // output wire [31 : 0] douta
    );

    ram100 ram100_7(
        .clka(clk),    // input wire clka
        .ena(ram100_en),      // input wire ena
        .wea(convStart),      // input wire [0 : 0] wea
        .addra(addr),  // input wire [6 : 0] addra
        .dina(convResult_7),    // input wire [31 : 0] dina
        .douta(quantization_7)  // output wire [31 : 0] douta
    );

    ram100 ram100_8(
        .clka(clk),    // input wire clka
        .ena(ram100_en),      // input wire ena
        .wea(convStart),      // input wire [0 : 0] wea
        .addra(addr),  // input wire [6 : 0] addra
        .dina(convResult_8),    // input wire [31 : 0] dina
        .douta(quantization_8)  // output wire [31 : 0] douta
    );

    ram100 ram100_9(
        .clka(clk),    // input wire clka
        .ena(ram100_en),      // input wire ena
        .wea(convStart),      // input wire [0 : 0] wea
        .addra(addr),  // input wire [6 : 0] addra
        .dina(convResult_9),    // input wire [31 : 0] dina
        .douta(quantization_9)  // output wire [31 : 0] douta
    );

    ram100 ram100_10(
        .clka(clk),    // input wire clka
        .ena(ram100_en),      // input wire ena
        .wea(convStart),      // input wire [0 : 0] wea
        .addra(addr),  // input wire [6 : 0] addra
        .dina(convResult_10),    // input wire [31 : 0] dina
        .douta(quantization_10)  // output wire [31 : 0] douta
    );

    ram100 ram100_11(
        .clka(clk),    // input wire clka
        .ena(ram100_en),      // input wire ena
        .wea(convStart),      // input wire [0 : 0] wea
        .addra(addr),  // input wire [6 : 0] addra
        .dina(convResult_11),    // input wire [31 : 0] dina
        .douta(quantization_11)  // output wire [31 : 0] douta
    );

    ram100 ram100_12(
        .clka(clk),    // input wire clka
        .ena(ram100_en),      // input wire ena
        .wea(convStart),      // input wire [0 : 0] wea
        .addra(addr),  // input wire [6 : 0] addra
        .dina(convResult_12),    // input wire [31 : 0] dina
        .douta(quantization_12)  // output wire [31 : 0] douta
    );

    ram100 ram100_13(
        .clka(clk),    // input wire clka
        .ena(ram100_en),      // input wire ena
        .wea(convStart),      // input wire [0 : 0] wea
        .addra(addr),  // input wire [6 : 0] addra
        .dina(convResult_13),    // input wire [31 : 0] dina
        .douta(quantization_13)  // output wire [31 : 0] douta
    );

    ram100 ram100_14(
        .clka(clk),    // input wire clka
        .ena(ram100_en),      // input wire ena
        .wea(convStart),      // input wire [0 : 0] wea
        .addra(addr),  // input wire [6 : 0] addra
        .dina(convResult_14),    // input wire [31 : 0] dina
        .douta(quantization_14)  // output wire [31 : 0] douta
    );

    ram100 ram100_15(
        .clka(clk),    // input wire clka
        .ena(ram100_en),      // input wire ena
        .wea(convStart),      // input wire [0 : 0] wea
        .addra(addr),  // input wire [6 : 0] addra
        .dina(convResult_15),    // input wire [31 : 0] dina
        .douta(quantization_15)  // output wire [31 : 0] douta
    );

endmodule
