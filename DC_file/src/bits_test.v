`timescale 1ns / 1ps


module bits_test (

	clk									,// system clock
	rst_n								,// system reset signal low valid
	i_test_patten				,// the test patten config. signal. 2'b00: constant; 2'b01: counter; 2'b10: hot code 
	o_test_data					 //
	
);

//------------------------------------------------------------------------------
// ports defination
// =================
//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
//parameter define

parameter DW = 6;    // the multiple of 8; 1: 8bits  2: 16bits 

parameter CONSTANT = 8'hbc;  // the constant is BC(K28.5)

parameter HOT_CODE = 8'haa;

//---------------------------------input ports----------------------------------

input 							clk						;// system clock                                                                    
input							rst_n					;// system reset signal low valid                                                   
input 	[1 : 0]			i_test_patten ;// the test patten config. signal. 2'b00: constant; 2'b01: counter; 2'b10: hot code; 2'b11:8'h11

//---------------------------------output ports----------------------------------

output 	[DW*8 - 1 : 0]	o_test_data		;//                                                                                 

//------------------------------------------------------------------------------
// variables(reg/wire/parameter) declaration
// =========================================

reg			[DW*8 - 1 : 0]	s_test_data		;	

reg			[8 - 1 : 0]     hot_code_reserve;
 //------------------------------------------------------------------------------
// main code
// =========================================
//------------------------------------------------------------------------------

assign	o_test_data = s_test_data ;


always@(posedge clk or negedge rst_n)
	if (!rst_n)
		hot_code_reserve <= HOT_CODE;
	else
		hot_code_reserve <= ~hot_code_reserve;

always @ (posedge clk or negedge rst_n)
	if (!rst_n)
		s_test_data <= {DW{8'h00}};
	else 
		case (i_test_patten)
			2'b00 : s_test_data <= {DW{CONSTANT}};
			2'b01 : s_test_data <= s_test_data + 1'b1;
			2'b10 : s_test_data <= {DW{~hot_code_reserve}};
			2'b11 : s_test_data <= {DW{8'hff}};
		endcase


endmodule
