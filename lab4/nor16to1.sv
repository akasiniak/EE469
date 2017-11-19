`timescale 1ns/10ps
module nor16to1 (out, Din);
	parameter DELAY = 0.05;
	input logic [15:0] Din;
	output logic out;
	logic [3:0] norOut;
	
	genvar i;
	generate
		for (i = 0; i < 4; i++) begin: eachNor
			nor #DELAY norGate(norOut[i], Din[(4*i)], Din[((4*i) + 1)], Din[((4*i) + 2)], Din[((4*i) + 3)]);
		end
	endgenerate 
	
	and #50 andGate(out, norOut[0], norOut[1], norOut[2], norOut[3]);
endmodule

module nor16to1_testbench;
	logic [15:0] Din;
	logic out;
	logic [3:0] norOut;
	
	nor16to1 dut(.out, .Din);

	initial begin
		integer i;
		for(i = 0; i < 65536; i++) begin
			Din = i;
			#200;
		end
	end
endmodule