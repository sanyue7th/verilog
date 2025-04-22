//sixteen_bit_counter_tb.v
`timescale 1ns/1ps

module sixteen_bit_counter_tb;
    reg clk;
    reg reset;
    wire [15:0] count;

    sixteen_bit_counter uut (
        .clk(clk),
        .reset(reset),
        .count(count)
    );


    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // 100MHz clock (10ns period)
    end


    initial begin
        $dumpfile("sixteen_bit_counter.vcd");
        $dumpvars(0, sixteen_bit_counter_tb);

        reset = 1;
        #20; // 2 clock cycles

        reset = 0;
        
        #1000;  // 100 Clock cycles

        $display("Count after 100 cycles: %d", count);

        #655360; // 65536 Clock cycles

        $finish;
    end

endmodule