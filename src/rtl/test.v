module Control (
    input [6:0] opcode,    // 指令的opcode字段
    input [2:0] funct3,    // 指令的funct3字段
    input [6:0] funct7,    // 指令的funct7字段
    output reg [3:0] ALUControl, // ALU控制信号
    output reg RegWrite,   // 寄存器写使能
    output reg MemRead,    // 内存读使能
    output reg MemWrite,   // 内存写使能
    output reg MemToReg,   // 内存到寄存器
    output reg ALUSrc,     // ALU源操作数选择
    output reg Branch      // 分支控制信号
);

    always @(*) begin
        // 默认信号
        ALUControl = 4'b0000;
        RegWrite = 1'b0;
        MemRead = 1'b0;
        MemWrite = 1'b0;
        MemToReg = 1'b0;
        ALUSrc = 1'b0;
        Branch = 1'b0;

        case (opcode)
            7'b0110011: begin // R-type instructions
                RegWrite = 1'b1;
                case ({funct7, funct3})
                    10'b0000000_000: ALUControl = 4'b0010; // ADD
                    10'b0100000_000: ALUControl = 4'b0110; // SUB
                    10'b0000000_111: ALUControl = 4'b0000; // AND
                    10'b0000000_110: ALUControl = 4'b0001; // OR
                    10'b0000000_100: ALUControl = 4'b0011; // XOR
                    10'b0000000_001: ALUControl = 4'b0100; // SLL
                    10'b0000000_101: ALUControl = 4'b0101; // SRL
                    10'b0100000_101: ALUControl = 4'b0111; // SRA
                    10'b0000000_010: ALUControl = 4'b1000; // SLT
                    10'b0000000_011: ALUControl = 4'b1001; // SLTU
                    default: ALUControl = 4'b0000;
                endcase
            end

            7'b0010011: begin // I-type instructions
                RegWrite = 1'b1;
                ALUSrc = 1'b1;
                case (funct3)
                    3'b000: ALUControl = 4'b0010; // ADDI
                    3'b111: ALUControl = 4'b0000; // ANDI
                    3'b110: ALUControl = 4'b0001; // ORI
                    3'b100: ALUControl = 4'b0011; // XORI
                    3'b001: ALUControl = 4'b0100; // SLLI
                    3'b101: begin
                        if (funct7 == 7'b0000000) 
                            ALUControl = 4'b0101; // SRLI
                        else if (funct7 == 7'b0100000) 
                            ALUControl = 4'b0111; // SRAI
                    end
                    3'b010: ALUControl = 4'b1000; // SLTI
                    3'b011: ALUControl = 4'b1001; // SLTIU
                    default: ALUControl = 4'b0000;
                endcase
            end

            7'b0000011: begin // Load instructions
                RegWrite = 1'b1;
                MemRead = 1'b1;
                MemToReg = 1'b1;
                ALUSrc = 1'b1;
                ALUControl = 4'b0010; // ADD for address calculation
            end

            7'b0100011: begin // Store instructions
                MemWrite = 1'b1;
                ALUSrc = 1'b1;
                ALUControl = 4'b0010; // ADD for address calculation
            end

            7'b1100011: begin // Branch instructions
                Branch = 1'b1;
                case (funct3)
                    3'b000: ALUControl = 4'b0110; // BEQ
                    3'b001: ALUControl = 4'b0110; // BNE
                    3'b100: ALUControl = 4'b1000; // BLT
                    3'b101: ALUControl = 4'b1001; // BGE
                    3'b110: ALUControl = 4'b1000; // BLTU
                    3'b111: ALUControl = 4'b1001; // BGEU
                    default: ALUControl = 4'b0000;
                endcase
            end

            7'b1101111: begin // JAL
                RegWrite = 1'b1;
                ALUControl = 4'b0010; // JAL uses ADD for PC+imm
            end

            7'b1100111: begin // JALR
                RegWrite = 1'b1;
                ALUSrc = 1'b1;
                ALUControl = 4'b0010; // JALR uses ADD for PC+imm
            end

            7'b0110111: begin // LUI
                RegWrite = 1'b1;
                ALUControl = 4'b1010; // LUI specific ALU control
            end

            7'b0010111: begin // AUIPC
                RegWrite = 1'b1;
                ALUControl = 4'b1011; // AUIPC specific ALU control
            end

            default: begin
                // 默认情况下所有控制信号都为0
                ALUControl = 4'b0000;
                RegWrite = 1'b0;
                MemRead = 1'b0;
                MemWrite = 1'b0;
                MemToReg = 1'b0;
                ALUSrc = 1'b0;
                Branch = 1'b0;
            end
        endcase
    end

endmodule
