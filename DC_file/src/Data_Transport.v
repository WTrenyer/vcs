`timescale 1ns / 1ps

module Data_Transport(
	input [31:0] Byte_Cnt,
	input clk, 
	input [7:0] data_in,
	input rst_n,
	
	output reg [7:0] data,
	output reg data_comma
);

reg [7:0] data_Temp;

always @(posedge clk, negedge rst_n)
begin
if(!rst_n)begin
	    data <= 8'd0;
	    data_Temp <= 8'd0;
	    data_comma <=1'b0;
        end
else if(Byte_Cnt[4] | Byte_Cnt[8] | Byte_Cnt[12] | Byte_Cnt[16] | Byte_Cnt[20] | Byte_Cnt[24]| Byte_Cnt[28])
    begin
	if(data_Temp == data_in )
	begin
		data <= 8'hfc;
		data_comma <= 1;
	end
	else begin
		data_Temp <= data_in;
		data <= data_in;
		data_comma <= 0;
	    end		    
	end
else if(Byte_Cnt[0])
	begin
	if(data_Temp == data_in)
	begin
	 	data <=  8'h7c;
	    data_comma <= 1;
	end
	else begin
		data_Temp <= data_in;
		data <= data_in;
		data_comma <= 0;
	    end
	end
else begin
	    data_Temp <= data_Temp;
		data <= data_in;
		data_comma <= 0;
	 end
end


endmodule
