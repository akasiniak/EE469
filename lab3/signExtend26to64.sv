module signExtend26to64 (out, in);
	input logic [25:0] in;
	output logic [63:0] out;
	integer i;
	always_comb begin
		for(int i = 0; i < 26; i++)
			out[i] = in[i];
		for(int i = 26; i < 64; i++)
			out[i] = in[25];
	end
endmodule

module signExtend26to64_testbench;
	logic [25:0] in;
	logic [63:0] out;
	signExtend26to64 dut (.out, .in);
	initial begin
		in[25:0] = 3320;
		#1000;
		in[25:0] = -3246;
		#1000;
	end
endmodule