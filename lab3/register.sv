module register #(parameter WIDTH = 64) (dataOut, dataIn, enable, clk, reset);
	input logic [WIDTH-1:0] dataIn;
	input logic enable, reset, clk;
	output logic [WIDTH-1:0] dataOut;
	
	genvar i;
	generate
		for(i = 0; i < WIDTH; i++) begin: eachD_FF_Enable
			D_FF_Enable dataStore (.out(dataOut[i]), .in(dataIn[i]), .reset, .clk, .enable);
		end
	endgenerate
endmodule

module register_testbench;
	logic [63:0] dataIn;
	logic enable, reset, clk;
	logic [63:0] dataOut;
	
	parameter CLOCK_PERIOD=100;
	initial begin
	clk <= 0;
	forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	initial begin
		@(posedge clk);
		reset <= 1;
		enable <= 0;
		dataIn <= 253;
		@(posedge clk);
		reset <= 0;
		@(posedge clk);
		enable <= 1;
		@(posedge clk);
		@(posedge clk);
		dataIn <= 55632;
		@(posedge clk);
		@(posedge clk);
		enable <= 0;
		@(posedge clk);
		dataIn <= 54362;
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		$stop;
	end
	register dut (.dataOut, .dataIn, .reset, .clk, .enable);
endmodule
