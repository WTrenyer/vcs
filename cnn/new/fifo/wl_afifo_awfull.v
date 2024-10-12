
module wl_afifo_awfull
        (
         awfull             ,
         wclk               ,
         wrst_b             ,
         bin_wptr           ,
         w2_gray_rptr       ,        
         wclr
         );

//parameters
parameter  L=3;                          //
parameter  TA=6;                         //

//ports
output                  awfull;          // almost full flag

input                   wclk;            // write clk
input                   wrst_b;          // write reset signal,async
input [L:0]             bin_wptr;        // binary wptr
input [L:0]             w2_gray_rptr;    // gray wptr, synchrized from wclk domain 
input                   wclr;            // write xlr signal , sync

reg                     awfull;          // almost full flag

//------------------------------------------------------------------------
//internal signals
wire                    awfull_val;      //
wire [L:0]               diff;           //
wire[L:0]               w2_bin_rptr;     //
//------------------------------------------------------------------------

//convert gray to binary   
assign  w2_bin_rptr=w2_gray_rptr^ {1'b0, w2_bin_rptr[L:1]};  
assign  diff = bin_wptr-w2_bin_rptr;
   
assign  awfull_val=( diff >= (TA) ) ? 1'b1 : 1'b0;

//Registered almost Full &half full Flags  
always @(posedge wclk or negedge wrst_b)  
    if(!wrst_b)
        awfull <= 1'b0;
    else
        if( wclr ) 
           awfull <= 1'b0;
        else    
           awfull <= awfull_val; 
        
endmodule                  
   

