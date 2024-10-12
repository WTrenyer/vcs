`timescale 1ns/1ps

module frame_top(  
                   input        clk,
                   input        rst_n,
                   input [47:0] adc_data_out,
				   
				   output [3:0] lfrs_out,
				   
                   output [7:0] lane0,
                   output [7:0] lane1,
				   output [7:0] lane2,
				   output [7:0] lane3,
				   output [7:0] lane4,
				   output [7:0] lane5,
				   output [7:0] lane6,
				   output [7:0] lane7
               );			  



t_frame  u0 (  .clk        (clk)      ,
               .rst_n      (rst_n)    ,
               .adc_data   (adc_data_out) ,
               .lfrs       (lfrs_out)    ,
               .lane0      (lane0)    ,
               .lane1      (lane1)    ,
               .lane2      (lane2)    ,
               .lane3      (lane3)    ,
               .lane4      (lane4)    ,
               .lane5      (lane5)    ,
               .lane6      (lane6)    ,
               .lane7      (lane7)
              );

lfrs   u1 (    .clk        (clk)      ,
               .rst_n      (rst_n)   ,
               .lfrs_out   (lfrs_out)              
               );
 endmodule

               
