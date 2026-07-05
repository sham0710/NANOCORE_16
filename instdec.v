module decoder (
    input  [15:0] instr,
    output reg [3:0] opcode,
    output reg [3:0] rd,
    output reg [3:0] rs,
    output reg [3:0] rt
);

always @(*) begin
    opcode = instr[15:12];
    rd     = instr[11:8];
    rs     = instr[7:4];
    rt     = instr[3:0];
end

endmodule
