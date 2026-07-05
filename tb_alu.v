module tb_alu;

reg  [15:0] a, b;
reg  [2:0] alu_ctrl;

wire [15:0] result;
wire zero;

alu dut (
    .a(a),
    .b(b),
    .alu_ctrl(alu_ctrl),
    .result(result),
    .zero(zero)
);

initial begin
    // ADD
    a = 16'd10;
    b = 16'd5;
    alu_ctrl = 3'b000;
    #10;

    // SUB
    alu_ctrl = 3'b001;
    #10;

    // AND
    a = 16'h000F;
    b = 16'h000A;
    alu_ctrl = 3'b010;
    #10;

    // OR
    alu_ctrl = 3'b011;
    #10;

    // XOR
    alu_ctrl = 3'b100;
    #10;

    // NOT
    a = 16'h00FF;
    alu_ctrl = 3'b101;
    #10;

    // Shift Left
    a = 16'd4;
    alu_ctrl = 3'b110;
    #10;

    // Shift Right
    alu_ctrl = 3'b111;
    #10;

    // Zero flag test
    a = 16'd5;
    b = 16'd5;
    alu_ctrl = 3'b001;
    #10;

    $finish;
end

initial begin
    $monitor("t=%0t ctrl=%b a=%d b=%d result=%d zero=%b",
             $time, alu_ctrl, a, b, result, zero);
end

initial begin
    $dumpfile("alu.vcd");
    $dumpvars(0, tb_alu);
end

endmodule
