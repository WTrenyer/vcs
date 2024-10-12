`timescale 1ns / 1ps

module fifo784(
    dout         ,
    wfull        ,
    rempty       , 
    awfull       ,
    arempty      ,
    overflow     ,
    underflow    ,
    rclk         ,
    wclk         , 
    rrst_b       ,
    wrst_b       ,
    din          ,
    re           ,
    we           ,
    wclr         ,
    rclr
    );
          
//parameters
parameter H=100;                   //
parameter TA = 8;                 //
parameter TB = 2;                 //
parameter W =32;                   //
parameter OREG =0 ;               //
parameter BWA=0;                  //

parameter L =  ( H <= 2 ) ? 1 :   //
               ( H <= 4 ) ? 2 :
               ( H <= 8 ) ? 3 :
               ( H <= 16 ) ? 4 :
               ( H <= 32 ) ? 5 :
               ( H <= 64 ) ? 6 :
               ( H <= 128 ) ? 7 :
               ( H <= 256 ) ? 8 :
               ( H <= 512 ) ? 9 :
               ( H <= 1024 ) ? 10 :
               ( H <= 2048 ) ? 11 :
               ( H <= 4096 ) ? 12 :
               ( H <= 8192 ) ? 13 : 
               ( H <= 16384 ) ? 14 : 
               ( H <= 32768 ) ? 15 : 16;    
 
//localparam RAM_H= ( H <= 2 ) ? 2 :   //
//               ( H <= 4 ) ? 4 :
//               ( H <= 8 ) ? 8 :
//               ( H <= 16 ) ? 16 :
//               ( H <= 32 ) ? 32 :
//               ( H <= 64 ) ? 64 :
//               ( H <= 128 ) ? 128 :
//               ( H <= 256 ) ? 256 :
//               ( H <= 512 ) ? 512 :
//               ( H <= 1024 ) ? 1024 :
//               ( H <= 2048 ) ? 2048 :
//               ( H <= 4096 ) ? 4096 :
//               ( H <= 8192 ) ? 8192 : 
//               ( H <= 16384 ) ? 16384 : 
//               ( H <= 32768 ) ? 32768 : 65536;  

//ports       
output [W-1:0]         dout;          //data out 
output                 wfull;         //wfull
output                 rempty;        //rempty
output                 awfull;        //almost full flag
output                 arempty;       //almost empty flag
output                 overflow;      //write when full
output                 underflow;     //read when empty

input                  rclk;          //read clk
input                  wclk;          //write clk
input                  rrst_b;        //read reset signal
input                  wrst_b;        //write reset signal
input [W-1:0]          din;           //data into fifo 
input                  re;            //read enable signal
input                  we;            //write enable signal           
input                  wclr;          //write clr signal
input                  rclr;          //read clr signal

//------------------------------------------------------------------------
//internal signals                       
wire                   re_ram;        //
wire                   we_ram;        //
wire  [L-1:0]          waddr;         //
wire  [L-1:0]          raddr;         //
wire  [W-1:0]          dout;          //
//------------------------------------------------------------------------

//instantiate wl_sdpram module


//instantiate wl_afifo module
wl_afifo#(H,TA,TB) wl_afifo
        (
        .wfull                  ( wfull        ),
        .rempty                 ( rempty       ),
        .awfull                 ( awfull       ),
        .arempty                ( arempty      ),
        .overflow               ( overflow     ),
        .underflow              ( underflow    ),
        .we_ram                 ( we_ram       ),
        .waddr                  ( waddr        ),
        .re_ram                 ( re_ram       ),
        .raddr                  ( raddr        ),
        .rclk                   ( rclk         ),
        .wclk                   ( wclk         ),
        .rrst_b                 ( rrst_b       ),
        .wrst_b                 ( wrst_b       ),
        .re                     ( re           ),
        .we                     ( we           ),
        .wclr                   ( wclr         ),
        .rclr                   ( rclr         )
        );   
         
endmodule                                                    
