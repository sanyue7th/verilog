//four_bit_adder_tb.v
`timescale 1ns/1ps

module four_bit_adder_tb;
    reg [3:0] a;
    reg [3:0] b;
    reg cin;
    wire [3:0] sum;
    wire cout;

    four_bit_adder uut (
        .a(a),
        .b(b),
        .cin(cin),
        .sum(sum),
        .cout(cout)
    );

    task test_four_bit_adder;
        input [3:0] a_t;
        input [3:0] b_t;
        input cin_t;
        input [3:0] expected_sum;
        input expected_cout;

        begin
            a = a_t; b = b_t; cin = cin_t;
            #10;

            if (sum !== expected_sum || cout !== expected_cout) begin
            $display("FAIL: %b + %b + %b = %b (got %b)", a_t, b_t, cin_t, expected_sum, sum);
            $fatal;
            end else begin
            $display("PASS: %b + %b + %b = %b", a_t, b_t, cin_t, sum);
            end
        end
    endtask

    initial begin
        $dumpfile("four_bit_adder.vcd");
        $dumpvars(0, four_bit_adder_tb);
        test_four_bit_adder(4'b0001, 4'b0010, 1'b0, 4'b0011, 1'b0);
        test_four_bit_adder(4'b1111, 4'b0001, 1'b0, 4'b0000, 1'b1);
        test_four_bit_adder(4'b0100, 4'b1010, 1'b1, 4'b1111, 1'b0);
    end

endmodule