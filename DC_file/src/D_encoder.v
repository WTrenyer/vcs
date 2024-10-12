`timescale 1ns / 1ps

module D_encoder( 
           input             clk,
           input             rst_n,
	       input       [7:0] D_data_in,
	       input             K,
	       input             K_r,
	       input             RD,
		   
	       output reg  [9:0] D_data_out, 
           output reg        D_RD_out	
	   );
	   
	   wire [4:0] D_data_in5b;
	   wire [2:0] D_data_in3b;
	   wire [5:0] D_temp6b;
	   wire [3:0] D_temp4b;
	   wire       RD_6b, RD_4b;
    
	   always @( posedge clk or negedge rst_n)
	   begin
       if(!rst_n)
		    D_data_out[9:4] <= 6'd0;
	   else if(K_r)
		    D_data_out[9:4] <= 6'd0;
	   else begin
	        case({RD, RD_6b})
	   
		      2'b00 : D_data_out[9:4] <= D_temp6b;   
		      2'b01 : D_data_out[9:4] <= D_temp6b;	      
		      2'b10 : begin
		              if(D_data_in5b == 5'b00111)
				          D_data_out[9:4] <= ~D_temp6b;
				      else 
				          D_data_out[9:4] <= D_temp6b;
				      end
		      2'b11 : D_data_out[9:4] <= ~D_temp6b;   
			  
	        endcase
           end
       end
      
        
       always @( posedge clk or negedge rst_n)
       begin
       if(!rst_n)
		    D_data_out[3:0] <= 4'd0;
	   else if(K_r)
		    D_data_out[3:0] <= 4'd0;
	   else begin
	      case({RD, RD_6b, RD_4b})
	   
		  3'b000 :        D_data_out[3:0] <= D_temp4b;
		  3'b001 : begin
				   if((D_data_in3b == 3'b111) && (D_temp6b[1:0] == 2'b11))
				          D_data_out[3:0] <= 4'b0111;
				   else 
				          D_data_out[3:0] <= D_temp4b;
		           end
		  3'b010 : begin
				   if(D_data_in3b == 3'b011)
				          D_data_out[3:0] <= ~D_temp4b;
				   else 
				          D_data_out[3:0] <= D_temp4b;
		           end
		  3'b011 :        D_data_out[3:0] <= ~D_temp4b;
		  3'b100 : begin
				   if(D_data_in3b == 3'b011)
				          D_data_out[3:0] <= ~D_temp4b;
				   else 
				          D_data_out[3:0] <= D_temp4b;
		           end
		  3'b101 : begin
                   if((D_data_in3b == 3'b111) && (D_temp6b[1:0] == 2'b00) && (D_data_in5b != 5'b00111))
                          D_data_out[3:0] <= 4'b1000;
                   else 
                          D_data_out[3:0] <= ~D_temp4b;
                   end
		  3'b110 :        D_data_out[3:0] <= D_temp4b;
		  3'b111 :        D_data_out[3:0] <= D_temp4b;  
	      endcase
         end
       end
      
       
     always @( posedge clk or negedge rst_n)
     begin
     if(!rst_n)
		    D_RD_out <= 1'b0;
	 else if (K_r)
	            D_RD_out <= 1'b0;
	 else begin
		  case({RD,RD_6b,RD_4b})
		  3'b000 : D_RD_out <= 1'b0;        
		  3'b001 : D_RD_out <= 1'b1;      
		  3'b010 : D_RD_out <= 1'b1;       
		  3'b011 : D_RD_out <= 1'b0;
		  3'b100 : D_RD_out <= 1'b1;
		  3'b101 : D_RD_out <= 1'b0;
		  3'b110 : D_RD_out <= 1'b0;
		  3'b111 : D_RD_out <= 1'b1;
		endcase
      end
     end
        
		TF_temp m3(
		             .clk(clk),
		             .rst_n(rst_n),
		             .K(K),
		             .D_data3b(D_data_in[7:5]),
		             .D_data_in3b(D_data_in3b),
			         .D_temp4b(D_temp4b),
			         .RD_4b(RD_4b)
					 );
					 
		FS_temp m4(
		             .clk(clk),
		             .rst_n(rst_n),
		             .K(K),
		             .D_data5b(D_data_in[4:0]),
		             .D_data_in5b(D_data_in5b),    
			         .D_temp6b(D_temp6b),
			         .RD_6b(RD_6b)
					 );
 endmodule	
