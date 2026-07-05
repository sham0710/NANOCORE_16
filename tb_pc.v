module tb_pc;

reg clk,br_en,rstn,pc_en;
reg [15:0] br_t;
wire [15:0] pc_out;

pc uut (
	.clk(clk),
	.br_en(br_en),
	.rstn(rstn),
	.br_t(br_t),
	.pc_en(pc_en),
	.pc_out(pc_out)
);

initial
	clk = 0;

	always #5 clk = ~clk;

initial begin
	rstn  = 0; #10;
//	pc_out = 0;
	#20;
	rstn = 1;
	pc_en = 1;
	br_en = 0;
	br_t = 16'd0;

	#20;
	//rstn = 1;
	pc_en = 1;
	br_en = 1;
	br_t = 16'd7;

	#20
	//rstn = 1;
	pc_en = 0;
       // br_t = br_t;
end

initial begin
	$dumpfile("pc.vcd");
	$dumpvars(0,tb_pc);
end
endmodule

