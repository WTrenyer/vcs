
module wl_afifo_synw2r
        (
         r2_gray_wptr,
         rclk,
         rrst_b,
         g_wptr,
         rclr
        );

//parameters
parameter L=3;                       //addr width

//ports
output [L:0]     r2_gray_wptr;       // second gray wptr, synchrized from wclk domain 

input            rclk;               // rclk
input            rrst_b;             // rrst_b
input  [L:0]     g_wptr;             // gray wptr,wclk domain
input            rclr;               // rclr

reg [L:0]        r2_gray_wptr;       // second gray wptr, synchrized from wclk domain  
 
//------------------------------------------------------------------------
//internal signals
reg [L:0]        r_gray_wptr;       // first gray wptr, synchrized from wclk domain 
//------------------------------------------------------------------------

// Synchronization Logic  
always@(posedge rclk or negedge rrst_b)
        if(!rrst_b)
            {r_gray_wptr,r2_gray_wptr}<=0;
        else
            if(rclr) 
                {r_gray_wptr,r2_gray_wptr}<=0;
            else         
                begin
                    r_gray_wptr<=g_wptr;
                    r2_gray_wptr<=r_gray_wptr;
               end       
endmodule