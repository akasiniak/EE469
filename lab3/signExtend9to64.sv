module signExtend9to64 (out, in);
	input logic [8:0] in;
	output logic [63:0] out;
	integer i;
	always_comb begin
		for(int i = 0; i < 9; i++)
			out[i] = in[i];
		for(int i = 9; i < 64; i++)
			out[i] = in[8];
	end
endmodule

module signExtend9to64_testbench;
	logic [8:0] in;
	logic [63:0] out;
	signExtend9to64 dut (.out, .in);
	initial begin
		in[8:0] = 3320;
		#1000;
		in[8:0] = -3246;
		#1000;
	end
endmodule