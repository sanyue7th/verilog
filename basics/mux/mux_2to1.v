// mux_2to1.v

module mux_2to1(
    input wire [3:0] a,
    input wire [3:0] b,
    input wire sel,
    output reg [3:0] y
);
    always @ (a or b or sel) begin
        case (sel)
            0 : y <= a;
            1: y <= b;
        endcase
    end

    // assign y = sel ? b : a;

endmodule