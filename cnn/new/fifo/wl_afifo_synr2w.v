

module wl_afifo_synr2w
        (
         w2_gray_rptr    ,
         wclk            ,
         wrst_b          ,
         g_rptr          ,
         wclr
         );

//parameters
parameter L=3;                      //addr width

//ports
output [L:0]     w2_gray_rptr;     // gray rptr, synchrized from rclk domain 

input            wclk;             // wclk
input            wrst_b;           // wrst_b
input [L:0]      g_rptr;           // gray rptr,rclk domain
input            wclr;             // wclr

reg [L:0]        w2_gray_rptr;     // gray wptr, synchrized from wclk domain 

//------------------------------------------------------------------------
//internal signals
reg [L:0]        w_gray_rptr;      //
//------------------------------------------------------------------------

//
always@(posedge wclk or negedge wrst_b)
   begin
       if(!wrst_b)
           {w_gray_rptr,w2_gray_rptr}<=0;
       else
           if(wclr)
               {w_gray_rptr,w2_gray_rptr}<=0;
           else    
               begin    
                   w_gray_rptr<=g_rptr;
                   w2_gray_rptr<=w_gray_rptr;
               end    
   end
endmodule  
