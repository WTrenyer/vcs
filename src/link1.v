`timescale 1ns/1ps

module link1(  
               input clk,
               input rst_n,
			   input sync,
			   input [7:0] data_T,
			   
			   output[2:0] data_ctrl,
			   
			   output RD_out,
			   output [9:0] encoder_out

);

wire Lane1_Comma;
wire [7:0] Lane1_Data;

Top u1(
 	    .clk(clk),
	    .rst_n(rst_n),
     	.sync(sync),
	    .data_T(data_T),
	
	    .data_ctrl(data_ctrl),
	    
	    .Lane1_Comma(Lane1_Comma),
	    .Lane1_Data(Lane1_Data)      
);

encoder_top u2(
                    .clk(clk),
	                .rst_n(rst_n),
	                .K(Lane1_Comma),
	            	.encoder_in(Lane1_Data),
		
	                .encoder_out(encoder_out), 
                    .RD_out(RD_out)
);

endmodule
