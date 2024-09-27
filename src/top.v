module top (
    input clk,
    input res_clk,
	output wire led,
    input rst
);

// 定义一个 8 位的寄存器来存储地址
reg [31:0] Address;
reg [255:0] PC;
reg [255:0] IF_ID ;
reg [255:0] ID_EX;
reg [255:0] EX_MEN ;
reg [255:0] MEM_WB ;
wire jump_sign;
wire flash;
wire Zero;
wire data_sign;

wire pause;

wire jump_b0_sign,jump_b1_sign;
wire [31:0] jump_imm;
wire [31:0] PC_jump_data ;
wire sign1,sign2,sign3 ,sign4,sign5;
assign led = PC[2];
assign jump_imm = EX_MEN[255:224];
assign jump_b0_sign = ((EX_MEN[1:0] == 2'b10) & ((EX_MEN[38]&(EX_MEN[37] == EX_MEN[97]))));
assign jump_b1_sign = ((EX_MEN[1:0] == 2'b10) & (~EX_MEN[38])&(EX_MEN[37] == EX_MEN[96]));
assign sign1 = EX_MEN[96] ;
assign sign2 = EX_MEN[97];
assign sign3 = EX_MEN[37];
assign sign4 = EX_MEN[38];
assign sign5 = (EX_MEN[1:0] == 2'b10);
assign jump_sign = (EX_MEN[1:0] == 2'b01)|
                    jump_b0_sign|
                    jump_b1_sign;
assign flash    = jump_sign;
assign PC_jump_data = EX_MEN[223:192];
// PC
wire [31:0] Instruction;
always @(posedge clk) begin
    if (!rst) begin
        PC <= 0;
    end else begin
    if (jump_sign) begin
        PC[31:0] <= PC_jump_data + jump_imm;
    end else if (pause) begin
        PC <= PC;
    end else
    begin
        PC[31:0] <= PC[31:0] +4;
    end
    end
end

wire [7:0] i_counter;
assign i_counter = (PC[31:0])/4;
InstructionMemory InstructionMemory (
    .Address(i_counter),    // 使用输出端口作为地址输入
    .Instruction(Instruction)  // 不明确指定 Instruction 的连接方式，假设它是输出
);

wire [63:0] sign;

control contro0l(
    .Instruction(Instruction),
    .sign(sign)
);

// reg [64:0] IF_ID ;
wire [11:0] i_immi;
wire [11:0] s_immi;
wire [11:0] b_immi;
wire [11:0] j_immi;
assign i_immi = Instruction[31:20];
assign s_immi = {Instruction[31:25], Instruction[11:7]};
assign b_immi = {Instruction[31], Instruction[7], Instruction[30:25], Instruction[11:8]}*4;
assign j_immi = {Instruction[31],Instruction[19:12],Instruction[20],Instruction[30:21]};
wire [31:0]IF_PC;
assign IF_PC = PC[31:0]+4;


always @(posedge clk) begin
    if (!rst|| flash) begin
        IF_ID <= 0;
    end else begin
        if (pause) begin
            IF_ID<=IF_ID;
        end else begin
        IF_ID <= {
	IF_PC
        ,j_immi    //111:100
        ,b_immi  // 99:88
        , s_immi // 87:76
        , i_immi // 75:64
        , sign}; // 63:0
        end
    end
end

wire [31:0] read_data1;
wire [31:0] read_data2;
wire [31:0] write_data_register;
wire write_data_register_en;
wire [4:0] read_reg1;
wire [4:0] read_reg2;
wire [4:0] write_reg;

assign read_reg1 = IF_ID[6:2];
assign read_reg2 = IF_ID[11:7];
assign write_reg = MEM_WB[26:22];
assign write_data_register_en = MEM_WB[12];

register_file register_file(
    .clk(res_clk),
    .rst(rst),
    .read_reg1(read_reg1),
    .read_reg2(read_reg2),
    .write_reg(write_reg),
    .write_data(write_data_register),
    .reg_write(write_data_register_en),
    .read_data1(read_data1),
    .read_data2(read_data2)
);

wire [11:0] immediate;
wire [31:0] extended;
wire [1:0] immi_choose;
assign immi_choose = IF_ID[21:20];
assign immediate = (immi_choose == 2'b01) ? IF_ID[75:64] : 
                    (immi_choose == 2'b11)?IF_ID[87:76]:
                    (immi_choose == 2'b10)?IF_ID[99:88]:IF_ID[111:100];

ImmediateExtender ImmediateExtender(
    .immediate(immediate),
    .extended(extended)
);

wire [31:0] ID_EX_PC;
assign ID_EX_PC = IF_ID[143:112];
// reg [127:0] ID_EX;
always @(posedge clk) begin
    if (!rst|| flash) begin
        ID_EX <= 0;
    end else begin
        if (pause) begin
            ID_EX<=ID_EX;
        end else begin
        ID_EX <= { extended, read_data2, read_data1, IF_ID[63:0]};
        ID_EX[255:224] <= ID_EX_PC;
        end
    end
end
wire [31:0] enten_data;
assign enten_data = ID_EX[159:128];

wire [4:0] RD_a;
reg [4:0] RD_b;
wire [4:0] RD0_a;
reg [4:0] RD0_b;

assign  RD_a = EX_MEN[26:22];
assign RD0_a = MEM_WB[26:22];
wire [31:0] alu_a;
wire [1:0]alu_a_choose;
wire [31:0] alu_b;
wire [1:0]alu_b_choose;
wire [2:0] ALUOp;

wire [31:0] Result;

ALUControl ALUControl(
    .RD_A(RD_a),
    .RD_B(RD0_a),
    .use_a(ID_EX[6:2]),
    .use_b(ID_EX[11:7]),
    .alu_a_choose(alu_a_choose),
    .alu_b_choose(alu_b_choose)
);
wire [1:0] alu_a_idex;
wire [1:0] alu_b_idex;
assign alu_a_idex = ID_EX[19:18];
assign alu_b_idex = ID_EX[17:16];
assign ALUOp = ID_EX[15:13];
assign alu_a = (alu_a_idex == 2'b00) ?
               ((alu_a_choose == 2'b00) ? ID_EX[95:64] :
                (alu_a_choose == 2'b10) ? EX_MEN[95:64] :
                (alu_a_choose == 2'b11) ? MEM_WB[95:64] :
                32'bx)
               : ID_EX[255:224];

assign alu_b = (alu_b_idex == 2'b01) ?
               ID_EX[159:128] :
               (alu_b_choose == 2'b00) ? ID_EX[127:96] :
               (alu_b_choose == 2'b10) ? EX_MEN[95:64] :
               (alu_b_choose == 2'b11) ? MEM_WB[95:64] :
               32'bx;


ALU ALU (
    .A(alu_a),
    .B(alu_b),
    .ALUOp(ALUOp),
    .Result(Result),
    .Zero(Zero),
    .data_sign(data_sign)
);

// reg [127:0] EX_MEN ;

wire [31:0] EX_MEN_PC;
wire [31:0] res2_data;
assign res2_data = ID_EX[127:96];
assign EX_MEN_PC = ID_EX[255:224];
always @(posedge clk) begin
    if (!rst || flash) begin
        EX_MEN <= 0;
    end else begin
        if (pause) begin
            EX_MEN<=EX_MEN;
        end else begin
        EX_MEN <= {data_sign , Zero, Result, ID_EX[63:0]};
        EX_MEN[255:224] <= enten_data;
        EX_MEN[223:192] <= EX_MEN_PC;
        EX_MEN[191:160] <= res2_data;
        end

    end
end

wire [31:0] mem_res_data;

wire [31:0] store_data;
assign store_data = EX_MEN[191:160];


wire [4:0] mem_addr;
wire mem_we,mem_rd;
wire [31:0] mem_din,mem_dout;
wire [2:0]mem_type;

assign mem_type = EX_MEN[41:39];
assign mem_rd = EX_MEN[36];
assign mem_we = EX_MEN[35];
assign mem_addr = EX_MEN[95:64];
assign mem_din = {store_data[7:0],mem_type[0]&store_data[15:8],mem_type[1]&store_data[31:16]};
assign mem_res_data = {mem_dout[7:0],mem_type[0]&mem_dout[15:8],mem_type[1]&mem_dout[31:16]};

reg pause_1,pause_0 ;
assign pause = (~pause_1)&pause_0;
always @(posedge clk) begin
    if (!rst) begin
        pause_0<=0;
        pause_1<=0;
    end else begin
        pause_0<=mem_rd;
        pause_1<=pause_0;
    end
end

Memory mem0 (
    .clk(clk),
    .wd_en(mem_we),
    .rd_en(mem_rd),
    .addr(mem_addr),
    .din(mem_din),
    .dout(mem_dout)
);




// MEM_WB
always @(posedge clk) begin
    if (!rst) begin
        MEM_WB <= 0;
    end else begin
        if (mem_rd) begin
            MEM_WB<=MEM_WB;
        end else begin
            if (pause_0) begin
                MEM_WB <= {EX_MEN[255:96],mem_res_data,EX_MEN[63:0]};
            end else
                MEM_WB <= EX_MEN;
        end
    end
end

wire [31:0] res_data;
assign res_data = MEM_WB[95:64];

assign write_data_register = res_data;

endmodule
