module array_tb;
    reg clk, rst, en;
    reg [7:0] a0, a1, b0, b1;
    wire [31:0] c00, c01, c10, c11;

always #5 clk = ~clk;

array dut (
    .clk(clk), .rst(rst), .en(en),
    .a0(a0), .a1(a1), .b0(b0), .b1(b1),
    .c00(c00), .c01(c01), .c10(c10), .c11(c11)
);

initial begin
    $dumpfile("array.vcd");
    $dumpvars(0, array_tb);

    clk = 0; rst = 1; en = 0;
    a0 = 0; a1 = 0; b0 = 0; b1 = 0;

    #10; rst = 0; en = 1;

    a0 = 1; b0 = 5; a1 = 0; b1 = 0; #10;
    a0 = 2; b0 = 7; a1 = 3; b1 = 6; #10;
    a0 = 0; b0 = 0; a1 = 4; b1 = 8; #10;
    a0 = 0; b0 = 0; a1 = 0; b1 = 0; #10;

    // let the last result settle, then read
    #10; en = 0;
    $display("C = [%0d %0d ; %0d %0d]  (expected [19 22 ; 43 50])",
             c00, c01, c10, c11);
    $finish;
end

endmodule