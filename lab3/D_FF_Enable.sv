`timescale 1ns/10ps
module D_FF_Enable (out, in, reset, enable, clk);
	input logic in, reset, clk, enable;
	output out;
	logic dEnabled, qEnabled, intoTheDFF;
	
	
	and #50 dAnd (dEnabled, in, enable);
	and #50 qAnd (qEnabled, out, ~enable);
	or #50 theOrGate (intoTheDFF, dEnabled, qEnabled);
	D_FF theDFF (.q(out), .d(intoTheDFF), .clk, .reset);
endmodule

module D_FF_Enable_testbench;
	logic in, reset, clk, enable;
	logic out;
	parameter CLOCK_PERIOD=100;
	initial begin
	clk <= 0;
	forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	initial begin
		@(posedge clk);
		reset <= 1;
		in <= 0;
		enable <= 0;
		@(posedge clk);
		reset <= 0;
		@(posedge clk);
		@(posedge clk);
		in <= 1;
		@(posedge clk);
		enable <= 1;
		@(posedge clk);
		@(posedge clk);
		enable <= 0;
		@(posedge clk);
		in <= 0;
		@(posedge clk);
		enable <= 1;
		@(posedge clk);
		@(posedge clk);
		$stop;
	end
	D_FF_Enable dut (.out, .in, .reset, .clk, .enable);
endmodule
	