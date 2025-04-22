// half_adder_tb.v
`timescale 1ns/1ps

module half_adder_tb;
    reg a;
    reg b;
    wire sum;
    wire carry;

    half_adder uut (
        .a(a),
        .b(b),
        .sum(sum),
        .carry(carry) 
    );

    task test_half_adder;
        input a_t;
        input b_t;
        input expected_sum;
        input expected_carry;

        begin
            a = a_t; b = b_t;
            #10;

            if(sum != expected_sum || carry != expected_carry) begin
                $display("FAIL: %b + %b != %b carry %b (got %b carry %b)", a_t, b_t, expected_sum, expected_carry, sum, carry);
                $fatal;
            end
        end
    endtask

    initial begin 
        $dumpfile("half_adder.vcd");
        $dumpvars(0, half_adder_tb);

        test_half_adder(0, 0, 0, 0);
        test_half_adder(0, 1, 1, 0);
        test_half_adder(1, 0, 1, 0);
        test_half_adder(1, 1, 0, 1);

        $finish;
    end

endmodule