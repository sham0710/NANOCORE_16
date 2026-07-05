module pc (
	input clk,br_en,rstn,pc_en,
	input [15:0] br_t,
	output reg [15:0] pc_out
);

always @(posedge clk or negedge rstn) begin
	if (!rstn)
		pc_out = 16'h0000;
	else if (pc_en && !br_en)
		pc_out <= pc_out + 1;
	else if (pc_en && br_en)
		pc_out <= br_t;
	else
		pc_out  <= pc_out;
end
endmodule
