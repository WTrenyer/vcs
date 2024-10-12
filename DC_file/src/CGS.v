`timescale 1ns/1ps

module CGS(
	input clk,
	input rst_n,
	output reg[7:0] K,
	output reg k_comma
);

always@(posedge clk or negedge rst_n)
begin
	if(!rst_n) begin
	    K <= 8'd0;
        k_comma <= 1'b0;
        end
	else begin
	    K <= 8'hBC;
	    k_comma <= 1'b1;
        end
end

endmodule
