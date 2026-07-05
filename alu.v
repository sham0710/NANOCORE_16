module alu (
    input  [15:0] a,
    input  [15:0] b,
    input  [2:0] alu_ctrl,
    output reg [15:0] result,
    output zero
);

always @(*) begin
    case (alu_ctrl)
        3'b000: result = a + b;       // ADD
        3'b001: result = a - b;       // SUB
        3'b010: result = a & b;       // AND
        3'b011: result = a | b;       // OR
        3'b100: result = a ^ b;       // XOR
        3'b101: result = ~a;          // NOT
        3'b110: result = a << 1;      // Shift Left
        3'b111: result = a >> 1;      // Shift Right
        default: result = 16'd0;
    endcase
end

assign zero = (result == 16'd0);

endmodule
