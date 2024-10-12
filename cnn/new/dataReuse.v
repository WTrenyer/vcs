`timescale 1ns / 1ps

module dataReuse(
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
    output [127:0]  ramImage_dout,

    input           ramWeight_en,
    input           ramWeight_we,
    input  [4:0]    ramWeight_addrW,
    input  [127:0]  ramWeight_din,
    output [127:0]  ramWeight_dout,

    output  reg     convFinish,     //卷积完成
    output  reg     computeClear    //每25个时钟对计算单元输出结果清零一次
    );

    wire    [4:0]   E;  //最大值为32-5+1=28
    wire    [4:0]   F;

    reg     [2:0]   cnt_w;     //5*5卷积核横向计数
    reg     [2:0]   cnt_h;     //5*5卷积核纵向计数
    reg     [4:0]   cnt_e;     //卷积核横向计数
    reg     [4:0]   cnt_f;     //卷积核纵向计数
    reg     [3:0]   cnt_c;     //C3层需要重复输出四次图像，C5层需要重复输出十六次图像

    reg             computeClear_0;
    reg             computeClear_1;
    reg             computeClear_2;
    reg             computeClear_3;

    reg     [9:0]   ramImage_addrR;
    reg     [4:0]   ramWeight_addrR;

    wire    [9:0]   ramImage_addr;
    wire    [4:0]   ramWeight_addr;

    reg     [1:0]   convStart_r;
    wire            convStart_flag;     //脉冲信号

    assign E = W-4;
    assign F = H-4;

    assign ramImage_addr = ramImage_we ? ramImage_addrW : ramImage_addrR;
    assign ramWeight_addr = ramWeight_we ? ramWeight_addrW : ramWeight_addrR;
    
    assign convStart_flag = (convStart_r[0]==1'b1) & (convStart_r[1]==1'b0);

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

    //cnt_w为0~4的循环
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            cnt_w<=3'd0;
        end
        else if ((convStart==1'b1) && (ramImage_we==1'b0)) begin
            if (cnt_w<3'd4) begin
                cnt_w<=cnt_w+1'b1;
            end
            else begin
                cnt_w<=3'd0;
            end
        end
        else begin
            cnt_w<=3'd0;
        end
    end

    //cnt_h为0~4的循环(当cnt_w=4时加一)
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            cnt_h<=3'd0;
        end
        else if ((convStart==1'b1) && (ramImage_we==1'b0)) begin
            if (cnt_w==3'd4) begin
                if (cnt_h<3'd4) begin
                    cnt_h<=cnt_h+1'b1;
                end
                else begin
                    cnt_h<=3'd0;
                end
            end
            else begin
                cnt_h<=cnt_h;
            end
        end
        else begin
            cnt_h<=3'd0;
        end
    end

    //cnt_e为0~E的循环(当cnt_h=4且cnt_w=4时加一)
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            cnt_e<=5'd0;
        end
        else if ((convStart==1'b1) && (ramImage_we==1'b0)) begin
            if ((cnt_h==3'd4) && (cnt_w==3'd4)) begin
                if (cnt_e<E-1) begin
                    cnt_e<=cnt_e+1'b1;
                end
                else begin
                    cnt_e<=5'd0;
                end
            end
            else begin
                cnt_e<=cnt_e;
            end
        end
        else begin
            cnt_e<=5'd0;
        end
    end

    //cnt_f为0~27的循环(当cnt_e=27时加一)
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            cnt_f<=5'd0;
        end
        else if ((convStart==1'b1) && (ramImage_we==1'b0)) begin
            if ((cnt_e==E-1) && (cnt_h==3'd4) && (cnt_w==3'd4)) begin
                if (cnt_f<F-1) begin
                    cnt_f<=cnt_f+1'b1;
                end
                else begin
                    cnt_f<=5'd0;
                end
            end
            else begin
                cnt_f<=cnt_f;
            end
        end
        else begin
            cnt_f<=5'd0;
        end
    end

    //cnt_c为0~3（C3）或0~16（C5）根据C的值来定
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            cnt_c<=4'd0;
        end
        else if ((convStart==1'b1) && (ramImage_we==1'b0)) begin
            if ((cnt_f==F-1) && (cnt_e==E-1) && (cnt_h==3'd4) && (cnt_w==3'd4)) begin
                if (cnt_c<C) begin
                    cnt_c<=cnt_c+1'b1;
                end
                else begin
                    cnt_c<=4'd0;
                end
            end
            else begin
                cnt_c<=cnt_c;
            end
        end
        else begin
            cnt_c<=4'd0;
        end
    end

    //读ramImage的地址计算
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            ramImage_addrR<=10'd0;
        end
        else begin
            ramImage_addrR<=W*(cnt_f+cnt_h)+(cnt_e+cnt_w);
        end
    end

    //读ramWeight的地址计算
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            ramWeight_addrR<=5'd0;
        end
        else begin
            ramWeight_addrR<=5*cnt_h+cnt_w;
        end
    end

    //每25个时钟对计算单元累加输出结果清零一次(脉冲信号)
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            computeClear_0<=1'b0;
        end
        else if ((cnt_h==3'd4) && (cnt_w==3'd4)) begin
            computeClear_0<=1'b1;
        end
        else begin
            computeClear_0<=1'b0;
        end
    end

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            computeClear_1<=1'b0;
            computeClear_2<=1'b0;
            computeClear_3<=1'b0;
            computeClear<=1'b0;
        end
        else begin
            computeClear_1<=computeClear_0;
            computeClear_2<=computeClear_1;
            computeClear_3<=computeClear_2;
            computeClear<=computeClear_3;
        end
    end

    //C1层卷积完成信号(电平型)
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            convFinish<=1'b0;
        end
        else if (convStart_flag==1'b1) begin
            convFinish<=1'b0;
        end
        else if ((cnt_c==C) && (computeClear_3==1'b1)) begin
            convFinish<=1'b1;
        end
    end

    //深度为5*5=25，宽度为8*16=128
    blk_mem_gen_0 ram_weight(
        .clka(clk),    // input wire clka
        .ena(rst_n & ramWeight_en),      // input wire ena
        .wea(ramWeight_we),      // input wire [0 : 0] wea
        .addra(ramWeight_addr),  // input wire [4 : 0] addra
        .dina(ramWeight_din),    // input wire [127 : 0] dina
        .douta(ramWeight_dout)  // output wire [127 : 0] douta
    );

    //深度为32*32=1024，宽度为8*16=128
    blk_mem_gen_1 ram_image(
        .clka(clk),    // input wire clka
        .ena(rst_n & ramImage_en),      // input wire ena
        .wea(ramImage_we),      // input wire [0 : 0] wea
        .addra(ramImage_addr),  // input wire [9 : 0] addra
        .dina(ramImage_din),    // input wire [127 : 0] dina
        .douta(ramImage_dout)  // output wire [127 : 0] douta
    );

endmodule
