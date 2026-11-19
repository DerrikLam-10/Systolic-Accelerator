module array(
    input wire clk, rst, en,
    input wire [7:0] a0, a1, b0, b1,
    output wire [31:0] c00, c01, c10, c11
); 

wire [7:0] a00_01;
wire [7:0] b00_10;
wire [7:0] a10_11;
wire [7:0] b01_11;

pe pe00(
    .clk(clk),
    .rst(rst),
    .en(en),
    .a_in(a0),
    .b_in(b0),
    .a_out(a00_01),
    .b_out(b00_10),
    .acc(c00)
);

pe pe01(
    .clk(clk),
    .rst(rst),
    .en(en),
    .a_in(a00_01),
    .b_in(b1),
    .a_out(),
    .b_out(b01_11),
    .acc(c01)
);

pe pe10(
    .clk(clk),
    .rst(rst),
    .en(en),
    .a_in(a1),
    .b_in(b00_10),
    .a_out(a10_11),
    .b_out(),
    .acc(c10)
);

pe pe11(
    .clk(clk),
    .rst(rst),
    .en(en),
    .a_in(a10_11),
    .b_in(b01_11),
    .a_out(),
    .b_out(),
    .acc(c11)
);


endmodule