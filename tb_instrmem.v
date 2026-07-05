module tb_instr_mem;

reg  [7:0] addr;
wire [15:0] instr;

// Instantiate the DUT
instr_mem dut (
    .addr(addr),
    .instr(instr)
);

// Apply test addresses
initial begin
    addr = 8'd0;
    #10;

    addr = 8'd1;
    #10;

    addr = 8'd2;
    #10;

    addr = 8'd3;
    #10;

    addr = 8'd10;   // Uninitialized location
    #10;

    $finish;
end

// Display results
initial begin
    $monitor("t=%0t addr=%0d instr=%h",
             $time, addr, instr);
end

// Generate VCD file
initial begin
    $dumpfile("instr_mem.vcd");
    $dumpvars(0, tb_instr_mem);
end

endmodule
