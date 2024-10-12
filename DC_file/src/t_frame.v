`timescale 1ns/1ps
module t_frame ( clk           ,
                 rst_n         ,
                 adc_data      ,
                 lfrs          ,
                 lane0         ,
                 lane1         ,
                 lane2         ,
                 lane3         ,
                 lane4         ,
                 lane5         ,
                 lane6         ,
                 lane7         
                 ); 

				 
				 
 input                clk           ;
 input                rst_n         ;
 input      [47:0]    adc_data      ;
 input      [3:0]     lfrs          ; 
 output   reg[7:0]    lane0         ;
 output   reg[7:0]    lane1         ;
 output   reg[7:0]    lane2         ;
 output   reg[7:0]    lane3         ;
 output   reg[7:0]    lane4         ;
 output   reg[7:0]    lane5         ;
 output   reg[7:0]    lane6         ;
 output   reg[7:0]    lane7         ;


   reg      [63:0]   data_buffer1  ;
   reg      [63:0]   data_buffer2  ;
   reg      [63:0]   data_buffer3  ;
   reg      [63:0]   data_buffer4  ;
   reg      [63:0]   data_buffer5  ;
   reg      [63:0]   data_buffer6  ;
   reg      [63:0]   data_buffer7  ;
   reg      [63:0]   data_buffer8  ;

   reg               full1         ;
   reg               full2         ;
   reg               full3         ;
   reg               full4         ;
   reg               full5         ;
   reg               full6         ;
   reg               full7         ;
   reg               full8         ;
   wire      [7:0]   rw_control    ;


   assign rw_control={full1,full2,full3,full4,full5,full6,full7,full8} ;


   always  @(posedge clk or negedge rst_n )begin
       if(!rst_n )begin
           data_buffer1<=64'd0 ;
       end
       else if(rw_control==8'b00000000||rw_control==8'b00001111)begin
           data_buffer1<={adc_data[47:40],adc_data[39:36],lfrs[3:0],adc_data[35:28],adc_data[27:24],lfrs[3:0],adc_data[23:16],adc_data[15:12],lfrs[3:0],adc_data[11:4],adc_data[3:0],lfrs[3:0]};
       end
   end

  always  @(posedge clk or negedge rst_n)begin
       if(!rst_n)begin
           data_buffer2<=64'd0 ;
       end
       else if(rw_control==8'b10000000)begin
           data_buffer2<={adc_data[47:40],adc_data[39:36],lfrs[3:0],adc_data[35:28],adc_data[27:24],lfrs[3:0],adc_data[23:16],adc_data[15:12],lfrs[3:0],adc_data[11:4],adc_data[3:0],lfrs[3:0]};
       end
   end

  always  @(posedge clk or negedge rst_n)begin
       if(!rst_n)begin
           data_buffer3<=64'd0 ;
       end
       else if(rw_control==8'b11000000)begin
           data_buffer3<={adc_data[47:40],adc_data[39:36],lfrs[3:0],adc_data[35:28],adc_data[27:24],lfrs[3:0],adc_data[23:16],adc_data[15:12],lfrs[3:0],adc_data[11:4],adc_data[3:0],lfrs[3:0]};
       end
   end  

  always  @(posedge clk or negedge rst_n)begin
       if(!rst_n)begin
           data_buffer4<=64'd0 ;
       end
       else if(rw_control==8'b11100000)begin
           data_buffer4<={adc_data[47:40],adc_data[39:36],lfrs[3:0],adc_data[35:28],adc_data[27:24],lfrs[3:0],adc_data[23:16],adc_data[15:12],lfrs[3:0],adc_data[11:4],adc_data[3:0],lfrs[3:0]};
       end
   end  

  always  @(posedge clk or negedge rst_n)begin
       if(!rst_n)begin
           data_buffer5<=64'd0 ;
       end
       else if(rw_control==8'b11110000)begin
           data_buffer5<={adc_data[47:40],adc_data[39:36],lfrs[3:0],adc_data[35:28],adc_data[27:24],lfrs[3:0],adc_data[23:16],adc_data[15:12],lfrs[3:0],adc_data[11:4],adc_data[3:0],lfrs[3:0]};
       end
   end

  always  @(posedge clk or negedge rst_n)begin
       if(!rst_n)begin
           data_buffer6<=64'd0 ;
       end
       else if(rw_control==8'b00001000)begin
           data_buffer6<={adc_data[47:40],adc_data[39:36],lfrs[3:0],adc_data[35:28],adc_data[27:24],lfrs[3:0],adc_data[23:16],adc_data[15:12],lfrs[3:0],adc_data[11:4],adc_data[3:0],lfrs[3:0]};
       end
   end

  always  @(posedge clk or negedge rst_n)begin
       if(!rst_n)begin
           data_buffer7<=64'd0 ;
       end
       else if(rw_control==8'b00001100)begin
           data_buffer7<={adc_data[47:40],adc_data[39:36],lfrs[3:0],adc_data[35:28],adc_data[27:24],lfrs[3:0],adc_data[23:16],adc_data[15:12],lfrs[3:0],adc_data[11:4],adc_data[3:0],lfrs[3:0]};
       end
   end

  always  @(posedge clk or negedge rst_n)begin
       if(!rst_n)begin
           data_buffer8<=64'd0 ;
       end
       else if(rw_control==8'b00001110)begin
           data_buffer8<={adc_data[47:40],adc_data[39:36],lfrs[3:0],adc_data[35:28],adc_data[27:24],lfrs[3:0],adc_data[23:16],adc_data[15:12],lfrs[3:0],adc_data[11:4],adc_data[3:0],lfrs[3:0]};
       end
   end   

   
   always  @(posedge clk or negedge rst_n)begin  
   if(!rst_n)begin
            lane0<=8'd0 ;
            lane1<=8'd0 ;
            lane2<=8'd0 ;
            lane3<=8'd0 ;
            lane4<=8'd0 ;
            lane5<=8'd0 ;
            lane6<=8'd0 ;
            lane7<=8'd0 ;
            end       
   else if(rw_control==8'b11110000)begin
            lane0<=data_buffer1[63:56] ;
            lane1<=data_buffer1[31:24] ;
            lane2<=data_buffer2[63:56] ;
            lane3<=data_buffer2[31:24] ;
            lane4<=data_buffer3[63:56] ;
            lane5<=data_buffer3[31:24] ;
            lane6<=data_buffer4[63:56] ;
            lane7<=data_buffer4[31:24] ;
            end
   else if(rw_control==8'b00001000) begin
            lane0<=data_buffer1[55:48] ;
            lane1<=data_buffer1[23:16] ;
            lane2<=data_buffer2[55:48] ;
            lane3<=data_buffer2[23:16] ;
            lane4<=data_buffer3[55:48] ;
            lane5<=data_buffer3[23:16] ;
            lane6<=data_buffer4[55:48] ;
            lane7<=data_buffer4[23:16] ;
            end
   else if(rw_control==8'b00001100) begin
            lane0<=data_buffer1[47:40] ;
            lane1<=data_buffer1[15:8 ] ;
            lane2<=data_buffer2[47:40] ;
            lane3<=data_buffer2[15:8 ] ;
            lane4<=data_buffer3[47:40] ;
            lane5<=data_buffer3[15:8 ] ;
            lane6<=data_buffer4[47:40] ;
            lane7<=data_buffer4[15:8 ] ;
            end
   else if(rw_control==8'b00001110) begin
            lane0<=data_buffer1[39:32] ;
            lane1<=data_buffer1[7 :0 ] ;
            lane2<=data_buffer2[39:32] ;
            lane3<=data_buffer2[7 : 0] ;
            lane4<=data_buffer3[39:32] ;
            lane5<=data_buffer3[7 : 0] ;
            lane6<=data_buffer4[39:32] ;
            lane7<=data_buffer4[7 : 0] ;
            end
   else if(rw_control==8'b00001111) begin
            lane0<=data_buffer5[63:56] ;
            lane1<=data_buffer5[31:24] ;
            lane2<=data_buffer6[63:56] ;
            lane3<=data_buffer6[31:24] ;
            lane4<=data_buffer7[63:56] ;
            lane5<=data_buffer7[31:24] ;
            lane6<=data_buffer8[63:56] ;
            lane7<=data_buffer8[31:24] ;
            end
   else if(rw_control==8'b10000000) begin
            lane0<=data_buffer5[55:48] ;
            lane1<=data_buffer5[23:16] ;
            lane2<=data_buffer6[55:48] ;
            lane3<=data_buffer6[23:16] ;
            lane4<=data_buffer7[55:48] ;
            lane5<=data_buffer7[23:16] ;
            lane6<=data_buffer8[55:48] ;
            lane7<=data_buffer8[23:16] ;
            end
   else if(rw_control==8'b11000000) begin
            lane0<=data_buffer5[47:40] ;
            lane1<=data_buffer5[15:8 ] ;
            lane2<=data_buffer6[47:40] ;
            lane3<=data_buffer6[15:8 ] ;
            lane4<=data_buffer7[47:40] ;
            lane5<=data_buffer7[15:8 ] ;
            lane6<=data_buffer8[47:40] ;
            lane7<=data_buffer8[15:8 ] ;
            end
   else if(rw_control==8'b11100000) begin
            lane0<=data_buffer5[39:32] ;
            lane1<=data_buffer5[7 :0 ] ;
            lane2<=data_buffer6[39:32] ;
            lane3<=data_buffer6[7 : 0] ;
            lane4<=data_buffer7[39:32] ;
            lane5<=data_buffer7[7 : 0] ;
            lane6<=data_buffer8[39:32] ;
            lane7<=data_buffer8[7 : 0] ;
            end
   end


   
always  @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        full1<=1'b0 ;
    end
    else if(rw_control==8'b00000000||rw_control==8'b00001111) begin
        full1<=1'b1;
    end
    else if(rw_control==8'b11110000)begin
        full1<=1'b0;
    end
	else
		full1 <= full1;
end


always  @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        full2<=1'b0 ;
    end
    else if(rw_control==8'b10000000) begin
        full2<=1'b1;
    end
    else if(rw_control==8'b11110000)begin
        full2<=1'b0;
    end
	else
		full2 <= full2;
end


always  @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        full3<=1'b0 ;
    end
    else if(rw_control==8'b11000000) begin
        full3<=1'b1;
    end
    else if(rw_control==8'b11110000)begin
        full3<=1'b0;
    end
	else
		full3 <= full3;
end


always  @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        full4<=1'b0 ;
    end
    else if(rw_control==8'b11100000) begin
        full4<=1'b1;
    end
    else if(rw_control==8'b11110000)begin
        full4<=1'b0;
    end
	else
		full4 <= full4;
end


always  @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        full5<=1'b0 ;
    end
    else if(rw_control==8'b11110000) begin
        full5<=1'b1;
    end
    else if(rw_control==8'b00001111)begin
        full5<=1'b0;
    end
	else
		full5 <= full5;
end



always  @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        full6<=1'b0 ;
    end
    else if(rw_control==8'b00001000) begin
        full6<=1'b1;
    end
    else if(rw_control==8'b00001111)begin
        full6<=1'b0;
    end
	else
		full6 <= full6;
end


always  @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        full7<=1'b0 ;
    end
    else if(rw_control==8'b00001100) begin
        full7<=1'b1;
    end
    else if(rw_control==8'b00001111)begin
        full7<=1'b0;
    end
	else
		full7 <= full7;
end


always  @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        full8<=1'b0 ;
    end
    else if(rw_control==8'b00001110) begin
        full8<=1'b1;
    end
    else if(rw_control==8'b00001111)begin
        full8<=1'b0;
    end
	else
		full8 <= full8;
end

endmodule
