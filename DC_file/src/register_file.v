module register_file (
    input wire clk,                 // 时钟信号
    input wire rst,                 // 复位信号
    input wire [4:0] read_reg1,     // 读寄存器1地址
    input wire [4:0] read_reg2,     // 读寄存器2地址
    input wire [4:0] write_reg,     // 写寄存器地址
    input wire [31:0] write_data,   // 写数据
    input wire reg_write,           // 写使能信号
    output wire [31:0] read_data1,  // 读数据1
    output wire [31:0] read_data2   // 读数据2
);

    // 32个32位寄存器
    reg [31:0] registers [31:0];

    // 读操作
    assign read_data1 = registers[read_reg1];
    assign read_data2 = registers[read_reg2];
    integer i;
    // 初始化寄存器
    initial begin

        for (i = 0; i < 32; i = i + 1) begin
            registers[i] = 32'b0;
        end
    end

    // 写操作
    always @(posedge clk or posedge rst) begin
        if (!rst) begin
            // 复位时清零所有寄存器
            for (i = 0; i < 32; i = i + 1) begin
                registers[i] <= 32'b0;
            end
        end else if (reg_write) begin
            registers[write_reg] <= write_data;
        end
    end

endmodule
