`timescale 1ns / 1ps

module ramWrite(
    input                        clk,
    input                        rst_n,
    input                        convFinish,
    output              [2:0]    cnn_state,
    output                       convStart,
    output              [5:0]    W,
    output              [5:0]    H,
    output              [4:0]    C,
        
    output reg                   ramImage_en,
    output reg                   ramImage_we,
    output reg          [9:0]    ramImage_addrW,
    output reg  signed  [127:0]  ramImage_din,
    
    output reg                   ramWeight_en,
    output reg                   ramWeight_we,
    output reg          [4:0]    ramWeight_addrW,
    output reg  signed  [127:0]  ramWeight_din
    );

    reg             ramImage_startFlag;     //当图像数据全部存入ram_image中，拉高信号
    reg             ramWeight_startFlag;    //当权重数据全部存入ram_weight中，拉高信号
    
    reg     [1:0]   convFinish_r;
    wire            convFinish_flag;

    assign cnn_state = 3'd1;
    assign W = 6'd32;
    assign H = 6'd32;
    assign C = 5'd1;

    assign convStart = ramImage_startFlag & ramWeight_startFlag;

    assign convFinish_flag = (convFinish_r[0]==1'b1) & (convFinish_r[1]==1'b0);

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            convFinish_r[0]<=1'b0;
            convFinish_r[1]<=1'b0;
        end
        else begin
            convFinish_r[1]<=convFinish_r[0];
            convFinish_r[0]<=convFinish;
        end
    end

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            ramImage_startFlag<=1'b0;
            ramImage_en<=1'b1;
            ramImage_we<=1'b1;
            ramImage_addrW<=10'd0;
            ramImage_din<=128'd0;
        end
        else if (ramImage_we==1'b1) begin
            if (ramImage_addrW<W*H-1) begin
                ramImage_addrW<=ramImage_addrW+1'b1;
                ramImage_din<=ramImage_din+1'b1;
            end
            else begin
                ramImage_startFlag<=1'b1;
                ramImage_we<=1'b0;
                ramImage_addrW<=10'd0;
                ramImage_din<=128'd0;
            end
        end
        else if (convFinish_flag) begin
            ramImage_startFlag<=1'b0;
        end
    end

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            ramWeight_startFlag<=1'b0;
            ramWeight_en<=1'b1;
            ramWeight_we<=1'b1;
            ramWeight_addrW<=5'd0;
            ramWeight_din<=128'd0;
        end
        else if (ramWeight_we==1'b1) begin
            if (ramWeight_addrW<5'd24) begin
                ramWeight_addrW<=ramWeight_addrW+1'b1;
                ramWeight_din<=ramWeight_din+1'b1;
            end
            else begin
                ramWeight_startFlag<=1'b1;
                ramWeight_we<=1'b0;
                ramWeight_addrW<=5'd0;
                ramWeight_din<=128'd0;
            end
        end
        else if (convFinish_flag) begin
            ramWeight_startFlag<=1'b0;
        end
    end

endmodule
