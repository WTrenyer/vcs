`timescale 1ns/1ps

module ILA(
	        input clk,
        	input rst_n,
        	input [7:0] in,
        	input [31:0] Byte_Cnt,
        	input [3:0] ILA_Cnt,
			
			
	        output reg [7:0] ILA,
	        output reg ila_comma	
);





always @(posedge clk, negedge rst_n)
begin
	if(!rst_n)
	begin
	    ILA <= 8'd0;
	end 
	else if(Byte_Cnt[31]) 
		ILA <= 8'h7c;
	else if(Byte_Cnt[0]) 
		ILA <= 8'h1c;
	else if(Byte_Cnt[1] & ILA_Cnt[1])
		ILA <= 8'h9c;
	else
		ILA <= in;
	
end


always @(posedge clk, negedge rst_n)
begin
   if(!rst_n)
	ila_comma <= 1'b0;
   else if(Byte_Cnt[0] | Byte_Cnt[31] | (Byte_Cnt[1] & ILA_Cnt[1]))
	ila_comma <= 1'b1;
   else
	ila_comma <= 1'b0;

end




endmodule
