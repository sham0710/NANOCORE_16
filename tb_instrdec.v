module tb_decoder;

reg  [15:0] instr;
wire [3:0] opcode;
wire [3:0] rd;
wire [3:0] rs;
wire [3:0] rt;

// Instantiate the DUT
decoder dut (
    .instr(instr),
    .opcode(opcode),
    .rd(rd),
    .rs(rs),
    .rt(rt)
);

// Apply test vectors
initial begin
    // ADD R1, R2, R3
    instr = 16'b0000_0001_0010_0011;
    #10;

    // SUB R4, R5, R6
    instr = 16'b0001_0100_0101_0110;
    #10;

    // AND R7, R8, R9
    instr = 16'b0010_0111_1000_1001;
    #10;

    // OR R10, R11, R12
    instr = 16'b0011_1010_1011_1100;
    #10;

    $finish;
end

// Display outputs
initial begin
    $monitor("t=%0t instr=%b opcode=%b rd=%d rs=%d rt=%d",
             $time, instr, opcode, rd, rs, rt);
end

// Generate waveform file
initial begin
    $dumpfile("decoder.vcd");
    $dumpvars(0, tb_decoder);
end

endmodule
