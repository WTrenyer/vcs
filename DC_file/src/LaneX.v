`timescale 1ns/1ps

module LaneX(
	input        clk,
	input        rst_n,
	input [7:0]  data_T,
	input [2:0]  Data_Ctrl,
	input [31:0] Byte_Count,
	input [3:0]  ILA_Cnt,
	
	
	output       lane_data_comma,
	output [7:0] lane_data_out
);

wire k_comma,ila_comma,data_comma;
wire [7:0]  K, ILA, data;

CGS  mod1(
	.clk(clk),
	.rst_n(rst_n),
	
    .K(K),
    .k_comma(k_comma)
);



ILA mod2(
	.clk(clk),
	.rst_n(rst_n),
	.in(data_T),
	.Byte_Cnt(Byte_Count),
	.ILA_Cnt(ILA_Cnt),
	
    .ILA(ILA),
    .ila_comma(ila_comma)   
);



Data_Transport mod3    (
	.Byte_Cnt(Byte_Count),
	.clk(clk),
	.data_in(data_T),
	.rst_n(rst_n),
	
    .data(data),
    .data_comma(data_comma)
);

assign lane_data_out = Data_Ctrl[0] ? K : Data_Ctrl[1] ? ILA :data;
assign lane_data_comma = Data_Ctrl[0] ? k_comma : Data_Ctrl[1] ? ila_comma :data_comma;


endmodule
