module nanocore16 (
    input clk,
    input rstn
);

wire [15:0] pc_out;
wire [15:0] instr;

// Decoder outputs
wire [3:0] opcode;
wire [3:0] rd;
wire [3:0] rs;
wire [3:0] rt;

// Register file outputs
wire [15:0] reg_data1;
wire [15:0] reg_data2;

// ALU outputs
wire [15:0] alu_result;
wire zero;

// PC control
wire pc_en;
wire br_en;
wire [15:0] br_t;

// Register file control
wire reg_write;

// ALU control
wire [2:0] alu_ctrl;

assign pc_en = 1'b1;

//--------------------------------------------------
// Program Counter
//--------------------------------------------------
pc PC (
    .clk(clk),
    .rstn(rstn),
    .pc_en(pc_en),
    .br_en(br_en),
    .br_t(br_t),
    .pc_out(pc_out)
);

//--------------------------------------------------
// Instruction Memory
//--------------------------------------------------
instr_mem IMEM (
    .addr(pc_out[7:0]),
    .instr(instr)
);

//--------------------------------------------------
// Instruction Decoder
//--------------------------------------------------
decoder DEC (
    .instr(instr),
    .opcode(opcode),
    .rd(rd),
    .rs(rs),
    .rt(rt)
);

//--------------------------------------------------
// Simple Control Unit
//--------------------------------------------------
assign reg_write = (opcode <= 4'd4);

assign alu_ctrl =
       (opcode == 4'b0000) ? 3'b000 :   // ADD
       (opcode == 4'b0001) ? 3'b001 :   // SUB
       (opcode == 4'b0010) ? 3'b010 :   // AND
       (opcode == 4'b0011) ? 3'b011 :   // OR
       (opcode == 4'b0100) ? 3'b100 :   // XOR
                             3'b000;

//--------------------------------------------------
// Register File
//--------------------------------------------------
reg_file RF (
    .clk(clk),
    .we(reg_write),
    .wr_addr(rd),
    .wr_data(alu_result),

    .rd_addr1(rs),
    .rd_addr2(rt),

    .rd_data1(reg_data1),
    .rd_data2(reg_data2)
);

//--------------------------------------------------
// ALU
//--------------------------------------------------
alu ALU (
    .a(reg_data1),
    .b(reg_data2),
    .alu_ctrl(alu_ctrl),
    .result(alu_result),
    .zero(zero)
);

//--------------------------------------------------
// Branch Logic
//--------------------------------------------------
assign br_en = (opcode == 4'b0110) && zero;

assign br_t = {12'd0, instr[3:0]};

endmodule
