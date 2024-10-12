`timescale 1ns / 1ps

module quantify(
    input                   clk,
    input                   rst_n,
    input                   convFinish_flag,
    input   signed  [31:0]  maxAbs,
    input   signed  [31:0]  quantization_0 ,
    input   signed  [31:0]  quantization_1 ,
    input   signed  [31:0]  quantization_2 ,
    input   signed  [31:0]  quantization_3 ,
    input   signed  [31:0]  quantization_4 ,
    input   signed  [31:0]  quantization_5 ,
    input   signed  [31:0]  quantization_6 ,
    input   signed  [31:0]  quantization_7 ,
    input   signed  [31:0]  quantization_8 ,
    input   signed  [31:0]  quantization_9 ,
    input   signed  [31:0]  quantization_10,
    input   signed  [31:0]  quantization_11,
    input   signed  [31:0]  quantization_12,
    input   signed  [31:0]  quantization_13,
    input   signed  [31:0]  quantization_14,
    input   signed  [31:0]  quantization_15,
    output  reg             wfifo_en,
    output  reg     [127:0] data_out
    );

    reg                   convFinish_d0;
    reg                   convFinish_d1;

    reg   signed  [38:0]  zoom_0 ;
    reg   signed  [38:0]  zoom_1 ;
    reg   signed  [38:0]  zoom_2 ;
    reg   signed  [38:0]  zoom_3 ;
    reg   signed  [38:0]  zoom_4 ;
    reg   signed  [38:0]  zoom_5 ;
    reg   signed  [38:0]  zoom_6 ;
    reg   signed  [38:0]  zoom_7 ;
    reg   signed  [38:0]  zoom_8 ;
    reg   signed  [38:0]  zoom_9 ;
    reg   signed  [38:0]  zoom_10;
    reg   signed  [38:0]  zoom_11;
    reg   signed  [38:0]  zoom_12;
    reg   signed  [38:0]  zoom_13;
    reg   signed  [38:0]  zoom_14;
    reg   signed  [38:0]  zoom_15;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            convFinish_d0<=1'b0;
            convFinish_d1<=1'b0;
            wfifo_en<=1'b0;
        end
        else begin
            convFinish_d0<=convFinish_flag;
            convFinish_d1<=convFinish_d0;
            wfifo_en<=convFinish_d1;
        end
    end

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            zoom_0 <=39'd0;
            zoom_1 <=39'd0;
            zoom_2 <=39'd0;
            zoom_3 <=39'd0;
            zoom_4 <=39'd0;
            zoom_5 <=39'd0;
            zoom_6 <=39'd0;
            zoom_7 <=39'd0;
            zoom_8 <=39'd0;
            zoom_9 <=39'd0;
            zoom_10<=39'd0;
            zoom_11<=39'd0;
            zoom_12<=39'd0;
            zoom_13<=39'd0;
            zoom_14<=39'd0;
            zoom_15<=39'd0;
        end
        else if (convFinish_flag) begin
            zoom_0 <=quantization_0 *127;
            zoom_1 <=quantization_1 *127;
            zoom_2 <=quantization_2 *127;
            zoom_3 <=quantization_3 *127;
            zoom_4 <=quantization_4 *127;
            zoom_5 <=quantization_5 *127;
            zoom_6 <=quantization_6 *127;
            zoom_7 <=quantization_7 *127;
            zoom_8 <=quantization_8 *127;
            zoom_9 <=quantization_9 *127;
            zoom_10<=quantization_10*127;
            zoom_11<=quantization_11*127;
            zoom_12<=quantization_12*127;
            zoom_13<=quantization_13*127;
            zoom_14<=quantization_14*127;
            zoom_15<=quantization_15*127;
        end
    end

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            data_out<=128'd0;
        end
        else if (convFinish_d0) begin
            data_out[ 7: 0]<=zoom_0 /maxAbs;
            data_out[15: 8]<=zoom_1 /maxAbs;
            data_out[23:16]<=zoom_2 /maxAbs;
            data_out[31:24]<=zoom_3 /maxAbs;
            data_out[39:32]<=zoom_4 /maxAbs;
            data_out[47:40]<=zoom_5 /maxAbs;
            data_out[55:48]<=zoom_6 /maxAbs;
            data_out[63:56]<=zoom_7 /maxAbs;
            data_out[71:64]<=zoom_8 /maxAbs;
            data_out[79:72]<=zoom_9 /maxAbs;
            data_out[87:80]<=zoom_10/maxAbs;
            data_out[95:88]<=zoom_11/maxAbs;
            data_out[103:96]<=zoom_12/maxAbs;
            data_out[111:104]<=zoom_13/maxAbs;
            data_out[119:112]<=zoom_14/maxAbs;
            data_out[127:120]<=zoom_15/maxAbs;
        end
    end

endmodule
