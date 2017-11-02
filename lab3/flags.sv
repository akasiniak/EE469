module flags (in, out, clk, reset);
	input logic [3:0] in;
	output logic [3:0] out;
	input logic clk, reset;

	genvar i;
	generate
		for(i = 0; i < 4; i++) begin: eachFF
			D_FF flipFlop (.q(out[i]), .d(in[i]), .reset, .clk);
		end
	endgenerate
endmodule

module flags_testbench;
	logic [3:0] in, out;
	logic clk, reset;
	flags dut(.in, .out, .clk, .reset);
	parameter CLOCK_PERIOD=100;
	initial begin
	clk <= 0;
	forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	integer i;
	initial begin
		reset <= 1;
		@(posedge clk);
		reset <= 0;
		@(posedge clk);
		for(i = 0; i < 16; i++) begin
			in[3:0] <= i;
			@(posedge clk);
		end	
		@(posedge clk);
		$stop;
	end
endmodule

