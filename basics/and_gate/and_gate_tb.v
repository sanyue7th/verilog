// and_gate_tb.v
`timescale 1ns / 1ps

module and_gate_tb;
    reg a;
    reg b;
    wire y;

    and_gate uut (
        .a(a),
        .b(b),
        .y(y)
    );

    task test_and;
        input a_t;
        input b_t;
        input expected_y;

        begin
            a = a_t; b = b_t;
            #10;

            if(y != expected_y) begin
                $display("FAIL: %b & %b != &b (got %b)", a_t, b_t, expected_y, y);
                $fatal;
            end
        end
    endtask

    initial begin
        $dumpfile("and_gate.vcd");
        // This dumps all variables (level 0) from the module into the VCD file
        // The first argument '0' means dump all variables at all levels under this module
        // The second argument specifies which module to dump variables from
        $dumpvars(0, and_gate_tb);
        test_and(0, 0, 0);
        test_and(0, 1, 0);
        test_and(1, 0, 0);
        test_and(1, 1, 1);

        $finish;
    end

endmodule