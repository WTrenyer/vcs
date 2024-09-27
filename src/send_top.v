`timescale 1ns/1ps
module send_top(
                 input clk,
				 input rst_n,
				 input sync,
				 
				 input mod, // mod =0 test or mod =1 data
				 
				 input [2:0] out_select,	//select lanex
				 
				 input [1:0] i_test_patten,					 

				 input  [47:0] data_i,


				 output reg [9:0]  encoder_out,
				 output reg RD_out,
				 
				 output [3:0] lfrs_out,
				 output reg [2:0] data_ctrl,
				 
				 output  clk_new 
				 

);

wire [47:0] o_test_data,adc_data;
reg  [47:0]adc_data_out;
wire [9:0] encoder_out_1,encoder_out_2,encoder_out_3,encoder_out_4,encoder_out_5,encoder_out_6,encoder_out_7,encoder_out_8;
wire RD_out_1,RD_out_2,RD_out_3,RD_out_4,RD_out_5,RD_out_6,RD_out_7,RD_out_8;
wire [2:0] data_ctrl_1,data_ctrl_2,data_ctrl_3,data_ctrl_4,data_ctrl_5,data_ctrl_6,data_ctrl_7,data_ctrl_8;

assign clk_new = clk;



always@(posedge clk or negedge rst_n)
begin
	if(!rst_n)
		adc_data_out <= 48'b0;
	else if(mod == 1'b0)
		adc_data_out <= o_test_data;
	else 
		adc_data_out <= data_i;
end



always@(*)

begin
	case(out_select) 
	            3'd0:begin encoder_out=encoder_out_1; RD_out=RD_out_1;data_ctrl=data_ctrl_1;end				
				3'd1:begin encoder_out=encoder_out_2; RD_out=RD_out_2;data_ctrl=data_ctrl_2;end
				3'd2:begin encoder_out=encoder_out_3; RD_out=RD_out_3;data_ctrl=data_ctrl_3;end
				3'd3:begin encoder_out=encoder_out_4; RD_out=RD_out_4;data_ctrl=data_ctrl_4;end
				3'd4:begin encoder_out=encoder_out_5; RD_out=RD_out_5;data_ctrl=data_ctrl_5;end
				3'd5:begin encoder_out=encoder_out_6; RD_out=RD_out_6;data_ctrl=data_ctrl_6;end
				3'd6:begin encoder_out=encoder_out_7; RD_out=RD_out_7;data_ctrl=data_ctrl_7;end
				3'd7:begin encoder_out=encoder_out_8; RD_out=RD_out_8;data_ctrl=data_ctrl_8;end

				//default:begin encoder_out=10'd0; RD_out=1'd0;end
	endcase
	end

bits_test dds(

	.clk(clk),									// system clock
	.rst_n(rst_n),								// system reset signal low valid
	.i_test_patten(i_test_patten),				// the test patten config. signal. 2'b00: constant; 2'b01: counter; 2'b10: hot code 
	.o_test_data(o_test_data)		
);

wire [7:0] lane0,lane1,lane2,lane3,lane4,lane5,lane6,lane7;

frame_top u0(
                   .clk(clk),
                   .rst_n(rst_n),
                   .adc_data_out(adc_data_out),
				   
				   .lfrs_out   (lfrs_out),  
				   
                   .lane0(lane0),
                   .lane1(lane1),
                   .lane2(lane2),
                   .lane3(lane3),
                   .lane4(lane4),
                   .lane5(lane5),
                   .lane6(lane6),
                   .lane7(lane7)
);

link1 u1(      .clk(clk),
               .rst_n(rst_n),
			   .sync(sync),
			   .data_T(lane0),
			   
			   .data_ctrl(data_ctrl_1),
			   
			   .RD_out(RD_out_1),
			   .encoder_out(encoder_out_1)
);

link1 u2(      .clk(clk),
               .rst_n(rst_n),
			   .sync(sync),
			   .data_T(lane1),
			   
			   .data_ctrl(data_ctrl_2),
			   
			   .RD_out(RD_out_2),
			   .encoder_out(encoder_out_2)
);	

link1 u3(      .clk(clk),
              .rst_n(rst_n),
			   .sync(sync),
			   .data_T(lane2),
			   
			   .data_ctrl(data_ctrl_3),
			   
			   .RD_out(RD_out_3),
			   .encoder_out(encoder_out_3)
);

link1 u4(      .clk(clk),
               .rst_n(rst_n),
			   .sync(sync),
			   .data_T(lane3),
			   
			   .data_ctrl(data_ctrl_4),
			   
			   .RD_out(RD_out_4),
			   .encoder_out(encoder_out_4)
);	

link1 u5(      .clk(clk),
              .rst_n(rst_n),
			   .sync(sync),
			   .data_T(lane4),
			   
			   .data_ctrl(data_ctrl_5),
			   
			   .RD_out(RD_out_5),
			   .encoder_out(encoder_out_5)
);			   		   			   

link1 u6(      .clk(clk),
               .rst_n(rst_n),
			   .sync(sync),
			   .data_T(lane5),
			   
			   .data_ctrl(data_ctrl_6),
			   
			   .RD_out(RD_out_6),
			   .encoder_out(encoder_out_6)
);			   			   

link1 u7(      .clk(clk),
               .rst_n(rst_n),
			   .sync(sync),
			   .data_T(lane6),
			   
			   .data_ctrl(data_ctrl_7),
			   
			   .RD_out(RD_out_7),
			   .encoder_out(encoder_out_7)
);			   

link1 u8(      .clk(clk),
               .rst_n(rst_n),
			   .sync(sync),
			   .data_T(lane7),
			   
			   .data_ctrl(data_ctrl_8),
			   
			   .RD_out(RD_out_8),
			   .encoder_out(encoder_out_8)
);			   

endmodule
