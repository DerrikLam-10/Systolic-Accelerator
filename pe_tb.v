module pe_tb;
    reg clk, rst, en;
    reg [7:0] a_in, b_in;
    wire [31:0] acc;
    wire [7:0] a_out, b_out;
  
    pe dut(
        .clk(clk),
        .rst(rst),
        .en(en),
        .a_in(a_in),
        .b_in(b_in),
        .a_out(a_out),
        .b_out(b_out),
        .acc(acc)
    );

always #5 clk = ~clk; 

initial begin
    $dumpfile("pe.vcd");
    $dumpvars(0, pe_tb);

    $monitor("t=%0t  a_in=%d b_in=%d  a_out=%d b_out=%d  acc=%d",
         $time, a_in, b_in, a_out, b_out, acc);

    clk = 0;
    rst = 1;
    en = 0;
    a_in = 0;
    b_in = 0;

    #10;
    rst = 0; en = 1;
    
    a_in = 2; b_in = 5; #10;
    a_in = 3; b_in = 6; #10;
    a_in = 4; b_in = 7; #10;

    en = 0; #10;

    $display("acc = %d (expected 56)", acc);
    $finish;
end

endmodule