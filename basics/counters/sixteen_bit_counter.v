//sixteen_bit_counter.v

module sixteen_bit_counter (
    input wire clk,
    input wire reset,
    output reg [15:0] count
);

    wire [3:0] sum0, sum1, sum2, sum3;
    wire carry0, carry1, carry2;

    four_bit_adder adder0 (
        .a(count[3:0]),
        .b(4'b0001),
        .cin(1'b0),
        .sum(sum0),
        .cout(carry0)
    );

    four_bit_adder adder1 (
        .a(count[7:4]),
        .b(4'b0000),
        .cin(carry0),
        .sum(sum1),
        .cout(carry1)
    );

    four_bit_adder adder2 (
        .a(count[11:8]),
        .b(4'b0000),
        .cin(carry1),
        .sum(sum2),
        .cout(carry2)
    );

    four_bit_adder adder3 (
        .a(count[15:12]),
        .b(4'b0000),
        .cin(carry2),
        .sum(sum3),
        .cout()
    );

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            count <= 16'b0;
        end else begin
            count <= {sum3, sum2, sum1, sum0};
        end
    end

endmodule
