module array_gen #(
    parameter N = 2
)(
    input  wire               clk, rst, en,
    input  wire [8*N-1:0]     a,
    input  wire [8*N-1:0]     b,
    output wire [32*N*N-1:0]  c
);

    wire [7:0]  a_wire [0:N-1][0:N];
    wire [7:0]  b_wire [0:N][0:N-1];
    wire [31:0] c_wire [0:N-1][0:N-1];

    genvar i, j;
    generate
        for (i = 0; i < N; i = i + 1) begin: row
            for (j = 0; j < N; j = j + 1) begin: col
                pe pe_inst (
                    .clk(clk), .rst(rst), .en(en),
                    .a_in (a_wire[i][j]),
                    .b_in (b_wire[i][j]),
                    .a_out(a_wire[i][j+1]),
                    .b_out(b_wire[i+1][j]),
                    .acc  (c_wire[i][j])
                );
            end
        end

        for (i = 0; i < N; i = i + 1) begin: a_edge
            assign a_wire[i][0] = a[8*i +: 8];
        end

        for (j = 0; j < N; j = j + 1) begin: b_edge
            assign b_wire[0][j] = b[8*j +: 8];
        end

        for (i = 0; i < N; i = i + 1) begin: c_row
            for (j = 0; j < N; j = j + 1) begin: c_col
                assign c[32*(i*N+j) +: 32] = c_wire[i][j];
            end
        end
    endgenerate

endmodule