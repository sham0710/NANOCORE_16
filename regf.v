module reg_file (
    input clk,
    input we,                    // Write enable
    input [3:0] wr_addr,         // Write register address
    input [15:0] wr_data,        // Data to write

    input [3:0] rd_addr1,        // Read register 1 address
    input [3:0] rd_addr2,        // Read register 2 address

    output [15:0] rd_data1,      // Read data 1
    output [15:0] rd_data2       // Read data 2
);

reg [15:0] regs [0:15];

// Synchronous write
always @(posedge clk) begin
    if (we)
        regs[wr_addr] <= wr_data;
end

// Asynchronous reads
assign rd_data1 = regs[rd_addr1];
assign rd_data2 = regs[rd_addr2];

endmodule
