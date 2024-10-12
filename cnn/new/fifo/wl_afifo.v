
module wl_afifo
        ( 
         wfull               , 
         rempty              ,
         awfull              ,
         arempty             ,
         overflow            ,
         underflow           ,
         we_ram              ,
         waddr               ,
         re_ram              ,
         raddr               ,
         rclk                ,
         wclk                ,
         rrst_b              ,
         wrst_b              ,
         re                  ,
         we                  ,
         wclr                ,
         rclr        
         );

//parameters                    
parameter  H =8;                     //
parameter  TA=6;                     //
parameter  TB=2;                     //
parameter  L= ( H <= 2 ) ? 1 :       //
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
  
// ports   
output          wfull;          //wfull
output          rempty;         //rempty
output          awfull;         //almost full flag
output          arempty;        //almost empty flag
output          overflow;       //write when full
output          underflow;      //read when empty
output          we_ram;         // ram control signal,read enable
output[L-1:0]   waddr;          // ram control signal,write addr
output          re_ram;         // ram control signal,write enable
output[L-1:0]   raddr;          // ram control signal,read addr
  
input           rclk;           //read clk
input           wclk;           //write clk
input           rrst_b;         //read reset signal
input           wrst_b;         //write reset signal
input           re;             //read enable
input           we;             //write enable
input           wclr;           //write clr signal
input           rclr;           //read clr signal

//------------------------------------------------------------------------
//internal signals     
wire [L:0]     bin_wptr;        //
wire [L:0]     bin_rptr;        //
wire           re_ram;          //
wire           we_ram;          //
wire [L-1:0]   waddr;           //
wire [L-1:0]   raddr;           //
wire [L:0]     g_rptr;          //
wire [L:0]     g_wptr;          //
wire [L:0]     r2_gray_wptr;    //
wire [L:0]     w2_gray_rptr;    //
wire           wfull;           //
wire           rempty;          //
//------------------------------------------------------------------------

//afifo_rempty
wl_afifo_rempty#(L) wl_afifo_rempty
        (
         .rempty       ( rempty          ),
         .underflow    ( underflow       ),
         .rclk         ( rclk            ),
         .rrst_b       ( rrst_b          ),
         .bin_rptr     ( bin_rptr        ),
         .g_rptr       ( g_rptr          ),
         .r2_gray_wptr ( r2_gray_wptr    ),
         .re           ( re              ),
         .rclr         ( rclr            )
         );

//afifo_full
wl_afifo_wfull#(L,H) wl_afifo_wfull
        (
         .wfull        ( wfull           ),
         .overflow     ( overflow        ),
         .wclk         ( wclk            ),
         .wrst_b       ( wrst_b          ),
         .bin_wptr     ( bin_wptr        ),
         .g_wptr       ( g_wptr          ),
         .w2_gray_rptr ( w2_gray_rptr    ),
         .we           ( we              ),
         .wclr         ( wclr            )
         );

//afifo_awfull 
wl_afifo_awfull#(L,TA) wl_afifo_awfull 
         (
          .awfull           ( awfull          ),
          .wclk             ( wclk            ),
          .wrst_b           ( wrst_b          ),
          .bin_wptr         ( bin_wptr        ),
          .w2_gray_rptr     ( w2_gray_rptr    ),
          .wclr             ( wclr            )
          );          
         
//wl_afifo_arempty
wl_afifo_arempty#(L,TB) wl_afifo_arempty 
         (
          .arempty          ( arempty         ),
          .rclk             ( rclk            ),
          .rrst_b           ( rrst_b          ),
          .bin_rptr         ( bin_rptr        ),
          .r2_gray_wptr     ( r2_gray_wptr    ),
          .rclr             ( rclr            )
          ); 
                    
//wl_afifo_synr2w
wl_afifo_synr2w #(L) wl_afifo_synr2w
        (
         .w2_gray_rptr     ( w2_gray_rptr    ),
         .wclk             ( wclk            ),
         .wrst_b           ( wrst_b          ),
         .g_rptr           ( g_rptr          ),
         .wclr             ( wclr            )   
         ); 
        
//wl_afifo_synw2r
wl_afifo_synw2r #(L) wl_afifo_synw2r
        (
         .r2_gray_wptr     ( r2_gray_wptr    ),
         .rclk             ( rclk            ),
         .rrst_b           ( rrst_b          ),
         .g_wptr           ( g_wptr          ),
         .rclr             ( rclr            )    
         );   
//wl_afifo_ram
wl_afifo_ram #(L) wl_afifo_ram
        (
         .we_ram           ( we_ram      ),
         .re_ram           ( re_ram      ),
         .waddr            ( waddr       ),
         .raddr            ( raddr       ),
         .we               ( we          ),
         .re               ( re          ),
         .bin_wptr         ( bin_wptr    ),
         .bin_rptr         ( bin_rptr    )
         );

endmodule                            