module signExtend19to64 (out, in);
	input logic [18:0] in;
	output logic [63:0] out;
	integer i;
	always_comb begin
		for(int i = 0; i < 19; i++)
			out[i] = in[i];
		for(int i = 19; i < 64; i++)
			out[i] = in[18];
	end
endmodule

module signExtend19to64_testbench;
	logic [18:0] in;
	logic [63:0] out;
	signExtend19to64 dut (.out, .in);
	initial begin
		in[18:0] = 3320;
		#1000;
		in[18:0] = -3246;
		#1000;
	end
endmodule