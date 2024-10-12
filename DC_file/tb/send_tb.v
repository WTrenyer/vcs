`timescale 1ns/1ps
//`include "/mount/home/hq/arm/umc/l28hlp/sc12mc_base_rvt_c35/UM17LB001-FE-00000-r0p0-01eac0/verilog/sc12mc_l28hlp_base_rvt_c35.v"


module send_tb;

reg clk;
reg rst_n;
reg [47:0] data_i;
reg [2:0] out_select;
reg [1:0] i_test_patten;
reg mod;
reg sync;

wire [9:0] encoder_out;
wire RD_out;

wire [3:0] lfrs_out;
wire [2:0] data_ctrl; 				 
wire clk_new;

send_top u0(
        .clk(clk),
	    .rst_n(rst_n),
	    .i_test_patten(i_test_patten),
	    .out_select(out_select),
	    .mod(mod),
	    .data_i(data_i),
	    .sync(sync),
		
		.lfrs_out(lfrs_out), 
	    .data_ctrl(data_ctrl),
				 
	    .encoder_out(encoder_out),
	    .RD_out(RD_out),
	    
	    .clk_new(clk_new)
			
);

initial
begin
    clk = 0;  
    rst_n = 0;
    
    sync = 1;
    mod = 1;   
    out_select = 3'd0;    
    
    data_i=48'd0;
    i_test_patten = 2'b11; 
	
    #30 sync = 0;
    #20 sync = 1;	
    #50 rst_n =1;  
	
end

always 
begin
    #10 clk = ~clk;
end 

//generate adc_data
reg [47:0] adc_count;


always@(posedge clk or posedge rst_n)
 begin 
 if(!rst_n)begin
        adc_count<=0;
        data_i <= 0;
   end
 else if(adc_count==48'd111111_111111_111111_111111_111111_111111_111111_111111_)
        adc_count<=48'd0;
 else begin
        adc_count <= adc_count+1;
        data_i <= adc_count;
       end 		  
 end 

//save the waveform
/*
initial 
begin
     $vcdplusfile("send_top_wave.vpd");
     $vcdpluson(0,send_tb);
     //$sdf_annotate("send_top.sdf",send_top);
end

initial begin
  repeat(1000) @(posedge clk);
  $finish;
end
*/

endmodule
