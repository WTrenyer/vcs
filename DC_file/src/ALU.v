
module ALU (
    input [31:0] A,    // 32-bit input A
    input [31:0] B,    // 32-bit input B
    input [2:0] ALUOp, // 3-bit control signal
    output reg [31:0] Result, // 32-bit result
    output reg Zero,  // Zero flag
    output reg data_sign
);

always @(*) begin
    case (ALUOp)
        3'b000: Result = A + B;      // Addition
        3'b001: Result = A - B;      // Subtraction
        3'b010: Result = A & B;      // AND
        3'b011: Result = A | B;      // OR
        3'b100: Result = A ^ B;      // XOR
        3'b101: Result = ~(A | B);   // NOR
        3'b110: Result = A << B;     // Logical left shift
        3'b111: Result = A >> B;     // Logical right shift
        default: Result = 32'b0;     // Default 
    endcase

    // Set Zero flag if Result is zero
    Zero = (Result == 32'b0);
    data_sign = Result[31];
end

endmodule


module ImmediateExtender (
    input [11:0] immediate,   // 16-bit immediate input
    output reg [31:0] extended // 32-bit extended output
);

always @(*) begin

        extended = {{20{immediate[11]}}, immediate};

end

endmodule


module ALUControl(
    input [4:0] RD_A,
    input [4:0] RD_B,
    input [4:0] use_a,
    input [4:0] use_b,
    output reg [1:0] alu_a_choose,
    output reg [1:0] alu_b_choose
);

always @(*) begin
    // alu_a_choose logic
    if (use_a == RD_A) begin
        alu_a_choose = 2'b10; // EX stage data
    end else if (use_a == RD_B) begin
        alu_a_choose = 2'b11; // MEM stage data
    end else begin
        alu_a_choose = 2'b00; // Default to ID_EX data
    end

    // alu_b_choose logic
    if (use_b == RD_A) begin
        alu_b_choose = 2'b10; // EX stage data
    end else if (use_b == RD_B) begin
        alu_b_choose = 2'b11; // MEM stage data
    end else begin
        alu_b_choose = 2'b00; // Default to ID_EX data
    end
end

endmodule

