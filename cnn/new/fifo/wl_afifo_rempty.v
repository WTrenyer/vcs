
module wl_afifo_rempty
        (
         rempty          ,
         underflow       ,
         rclk            ,
         rrst_b          ,
         bin_rptr        ,
         g_rptr          ,
         r2_gray_wptr    ,
         re              ,
         rclr   
         );

//parameters
parameter  L=3;                       //addr width

//ports
output               rempty;          // rempty
output               underflow;       // read when empty
output [L:0]         bin_rptr;        // binary rptr
output [L:0]         g_rptr;          // gray rptr,rclk domain

input                rclk;            // read clk
input                rrst_b;          //read reset signal,async
input [L:0]          r2_gray_wptr;    // gray wptr, synchrized from wclk domain 
input                re;              // read enable
input                rclr;            //read clr signal,sync

reg                  rempty;          // 
reg                  underflow;       //
reg [L:0]            bin_rptr;        //
reg [L:0]            g_rptr;          //

//------------------------------------------------------------------------
//internal signals
wire [L:0]          gnext_rptr;       //
wire [L:0]          bin_next_rptr;    //
//------------------------------------------------------------------------

// Read Pointers Logic         
always@(posedge rclk or negedge rrst_b)
    begin
        if(!rrst_b)
            bin_rptr<= {L+1{1'b0}};
        else
            if( rclr )
                bin_rptr<= {L+1{1'b0}};
            else    
                if(re)
                    bin_rptr<=bin_next_rptr[L:0];  
                else 
                    bin_rptr<=bin_rptr;          
    end 

//
always@(posedge rclk or negedge rrst_b)
   begin
       if(!rrst_b)
            g_rptr<={L+1{1'b0}};
       else
            if( rclr )
                g_rptr<= {L+1{1'b0}};
            else    
                if( re )
                    g_rptr<=gnext_rptr;
                else
                    g_rptr<=g_rptr;       
   end
   
// binary code to gray code  
assign  bin_next_rptr= bin_rptr + (!rempty);
assign  gnext_rptr = bin_next_rptr^{1'b0,bin_next_rptr[L:1]};   
 
// Registered  Empty Flags
always@(posedge rclk or negedge rrst_b)
    if(!rrst_b)
        rempty<=1'b1;
    else
        if( rclr )
                rempty<= 1'b1;
            else    
                rempty<=(g_rptr==r2_gray_wptr)|(re&(gnext_rptr==r2_gray_wptr)); 

// Registered  underflow Flags
always@(posedge rclk or negedge rrst_b)
    if(!rrst_b)
        underflow <= 1'b0;
    else
        if( rclr )
                underflow <= 1'b0;
            else    
                if(re & rempty )
                    underflow <= 1'b1;
                else
                    underflow <= 1'b0;     
        
endmodule             