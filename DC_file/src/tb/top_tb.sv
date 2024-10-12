



module top_tb;

    reg clk;           // Clock signal
    reg res_clk;       // Reset clock signal (clk's double frequency)
    reg rst;           // Reset signal

    // Instantiate the top module



    // Clock generation process
    always #10 clk = ~clk; // Period of clk is 10 time units

    // Reset clock generation process
    always #5 res_clk = ~res_clk; // Period of res_clk is 20 time units

    // Initial block for reset and test case
    initial begin
        clk = 0;
        res_clk = 0;
        rst = 0; // Assert reset initially
        #45;    // Wait for 500 time units
        rst = 1; // De-assert reset
        display_registers();
        #420;    // Wait for 500 time units
        display_registers();
        #10000 $finish();
    end


    top dut (
        .clk(clk),
        .res_clk(res_clk),
        .rst(rst)
    );
  initial begin
        // VCD 文件配置
        $vcdplusfile("top_wave.vpd" );
	$vcdpluson(0,top_tb);


    end
    task display_registers;
        integer i;
        begin
            $display("Register values:");
            for (i = 0; i < 32; i = i + 1) begin
                $display("Register[%0d] = %h", i, dut.register_file.registers[i]);
            end
        end
    endtask
endmodule
