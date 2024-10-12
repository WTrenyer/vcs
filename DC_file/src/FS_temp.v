`timescale 1ns/1ps

module FS_temp(
                input   clk,
                input   rst_n,
                input   K,
                input [4:0] D_data5b,
				
				
                output reg [4:0] D_data_in5b,
	            output reg [5:0] D_temp6b,
	            output reg       RD_6b
	  );

      always @(posedge clk or negedge rst_n)
      begin 
	  if (!rst_n) begin
            D_data_in5b <= 5'd0;
            D_temp6b <= 6'd0;
            RD_6b <= 1'b0;
            end
      else if (K) begin
            D_data_in5b <= 5'd0;
            D_temp6b <= 6'd0;
            RD_6b <= 1'd0;
            end
      else begin
	        D_data_in5b <= D_data5b;
		   case(D_data5b)
		   5'b00000:begin
		           D_temp6b <= 6'b100111;
		           RD_6b    <= 1'b1;
		           end
		   5'b00001:begin
		           D_temp6b <= 6'b011101;
		           RD_6b    <= 1'b1;
		           end
		   5'b00010:begin
		           D_temp6b <= 6'b101101;
		           RD_6b    <= 1'b1;
		           end
		   5'b00011:begin
		           D_temp6b <= 6'b110001;
		           RD_6b    <= 1'b0;
		           end 
		   5'b00100:begin
		           D_temp6b <= 6'b110101;
		           RD_6b    <= 1'b1;
		           end
		   5'b00101:begin
		           D_temp6b <= 6'b101001;
		           RD_6b    <= 1'b0;
		           end
		   5'b00110:begin
		           D_temp6b <= 6'b011001;
		           RD_6b    <= 1'b0;
		           end
		   5'b00111:begin
		           D_temp6b <= 6'b111000;
		           RD_6b    <= 1'b0;
		           end
		   5'b01000:begin
		           D_temp6b <= 6'b111001;
		           RD_6b    <= 1'b1;
		           end
		   5'b01001:begin
		           D_temp6b <= 6'b100101;
		           RD_6b    <= 1'b0;
		           end
		   5'b01010:begin
		           D_temp6b <= 6'b010101;
		           RD_6b    <= 1'b0;
		           end
		   5'b01011:begin
		           D_temp6b <= 6'b110100;
		           RD_6b    <= 1'b0;
		           end 
		   5'b01100:begin
		           D_temp6b <= 6'b001101;
		           RD_6b    <= 1'b0;
		           end
		   5'b01101:begin
		           D_temp6b <= 6'b101100;
		           RD_6b    <= 1'b0;
		           end
		   5'b01110:begin
		           D_temp6b <= 6'b011100;
		           RD_6b    <= 1'b0;
		           end
		   5'b01111:begin
		           D_temp6b <= 6'b010111;
		           RD_6b    <= 1'b1;
		           end
		   5'b10000:begin
		           D_temp6b <= 6'b011011;
		           RD_6b    <= 1'b1;
		           end
		   5'b10001:begin
		           D_temp6b <= 6'b100011;
		           RD_6b    <= 1'b0;
		           end
		   5'b10010:begin
		           D_temp6b <= 6'b010011;
		           RD_6b    <= 1'b0;
		           end
		   5'b10011:begin
		           D_temp6b <= 6'b110010;
		           RD_6b    <= 1'b0;
		           end 
		   5'b10100:begin
		           D_temp6b <= 6'b001011;
		           RD_6b    <= 1'b0;
		           end
		   5'b10101:begin
		           D_temp6b <= 6'b101010;
		           RD_6b    <= 1'b0;
		           end
		   5'b10110:begin
		           D_temp6b <= 6'b011010;
		           RD_6b    <= 1'b0;
		           end
		   5'b10111:begin
		           D_temp6b <= 6'b111010;
		           RD_6b    <= 1'b1;
		           end
		   5'b11000:begin
		           D_temp6b <= 6'b110011;
		           RD_6b    <= 1'b1;
		           end
		   5'b11001:begin
		           D_temp6b <= 6'b100110;
		           RD_6b    <= 1'b0;
		           end
		   5'b11010:begin
		           D_temp6b <= 6'b010110;
		           RD_6b    <= 1'b0;
		           end
		   5'b11011:begin
		           D_temp6b <= 6'b110110;
		           RD_6b    <= 1'b1;
		           end 
		   5'b11100:begin
		           D_temp6b <= 6'b001110;
		           RD_6b    <= 1'b0;
		           end
		   5'b11101:begin
		           D_temp6b <= 6'b101110;
		           RD_6b    <= 1'b1;
		           end
		   5'b11110:begin
		           D_temp6b <= 6'b011110;
		           RD_6b    <= 1'b1;
		           end
		   5'b11111:begin
		           D_temp6b <= 6'b101011;
		           RD_6b    <= 1'b1;
		           end  
		   endcase
		 end
	  end
		
endmodule
