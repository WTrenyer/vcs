`timescale 1ns/1ps

module K_encoder(
                    input  clk,
		            input  rst_n,
	                input [7:0] K_data_in,	    
	                input  K,
	                input  K_r,
		            input  RD,
					
					
	                output reg [9:0] K_data_out, 
                    output reg       K_RD_out	  
     );
	 
	 
	 reg [9:0] K_temp;
	 reg       K_RD;
	 
	 
	 always @(posedge clk or negedge rst_n)
	 begin
	   if(!rst_n) begin
		    K_temp <= 10'd0;
		    K_RD <= 1'b0;
            end
	   else if (!K) begin
		    K_temp <= 10'd0;
		    K_RD <= 1'b0;
            end
       else begin   
	     case(K_data_in)
		 8'b000_11100 : begin
		                K_temp <= 10'b001111_0100;
				        K_RD   <= 1'b0;
				        end
		 8'b011_11100 : begin
		                K_temp <= 10'b001111_0011;
				        K_RD   <= 1'b1;
				        end
		 8'b100_11100 : begin
		                K_temp <= 10'b001111_0010;
				        K_RD   <= 1'b0;
				        end
	     8'b101_11100	: begin
		                K_temp <= 10'b001111_1010;
				        K_RD   <= 1'b1;
				        end		 
		 8'b111_11100 : begin
		                K_temp <= 10'b001111_1000;
				        K_RD   <= 1'b0;
				        end 
         default      : begin
		                K_temp <= 10'd0;
				        K_RD   <= 1'b0;
				        end				 
		 endcase
       end
     end
     
     always @(posedge clk or negedge rst_n)
     begin
       if(!rst_n)begin
           K_data_out <= 10'd0;
           K_RD_out <= 1'b0;
           end
       else if(!K_r)begin
           K_data_out <= 10'd0;
           K_RD_out <= 1'b0;
           end       
       else begin	   
         case({RD,K_RD})	
         2'b00 : begin
               K_data_out    <= K_temp;
               K_RD_out <= 1'b0;
               end
         2'b01 : begin
               K_data_out    <= K_temp;	
               K_RD_out <= 1'b1;
               end
         2'b10 : begin
               K_data_out    <= ~K_temp;
               K_RD_out <= 1'b1;
               end
         2'b11 : begin
               K_data_out    <= ~K_temp;
               K_RD_out <= 1'b0;
               end	   
	     endcase
	   end
     end	 

endmodule
