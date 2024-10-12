
module wl_afifo_arempty
        (
         arempty            ,
         rclk               ,
         rrst_b             ,
         bin_rptr           ,
         r2_gray_wptr       ,
         rclr
         );

//parameters
parameter  L=3;                          //
parameter  TB=2;                         //

//ports
output                  arempty;        // almost empty flag

input                   rclk;           // read clk
input                   rrst_b;         // read reset signal
input [L:0]             bin_rptr;       // binary rptr 
input [L:0]             r2_gray_wptr;   // gray wptr, synchrized from wclk domain 
input                   rclr;           // read clr signal

reg                     arempty;        // almost empty flag

//------------------------------------------------------------------------
//internal signals
wire                    arempty_val;    //
wire [L:0]              diff1;          //
wire[L:0]               r2_bin_wptr;    //
//------------------------------------------------------------------------

//convert gray to binary   
assign  r2_bin_wptr=r2_gray_wptr^ {1'b0, r2_bin_wptr[L:1]};  
assign  diff1 = r2_bin_wptr - bin_rptr;

assign  arempty_val=(diff1<= TB )? 1'b1 : 1'b0;

//Registered arempty Flags  
always @(posedge rclk or negedge rrst_b)  
    if(!rrst_b)
        arempty <= 1'b1;
    else 
        if(rclr)
           arempty <= 1'b1;
        else  
           arempty <= arempty_val; 
          
endmodule                  
   
