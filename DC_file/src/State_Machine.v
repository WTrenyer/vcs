`timescale 1ns/1ps

module State_Machine(
	input clk,
	input rst_n,
	input sync,
	input [31:0] Byte_Cnt,
	
	output wire [2:0] data_ctrl,
	output wire [3:0] ILA_Cnt_O
   
);


reg [2:0] state, next_state;
reg  CGS_End;
reg [4:0] ILA_Cnt;

parameter s_0 = 3'b001,
	      s_1 = 3'b010,
	      s_2 = 3'b100;
			


always @(posedge clk or negedge  rst_n)
begin
	if(!rst_n)
	state <= s_0;
	else 
	state <= next_state;
end

always @(posedge clk or negedge  rst_n)
begin
	if(!rst_n)
		CGS_End <= 0;
	else if(Byte_Cnt[31])
		CGS_End <= 1;
	else    
	    CGS_End <= 0;
end

always @(posedge clk or negedge  rst_n)
begin
	if(!rst_n)
		ILA_Cnt <= 5'd1;
	else if( Byte_Cnt[31] & (state == s_1))
		ILA_Cnt <= {ILA_Cnt[3:0], ILA_Cnt[4]};
	else if(!sync)
		ILA_Cnt <=  5'd1;
	else
		ILA_Cnt <= ILA_Cnt;
end



always @(*)
begin
	case(state)
	s_0: if(sync  & CGS_End)   
	          next_state = s_1; 
		 else next_state = s_0;
	s_1: if(~sync)  
	          next_state = s_0; 
	     else if( Byte_Cnt[0] & ILA_Cnt[4] ) 
		      next_state = s_2; 
		 else next_state = s_1;
	s_2: if(~sync)  
	          next_state = s_0; 
		 else next_state = s_2;
	default:  next_state = s_0;
	endcase
end

assign data_ctrl = state;
assign ILA_Cnt_O = ILA_Cnt[3:0];




endmodule
