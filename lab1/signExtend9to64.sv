module signExtend9to64 (out, in);
	input logic [8:0] in;
	output logic [63:0] out;
	integer i;
	always_comb begin
		for(int i = 0; i < 9; i++)
			assign out[i] = in[i];
		for(int i = 9; i < 63; i++)
			assign out[i] = in[8];
	end
endmodule

module signeExtend9to64_testbench;
	logic [8:0] in;
	logic [63:0] out;
	signExtend9to64 dut (.out, .in);
	in = 3320;
	#1000;
	in = 21351;
	#1000;
endmodule