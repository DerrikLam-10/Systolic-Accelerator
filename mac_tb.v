module mac_tb;
    reg clk, rst, en;
    reg [7:0] a;
    reg [7:0] b;
    wire [31:0] acc;

    mac dut(
        .clk(clk),
        .rst(rst),
        .en(en),
        .a(a),
        .b(b),
        .acc(acc)
    );

always #5 clk = ~clk; 

initial begin
    $dumpfile("mac.vcd");
    $dumpvars(0, mac_tb);

    clk = 0;
    rst = 1;
    en = 0;
    a = 0;
    b = 0;

    #10;
    rst = 0; en = 1;
    
    a = 2; b = 5; #10;
    a = 3; b = 6; #10;
    a = 4; b = 7; #10;

    en = 0; #10;

    $display("acc = %d (expected 56)", acc);
    $finish;
end

endmodule