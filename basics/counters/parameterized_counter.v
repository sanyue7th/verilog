//parameterized_counter.v

module parameterized_counter #(
    parameter WIDTH=4
) (
    input wire clk_i,
    input wire reset_i,
    input wire up_down_i,
    output reg [WIDTH-1:0] count_o
);

    localparam num_adders = WIDTH >>> 2;

    wire [WIDTH-1:0] sum;
    wire carries [0:num_adders-1];

    genvar i;
    generate
        for (i = 0; i < num_adders; i = i + 1) begin
            four_bit_adder adder (
                .a(count_o[4*i+3:4*i]),
                .b(i == 0 ? (up_down_i ? 4'b0001 : 4'b1111) : (up_down_i ? 4'b0000 : 4'b1111)),
                .cin(i == 0 ? 1'b0 : carries[i-1]), 
                // There will be false warning for this due to static analysis. 
                .sum(sum[4*i + 3:4*i]),
                .cout(carries[i])
            );
        end
    endgenerate

    always @(posedge clk_i or posedge reset_i) begin
        if (reset_i) begin
            count_o <= {WIDTH{1'b0}};
        end else begin
            count_o <= sum;
        end
    end

endmodule