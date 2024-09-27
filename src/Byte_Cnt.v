`timescale 1ns/1ps

module Byte_Cnt(
	input clk,
	input rst_n,
	input sync,
	output reg [31:0] cnt
);

 
always @(posedge clk, negedge  rst_n)
begin
	if(! rst_n)
	    cnt <= 32'd1;
	else if(!sync)
	    cnt <= 32'd1;
	else
	    cnt <= {cnt[30:0], cnt[31]};
end

 

endmodule
