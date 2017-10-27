`timescale 1ns/10ps
module nor64to1 (out, Din);
	parameter DELAY = 0.5;
	input logic [63:0] Din;
	output logic out;
	logic [3:0] norOut;

	nor16to1 norGate0to15(norOut[0], Din[15:0]);
	nor16to1 norGate16to31(norOut[1], Din[31:16]);
	nor16to1 norGate32to47(norOut[2], Din[47:32]);
	nor16to1 norGate48to63(norOut[3], Din[63:48]);
	
	and #DELAY andGate(out, norOut[0], norOut[1], norOut[2], norOut[3]);
	
endmodule

module nor64to1_testbench;
	logic [63:0] Din;
	logic out;
	logic [3:0] norOut;
	
	nor64to1 dut(.out, .Din);

	initial begin
		integer i;
		integer j;
		Din = 0;
		#200;
		for(i = 0; i < 256; i++) begin
			Din = i;
			#200;
		end
		Din = 64'hFFFFFFFFFFFFFFFF;
		#200;
	end
endmodule