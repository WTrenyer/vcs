
module wl_afifo_ram
        (
         we_ram      ,
         re_ram      ,
         waddr       ,
         raddr       ,
         we          ,
         re          ,
         bin_wptr    ,
         bin_rptr
         );

parameter L=3;                     //

output           we_ram;           // ram control signal,write enable
output           re_ram;           // ram control signal,read enable
output [L-1:0]   waddr;            // ram control signal,write addr
output [L-1:0]   raddr;            // ram control signal,read addr

input            we;               // write enable,from fifo
input            re;               // read enable,from fifo
input [L:0]      bin_wptr;         // binary wptr  
input [L:0]      bin_rptr;         // binary rptr 

assign  we_ram = we ;
assign  re_ram = re ;

assign  waddr=bin_wptr[L-1:0];
assign  raddr=bin_rptr[L-1:0];  

endmodule      