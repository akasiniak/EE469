`timescale 1ns/10ps
module full_adder(out, Cout, A, B, Cin);
	parameter DELAY = 0.5;
	output logic out, Cout;
	input logic A, B, Cin;
	logic xor1_out, and1_out, and2_out;
	
	xor #DELAY xor1 (xor1_out, A, B);
	xor #DELAY xor2 (out, xor1_out, Cin);
	and #DELAY and1 (and1_out, xor1_out, Cin);
	and #DELAY and2 (and2_out, A, B);
	or #DELAY or1 (Cout, and1_out, and2_out);
	
endmodule

module full_adder_testbench;
	logic out, Cout;
	logic A, B, Cin;
	
	full_adder dut (.out, .Cout, .A, .B, .Cin);

	initial begin
		integer i;
		integer j;
		for(i = 0; i < 4; i++) begin
			Cin = 1;
			A = i;
			for(j = 0; j < 4; j++) begin
				#200;
				B = j;
			end
		end
	end
endmodule