module tb_nanocore16;

reg clk;
reg rstn;

nanocore16 dut 
    .clk(clk),
    .rstn(rstn)
);

// Clock generation
initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

// Reset generation
initial begin
    rstn = 0;
    #12 rstn = 1;
end

// Monitor CPU activity
initial begin
    $monitor("t=%0t PC=%0d",
             $time,
             dut.pc_out);
end

// VCD dump
initial begin
    $dumpfile("nanocore16.vcd");
    $dumpvars(0, tb_nanocore16);
end

// End simulation
initial begin
    #100;
    $finish;
end

endmodule
