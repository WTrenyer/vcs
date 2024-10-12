
module wl_afifo_wfull
        (
         wfull        ,
         overflow     ,
         wclk         ,
         wrst_b       ,
         bin_wptr     ,
         g_wptr       ,
         w2_gray_rptr ,
         we           ,
         wclr       
         );

//parameters
parameter  L=3;                        //addr widths
parameter  H=8;                        //

//ports
output               wfull;            // wfull
output               overflow;         // write when full
output [L:0]         bin_wptr;         // binary wptr
output [L:0]         g_wptr;           // gray wptr

input                wclk;             // wclk
input                wrst_b;           //wrst_b
input [L:0]          w2_gray_rptr;     // gray rptr, synchrized from rclk domain 
input                we;               // write enable 
input                wclr;             //wclr

reg                  wfull;            // wfull
reg                  overflow;         // write when full
reg [L:0]            bin_wptr;         // binary wptr
reg [L:0]            g_wptr;           // gray wptr

//------------------------------------------------------------------------
//internal signals
wire [L:0]           gnext_wptr;       //
wire [L:0]           bin_next_wptr;    //
wire [L:0]           diff;             //
wire [L:0]           w2_bin_rptr;      //
wire                 wfull_val;        //
//------------------------------------------------------------------------

//
always@(posedge wclk or negedge wrst_b)
   begin
       if(!wrst_b)
            bin_wptr<= {L+1{1'b0}};
       else
           if(wclr)
               bin_wptr<= {L+1{1'b0}};
            else
               if(we)
                   bin_wptr<=bin_next_wptr[L:0];
               else
                   bin_wptr<=bin_wptr;  
   end 
   
 //
 always@(posedge wclk or negedge wrst_b)
   begin
       if(!wrst_b)
            g_wptr<={L+1{1'b0}};
       else
            if(wclr)
                g_wptr<={L+1{1'b0}};
             else       
                if(we )
                    g_wptr<=gnext_wptr;
                else
                    g_wptr<=g_wptr;     
   end 
   
//binary code to gray code 
assign  bin_next_wptr= bin_wptr + (!wfull);
assign  gnext_wptr = bin_next_wptr^{1'b0,bin_next_wptr[L:1]}; 

//convert gray to binary   
assign  w2_bin_rptr=w2_gray_rptr^ {1'b0, w2_bin_rptr[L:1]};  
assign  diff = bin_wptr-w2_bin_rptr;
            	              	  
assign  wfull_val=(diff>=(H) |( (diff == H-1)& we) ) ? 1'b1 : 1'b0;
  
//Registered almost Full &half full Flags  
always @(posedge wclk or negedge wrst_b)  
    if(!wrst_b)
     	  wfull <= 1'b0;
    else
    	  if( wclr ) 
    	     wfull <= 1'b0;
    	  else   	
     	     wfull <= wfull_val; 
     	     
// Registered  overflow Flags
always@(posedge wclk or negedge wrst_b)
    if(!wrst_b)
        overflow <= 1'b0;
    else
        if(wclr)
            overflow <= 1'b0;
        else        
            if( we & wfull )
                overflow <= 1'b1;
            else
                overflow <= 1'b0;        
endmodule    