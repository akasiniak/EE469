module zeroPad #(parameter WIDTH = 9) (out, in);
	input logic [WIDTH-1:0] in;
	output logic [63:0] out;
	integer i;
	always_comb begin
		for(int i = 0; i < WIDTH; i++)
			out[i] = in[i];
		for(int i = WIDTH; i < 64; i++)
			out[i] = 0;
	end
endmodule

module zeroPad_testbench;
	parameter WIDTH = 9;
	logic [WIDTH-1:0] in;
	logic [63:0] out;
	zeroPad #(.WIDTH(WIDTH)) dut (.out, .in);
	initial begin
		in[WIDTH-1:0] = 3320;
		#1000;
		in[WIDTH-1:0] = -3246;
		#1000;
	end
endmodule