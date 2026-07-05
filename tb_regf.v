module tb_reg_file;

reg clk;
reg we;

reg  [3:0] wr_addr;
reg  [15:0] wr_data;

reg  [3:0] rd_addr1;
reg  [3:0] rd_addr2;

wire [15:0] rd_data1;
wire [15:0] rd_data2;

// Instantiate DUT
reg_file dut (
    .clk(clk),
    .we(we),
    .wr_addr(wr_addr),
    .wr_data(wr_data),
    .rd_addr1(rd_addr1),
    .rd_addr2(rd_addr2),
    .rd_data1(rd_data1),
    .rd_data2(rd_data2)
);

//
// Clock generation
//
initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

//
// Stimulus
//
initial begin
    we = 0;
    wr_addr = 0;
    wr_data = 0;
    rd_addr1 = 0;
    rd_addr2 = 0;

    // Write 25 into R1
    #2;
    we = 1;
    wr_addr = 4'd1;
    wr_data = 16'd25;

    #10;

    // Write 50 into R2
    wr_addr = 4'd2;
    wr_data = 16'd50;

    #10;

    // Disable writing
    we = 0;

    // Read R1 and R2
    rd_addr1 = 4'd1;
    rd_addr2 = 4'd2;

    #10;

    // Read R2 and R1
    rd_addr1 = 4'd2;
    rd_addr2 = 4'd1;

    #10;

    $finish;
end

//
// Monitor
//
initial begin
    $monitor("t=%0t we=%b wr_addr=%d wr_data=%d rd_addr1=%d rd_data1=%d rd_addr2=%d rd_data2=%d",
             $time, we, wr_addr, wr_data,
             rd_addr1, rd_data1,
             rd_addr2, rd_data2);
end

//
// Waveform dump
//
initial begin
    $dumpfile("reg_file.vcd");
    $dumpvars(0, tb_reg_file);
end

endmodule
