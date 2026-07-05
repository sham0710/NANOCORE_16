module instr_mem (
    input  [7:0] addr,
    output [15:0] instr
);

reg [15:0] mem [0:255];

assign instr = mem[addr];

initial begin
    mem[0] = 16'h1123;
    mem[1] = 16'h2456;
    mem[2] = 16'h3120;
    mem[3] = 16'h400A;
end

endmodule
