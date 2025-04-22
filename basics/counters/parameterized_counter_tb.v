//parameterized_counter_tb.v
`timescale 1ns/1ps

module parameterized_counter_tb;
    reg clk;
    reg reset;
    reg up_down_16;
    reg up_down_32;
    wire [15:0] count_16;
    wire [31:0] count_32;

    parameterized_counter #(
       .WIDTH(16)
        )          uut_16 (
        .clk_i(clk),
        .reset_i(reset),
        .up_down_i(up_down_16),
        .count_o(count_16)
    );
    
    parameterized_counter #(
       .WIDTH(32)
        )          uut_32 (
        .clk_i(clk),
        .reset_i(reset),
        .up_down_i(up_down_32),
        .count_o(count_32)
    );


    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // 100MHz clock (10ns period)
    end


    initial begin
        $dumpfile("parameterized_counter.vcd");
        $dumpvars(0, parameterized_counter_tb);

        //---Reset both counters---
        reset = 1;
        #20; // 2 clock cycles

        reset = 0;
        up_down_16 = 1;
        up_down_32 = 1;


        #655360; // 65535 Clock cycles
        $display("count_16 after 65535 cycles incrementing: %d", count_16);
        $display("count_32 after 65535 cycles incrementing: %d", count_32);
        #10000; // 1000 Clock cycles
        $display("count_16 after 66536 cycles incrementing: %d", count_16);
        $display("count_32 after 66536 cycles incrementing: %d", count_32);

        //---Reset both counters---
        reset = 1;
        #20; // 2 clock cycles

        reset = 0;


        #10000; // 1000 Clock cycles
        $display("count_16 after 1000 cycles incrementing: %d", count_16);
        $display("count_32 after 1000 cycles incrementing: %d", count_32);

        up_down_16 = 0;
        up_down_32 = 0;

        #675360 // 67536 Clock cycles
        $display("count_16 after 67536 cycles decrementing: %d", count_16);
        $display("count_32 after 67536 cycles decrementing: %d", count_32);

        $finish;
    end

endmodule