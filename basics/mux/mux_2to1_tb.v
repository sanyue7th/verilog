//mux_2to1_tb.v
`timescale 1ns / 1ps

module mux_2to1_tb;
    reg [3:0] a_i;
    reg [3:0] b_i;
    reg sel_i;
    wire [3:0] y_o;

    mux_2to1 uut(
        .a(a_i),
        .b(b_i),
        .sel(sel_i),
        .y(y_o)
    );

    task test_mux_2to1;
        input [3:0] a_t;
        input [3:0] b_t;
        input sel_t;

        begin
            a_i = a_t; b_i = b_t; sel_i = sel_t;
            #10
            if(y_o != (sel_i ? b_t : a_t)) begin
                $display("FAIL: Mux result expected %b (got %b)", (sel_i ? b_t : a_t), y_o);
                $fatal;
            end
        end
    endtask

    initial begin
        $dumpfile("mux_2to1.vcd");
        $dumpvars(0, mux_2to1_tb);

        test_mux_2to1(4'b0111, 4'b1000, 0);
        test_mux_2to1(4'b0011, 4'b1000, 1);

        $finish;
    end

endmodule