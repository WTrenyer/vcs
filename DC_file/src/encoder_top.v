`timescale 1ns / 1ps
module encoder_top(
           input       clk,
	       input       rst_n,
	       input [7:0] encoder_in,
	       input       K,
		   
		   
	       output reg [9:0] encoder_out, 
           output reg       RD_out
	  );
	  
    wire [9:0] K_data_out, D_data_out;
    wire       K_RD_out, D_RD_out,RD;
   	reg        K_r, K_rr;
   	
   	assign RD = K_rr ? K_RD_out : D_RD_out;
   	
   	always @(posedge clk or negedge rst_n)
   	begin
   	  if(!rst_n) begin
   	      K_r   <= 1'b0;
   	      K_rr  <= 1'b0; 	      
 	      end
 	  else begin
 	      K_r   <= K;
 	      K_rr  <= K_r;	      
 	      end
 	end
 	  
    always @(posedge clk or negedge rst_n)
    begin
	  if(!rst_n) begin
	      encoder_out <= 10'b0;
		  RD_out      <= 1'b0;
          end
      else begin
	  if(K_rr) begin
          encoder_out <= K_data_out;
          RD_out      <= K_RD_out;
          end
      else begin
		  encoder_out <= D_data_out;
		  RD_out      <= D_RD_out;
		  end
	  end
	end

	
	K_encoder m1(.clk(clk),
	             .rst_n(rst_n),
	             .K_data_in(encoder_in),
				 .K(K),
				 .K_r(K_r),
				 .RD(RD),
				 .K_data_out(K_data_out),
				 .K_RD_out(K_RD_out)
				 );
				 
	D_encoder m2( .clk(clk),
                  .rst_n(rst_n),
	              .D_data_in(encoder_in),
		 		  .K(K),
				  .K_r(K_r),
				  .RD(RD),
				  .D_data_out(D_data_out),
				  .D_RD_out(D_RD_out)
				 );
				 
endmodule
