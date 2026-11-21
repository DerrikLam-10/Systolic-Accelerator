module array_gen_tb;
    parameter N = 2;

    reg  clk, rst, en;
    reg  [8*N-1:0]     a, b;
    wire [32*N*N-1:0]  c;

    // unpack c into readable wires (for N=2)
    wire [31:0] c00 = c[31:0];
    wire [31:0] c01 = c[63:32];
    wire [31:0] c10 = c[95:64];
    wire [31:0] c11 = c[127:96];

    array_gen #(.N(N)) dut (
        .clk(clk), .rst(rst), .en(en),
        .a(a), .b(b), .c(c)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("array_gen.vcd");
        $dumpvars(0, array_gen_tb);

        clk = 0; rst = 1; en = 0;
        a = 0; b = 0;

        #10; rst = 0; en = 1;

        // same staggered schedule — now packed: low byte = row/col 0, high byte = row/col 1
        a[7:0]=1; a[15:8]=0; b[7:0]=5; b[15:8]=0; #10;  // cycle 1
        a[7:0]=2; a[15:8]=3; b[7:0]=7; b[15:8]=6; #10;  // cycle 2
        a[7:0]=0; a[15:8]=4; b[7:0]=0; b[15:8]=8; #10;  // cycle 3
        a[7:0]=0; a[15:8]=0; b[7:0]=0; b[15:8]=0; #10;  // cycle 4

        #10; en = 0;
        $display("C = [%0d %0d ; %0d %0d]  (expected [19 22 ; 43 50])",
                 c00, c01, c10, c11);
        $finish;
    end
endmodule