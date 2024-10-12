`timescale 1ns / 1ps

module maxValue(
    input                   clk,
    input                   rst_n,
    input                   convFinish,
    input                   computeClear,
    input  signed   [31:0]  convResult_0 ,
    input  signed   [31:0]  convResult_1 ,
    input  signed   [31:0]  convResult_2 ,
    input  signed   [31:0]  convResult_3 ,
    input  signed   [31:0]  convResult_4 ,
    input  signed   [31:0]  convResult_5 ,
    input  signed   [31:0]  convResult_6 ,
    input  signed   [31:0]  convResult_7 ,
    input  signed   [31:0]  convResult_8 ,
    input  signed   [31:0]  convResult_9 ,
    input  signed   [31:0]  convResult_10,
    input  signed   [31:0]  convResult_11,
    input  signed   [31:0]  convResult_12,
    input  signed   [31:0]  convResult_13,
    input  signed   [31:0]  convResult_14,
    input  signed   [31:0]  convResult_15,

    output reg signed [31:0]maxAbs,
    output reg              convFinish_flag
    );

    reg  signed   [31:0]  min_0 ;
    reg  signed   [31:0]  min_1 ;
    reg  signed   [31:0]  min_2 ;
    reg  signed   [31:0]  min_3 ;
    reg  signed   [31:0]  min_4 ;
    reg  signed   [31:0]  min_5 ;
    reg  signed   [31:0]  min_6 ;
    reg  signed   [31:0]  min_7 ;
    reg  signed   [31:0]  min_8 ;
    reg  signed   [31:0]  min_9 ;
    reg  signed   [31:0]  min_10;
    reg  signed   [31:0]  min_11;
    reg  signed   [31:0]  min_12;
    reg  signed   [31:0]  min_13;
    reg  signed   [31:0]  min_14;
    reg  signed   [31:0]  min_15;

    reg  signed   [31:0]  max_0 ;
    reg  signed   [31:0]  max_1 ;
    reg  signed   [31:0]  max_2 ;
    reg  signed   [31:0]  max_3 ;
    reg  signed   [31:0]  max_4 ;
    reg  signed   [31:0]  max_5 ;
    reg  signed   [31:0]  max_6 ;
    reg  signed   [31:0]  max_7 ;
    reg  signed   [31:0]  max_8 ;
    reg  signed   [31:0]  max_9 ;
    reg  signed   [31:0]  max_10;
    reg  signed   [31:0]  max_11;
    reg  signed   [31:0]  max_12;
    reg  signed   [31:0]  max_13;
    reg  signed   [31:0]  max_14;
    reg  signed   [31:0]  max_15;

    reg  signed   [31:0]  minAbs_0 ;
    reg  signed   [31:0]  minAbs_1 ;
    reg  signed   [31:0]  minAbs_2 ;
    reg  signed   [31:0]  minAbs_3 ;
    reg  signed   [31:0]  minAbs_4 ;
    reg  signed   [31:0]  minAbs_5 ;
    reg  signed   [31:0]  minAbs_6 ;
    reg  signed   [31:0]  minAbs_7 ;
    reg  signed   [31:0]  minAbs_8 ;
    reg  signed   [31:0]  minAbs_9 ;
    reg  signed   [31:0]  minAbs_10;
    reg  signed   [31:0]  minAbs_11;
    reg  signed   [31:0]  minAbs_12;
    reg  signed   [31:0]  minAbs_13;
    reg  signed   [31:0]  minAbs_14;
    reg  signed   [31:0]  minAbs_15;

    reg  signed   [31:0]  maxAbs_0 ;
    reg  signed   [31:0]  maxAbs_1 ;
    reg  signed   [31:0]  maxAbs_2 ;
    reg  signed   [31:0]  maxAbs_3 ;
    reg  signed   [31:0]  maxAbs_4 ;
    reg  signed   [31:0]  maxAbs_5 ;
    reg  signed   [31:0]  maxAbs_6 ;
    reg  signed   [31:0]  maxAbs_7 ;
    reg  signed   [31:0]  maxAbs_8 ;
    reg  signed   [31:0]  maxAbs_9 ;
    reg  signed   [31:0]  maxAbs_10;
    reg  signed   [31:0]  maxAbs_11;
    reg  signed   [31:0]  maxAbs_12;
    reg  signed   [31:0]  maxAbs_13;
    reg  signed   [31:0]  maxAbs_14;
    reg  signed   [31:0]  maxAbs_15;

    reg           [5:0]   convFinish_d;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            min_0 <=32'd0;
            min_1 <=32'd0;
            min_2 <=32'd0;
            min_3 <=32'd0;
            min_4 <=32'd0;
            min_5 <=32'd0;
            min_6 <=32'd0;
            min_7 <=32'd0;
            min_8 <=32'd0;
            min_9 <=32'd0;
            min_10<=32'd0;
            min_11<=32'd0;
            min_12<=32'd0;
            min_13<=32'd0;
            min_14<=32'd0;
            min_15<=32'd0;
        end
        else if (computeClear) begin
            min_0 <=(convResult_0 <min_0 ) ? convResult_0  : min_0 ;
            min_1 <=(convResult_1 <min_1 ) ? convResult_1  : min_1 ;
            min_2 <=(convResult_2 <min_2 ) ? convResult_2  : min_2 ;
            min_3 <=(convResult_3 <min_3 ) ? convResult_3  : min_3 ;
            min_4 <=(convResult_4 <min_4 ) ? convResult_4  : min_4 ;
            min_5 <=(convResult_5 <min_5 ) ? convResult_5  : min_5 ;
            min_6 <=(convResult_6 <min_6 ) ? convResult_6  : min_6 ;
            min_7 <=(convResult_7 <min_7 ) ? convResult_7  : min_7 ;
            min_8 <=(convResult_8 <min_8 ) ? convResult_8  : min_8 ;
            min_9 <=(convResult_9 <min_9 ) ? convResult_9  : min_9 ;
            min_10<=(convResult_10<min_10) ? convResult_10 : min_10;
            min_11<=(convResult_11<min_11) ? convResult_11 : min_11;
            min_12<=(convResult_12<min_12) ? convResult_12 : min_12;
            min_13<=(convResult_13<min_13) ? convResult_13 : min_13;
            min_14<=(convResult_14<min_14) ? convResult_14 : min_14;
            min_15<=(convResult_15<min_15) ? convResult_15 : min_15;
        end
    end

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            max_0 <=32'd0;
            max_1 <=32'd0;
            max_2 <=32'd0;
            max_3 <=32'd0;
            max_4 <=32'd0;
            max_5 <=32'd0;
            max_6 <=32'd0;
            max_7 <=32'd0;
            max_8 <=32'd0;
            max_9 <=32'd0;
            max_10<=32'd0;
            max_11<=32'd0;
            max_12<=32'd0;
            max_13<=32'd0;
            max_14<=32'd0;
            max_15<=32'd0;
        end
        else if (computeClear) begin
            max_0 <=(convResult_0 >max_0 ) ? convResult_0  : max_0 ;
            max_1 <=(convResult_1 >max_1 ) ? convResult_1  : max_1 ;
            max_2 <=(convResult_2 >max_2 ) ? convResult_2  : max_2 ;
            max_3 <=(convResult_3 >max_3 ) ? convResult_3  : max_3 ;
            max_4 <=(convResult_4 >max_4 ) ? convResult_4  : max_4 ;
            max_5 <=(convResult_5 >max_5 ) ? convResult_5  : max_5 ;
            max_6 <=(convResult_6 >max_6 ) ? convResult_6  : max_6 ;
            max_7 <=(convResult_7 >max_7 ) ? convResult_7  : max_7 ;
            max_8 <=(convResult_8 >max_8 ) ? convResult_8  : max_8 ;
            max_9 <=(convResult_9 >max_9 ) ? convResult_9  : max_9 ;
            max_10<=(convResult_10>max_10) ? convResult_10 : max_10;
            max_11<=(convResult_11>max_11) ? convResult_11 : max_11;
            max_12<=(convResult_12>max_12) ? convResult_12 : max_12;
            max_13<=(convResult_13>max_13) ? convResult_13 : max_13;
            max_14<=(convResult_14>max_14) ? convResult_14 : max_14;
            max_15<=(convResult_15>max_15) ? convResult_15 : max_15;
        end
    end

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            convFinish_d<=6'd0;
            convFinish_flag<=1'b0;
        end
        else begin
            {convFinish_flag,convFinish_d}<={convFinish_d,convFinish};
        end
    end

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            minAbs_0 <=32'd0;
            minAbs_1 <=32'd0;
            minAbs_2 <=32'd0;
            minAbs_3 <=32'd0;
            minAbs_4 <=32'd0;
            minAbs_5 <=32'd0;
            minAbs_6 <=32'd0;
            minAbs_7 <=32'd0;
            minAbs_8 <=32'd0;
            minAbs_9 <=32'd0;
            minAbs_10<=32'd0;
            minAbs_11<=32'd0;
            minAbs_12<=32'd0;
            minAbs_13<=32'd0;
            minAbs_14<=32'd0;
            minAbs_15<=32'd0;
            maxAbs   <=32'd0;
            maxAbs_0 <=32'd0;
            maxAbs_1 <=32'd0;
            maxAbs_2 <=32'd0;
            maxAbs_3 <=32'd0;
            maxAbs_4 <=32'd0;
            maxAbs_5 <=32'd0;
            maxAbs_6 <=32'd0;
            maxAbs_7 <=32'd0;
            maxAbs_8 <=32'd0;
            maxAbs_9 <=32'd0;
            maxAbs_10<=32'd0;
            maxAbs_11<=32'd0;
            maxAbs_12<=32'd0;
            maxAbs_13<=32'd0;
            maxAbs_14<=32'd0;
            maxAbs_15<=32'd0;
        end
        else begin
            case(convFinish_d)
                6'b000001:begin
                    minAbs_0 <= ~min_0 +1'b1;
                    minAbs_1 <= ~min_1 +1'b1;
                    minAbs_2 <= ~min_2 +1'b1;
                    minAbs_3 <= ~min_3 +1'b1;
                    minAbs_4 <= ~min_4 +1'b1;
                    minAbs_5 <= ~min_5 +1'b1;
                    minAbs_6 <= ~min_6 +1'b1;
                    minAbs_7 <= ~min_7 +1'b1;
                    minAbs_8 <= ~min_8 +1'b1;
                    minAbs_9 <= ~min_9 +1'b1;
                    minAbs_10<= ~min_10+1'b1;
                    minAbs_11<= ~min_11+1'b1;
                    minAbs_12<= ~min_12+1'b1;
                    minAbs_13<= ~min_13+1'b1;
                    minAbs_14<= ~min_14+1'b1;
                    minAbs_15<= ~min_15+1'b1;
                end
                6'b000011:begin
                    maxAbs_0 <=(minAbs_0 <max_0 ) ? max_0  : minAbs_0 ;
                    maxAbs_1 <=(minAbs_1 <max_1 ) ? max_1  : minAbs_1 ;
                    maxAbs_2 <=(minAbs_2 <max_2 ) ? max_2  : minAbs_2 ;
                    maxAbs_3 <=(minAbs_3 <max_3 ) ? max_3  : minAbs_3 ;
                    maxAbs_4 <=(minAbs_4 <max_4 ) ? max_4  : minAbs_4 ;
                    maxAbs_5 <=(minAbs_5 <max_5 ) ? max_5  : minAbs_5 ;
                    maxAbs_6 <=(minAbs_6 <max_6 ) ? max_6  : minAbs_6 ;
                    maxAbs_7 <=(minAbs_7 <max_7 ) ? max_7  : minAbs_7 ;
                    maxAbs_8 <=(minAbs_8 <max_8 ) ? max_8  : minAbs_8 ;
                    maxAbs_9 <=(minAbs_9 <max_9 ) ? max_9  : minAbs_9 ;
                    maxAbs_10<=(minAbs_10<max_10) ? max_10 : minAbs_10;
                    maxAbs_11<=(minAbs_11<max_11) ? max_11 : minAbs_11;
                    maxAbs_12<=(minAbs_12<max_12) ? max_12 : minAbs_12;
                    maxAbs_13<=(minAbs_13<max_13) ? max_13 : minAbs_13;
                    maxAbs_14<=(minAbs_14<max_14) ? max_14 : minAbs_14;
                    maxAbs_15<=(minAbs_15<max_15) ? max_15 : minAbs_15;
                end
                6'b000111:begin
                    maxAbs_0 <=(maxAbs_0 >maxAbs_1 ) ? maxAbs_0  : maxAbs_1 ;
                    maxAbs_2 <=(maxAbs_2 >maxAbs_3 ) ? maxAbs_2  : maxAbs_3 ;
                    maxAbs_4 <=(maxAbs_4 >maxAbs_5 ) ? maxAbs_4  : maxAbs_5 ;
                    maxAbs_6 <=(maxAbs_6 >maxAbs_7 ) ? maxAbs_6  : maxAbs_7 ;
                    maxAbs_8 <=(maxAbs_8 >maxAbs_9 ) ? maxAbs_8  : maxAbs_9 ;
                    maxAbs_10<=(maxAbs_10>maxAbs_11) ? maxAbs_10 : maxAbs_11;
                    maxAbs_12<=(maxAbs_12>maxAbs_13) ? maxAbs_12 : maxAbs_13;
                    maxAbs_14<=(maxAbs_14>maxAbs_15) ? maxAbs_14 : maxAbs_15;
                end
                6'b001111:begin
                    maxAbs_0 <=(maxAbs_0 >maxAbs_2 ) ? maxAbs_0  : maxAbs_2 ;
                    maxAbs_4 <=(maxAbs_4 >maxAbs_6 ) ? maxAbs_4  : maxAbs_6 ;
                    maxAbs_8 <=(maxAbs_8 >maxAbs_10) ? maxAbs_8  : maxAbs_10;
                    maxAbs_12<=(maxAbs_12>maxAbs_14) ? maxAbs_12 : maxAbs_14;
                end
                6'b011111:begin
                    maxAbs_0 <=(maxAbs_0 >maxAbs_4 ) ? maxAbs_0  : maxAbs_4 ;
                    maxAbs_8 <=(maxAbs_8 >maxAbs_12) ? maxAbs_8  : maxAbs_12;
                end
                6'b111111:begin
                    maxAbs <= (maxAbs_0>maxAbs_8) ? maxAbs_0 : maxAbs_8;
                end
                default:maxAbs<=maxAbs;
            endcase
        end
    end

endmodule
