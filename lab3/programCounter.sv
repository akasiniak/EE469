module programCounter (in, out, clk, reset);
	input logic [63:0] in;
	output logic [63:0] out;
	input logic clk, reset;

	genvar i;
	generate
		for(i = 0; i < 64; i++) begin: eachFF
			D_FF flipFlop (.q(out[i]), .d(in[i]), .reset, .clk);
		end
	endgenerate
endmodule

module programCounter_testbench;
	logic [63:0] in, out;
	logic clk, reset;
	programCounter dut(.in, .out, .clk, .reset);
	parameter CLOCK_PERIOD=100;
	initial begin
	clk <= 0;
	forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	initial begin
		reset <= 1;
		@(posedge clk);
		reset <= 0;
		in[63:0] <= 13421451;
		@(posedge clk);
		in[63:0] <= 13421451 + 4;
		@(posedge clk);
		in[63:0] <= 13421455 + 4;
		@(posedge clk);
		in[63:0] <= 13421459 + 4;
		@(posedge clk);
		in[63:0] <= 13421464 + 13432213;
		@(posedge clk);
		$stop;
	end
endmodule

