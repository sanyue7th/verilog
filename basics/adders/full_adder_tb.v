// full_adder_tb.v
`timescale 1ns/1ps

module full_adder_tb;
    reg a;
    reg b;
    reg cin;
    wire sum;
    wire cout;

    full_adder uut (
        .a(a),
        .b(b),
        .cin(cin),
        .sum(sum),
        .cout(cout)
    );

    task test_full_adder;
        input a_t;
        input b_t;
        input cin_t;
        input expected_sum;
        input expected_cout;

        begin
            a = a_t; b = b_t; cin = cin_t;
            #10;

            if(sum != expected_sum || cout != expected_cout) begin
                $display("FAIL: %b + %b cin &b != &b carry %b (got %b carry %b)", a_t, b_t, cin_t, expected_sum, expected_cout, sum, cout);
                $fatal;
            end
        end
    endtask

    initial begin 
        $dumpfile("full_adder.vcd");
        $dumpvars(0, full_adder_tb);

        test_full_adder(0, 0, 0, 0, 0);
        test_full_adder(0, 0, 1, 1, 0);
        test_full_adder(0, 1, 0, 1, 0);
        test_full_adder(0, 1, 1, 0, 1);
        test_full_adder(1, 0, 0, 1, 0);
        test_full_adder(1, 0, 1, 0, 1);
        test_full_adder(1, 1, 0, 0, 1);
        test_full_adder(1, 1, 1, 1, 1);

        $finish;
    end

endmodule