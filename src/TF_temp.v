`timescale 1ns/1ps

module TF_temp(
    input             clk,
    input             rst_n,
    input             K,
    input       [2:0] D_data3b,
    output  reg [2:0] D_data_in3b,
    output  reg [3:0] D_temp4b,
    output  reg       RD_4b
	  );
	  
	  always @(posedge clk or negedge rst_n)
	  begin
	  if(!rst_n)begin
	        D_data_in3b <= 3'd0;
	        D_temp4b    <= 4'd0;
	        RD_4b       <= 1'b0;
	        end
      else if (K)begin
	  
            D_data_in3b <= 3'd0;
	        D_temp4b    <= 4'd0;
	        RD_4b       <= 1'b0;
            end
	  else begin
	        D_data_in3b <= D_data3b; 
	  case(D_data3b)
		3'b000 : begin
		            D_temp4b <= 4'b1011;
				    RD_4b    <= 1'b1;
				 end
		3'b001 : begin
		            D_temp4b <= 4'b1001;
				    RD_4b    <= 1'b0;
				 end
        3'b010 : begin
		            D_temp4b <= 4'b0101;
				    RD_4b    <= 1'b0;
				 end
        3'b011 : begin
		            D_temp4b <= 4'b1100;
				    RD_4b    <= 1'b0;
				 end
        3'b100 : begin
		            D_temp4b <= 4'b1101;
				    RD_4b    <= 1'b1;
				 end
        3'b101 : begin
		            D_temp4b <= 4'b1010;
				    RD_4b    <= 1'b0;
	  			 end
        3'b110 : begin
		            D_temp4b <= 4'b0110;
				    RD_4b    <= 1'b0;
                 end
	    3'b111 : begin
		            D_temp4b <= 4'b1110;
				    RD_4b     <= 1'b1;
				 end	
        endcase
      end
    end

    endmodule
