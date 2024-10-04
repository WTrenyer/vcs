module Memory (
    input clk,
    input wd_en, // Write Enable
    input rd_en,
    input [4:0] addr, // 5-bit address for 32 locations
    input [31:0] din, // Data input for write operations
    output reg [31:0] dout // Data output for read operations
);

    // Define a distributed RAM with 32 32-bit locations
    reg [31:0] mem [31:0];

integer i ;
initial begin
    for (i =0 ;i<31 ; i=i+1) begin
        mem[i] = 0;
    end
end
    // Read operation
    always @(posedge clk) begin
        dout <= mem[addr];
    end

    // Write operation
    always @(posedge clk) begin
        if (wd_en) begin
            mem[addr] <= din;
        end
    end

endmodule
