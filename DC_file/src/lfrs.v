`timescale 1ns/1ps
module lfrs ( 
               input  clk       ,
               input  rst_n     ,
               output [3:0] lfrs_out  
                );


reg [4:0]  lfrs_a    ;
wire[4:0]  lfrs_b    ;


assign   lfrs_out    = lfrs_a[4:1]                       ;
assign   lfrs_b[3:2] = lfrs_a[4:3]^lfrs_a[1:0]             ;
assign   lfrs_b[1:0] = lfrs_a[2:1]^lfrs_a[4:3]^lfrs_a[1:0] ;
assign   lfrs_b[4]   = lfrs_a[0]                          ;

always  @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        lfrs_a<= 5'h1f           ;
    end 
    else begin
        lfrs_a[4:0]<=lfrs_b[4:0] ;
    end
end

endmodule
