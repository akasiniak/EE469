`timescale 1ns/10ps
module adder64Bit(result, A, B);
	input logic [63:0] A, B;
	output logic [63:0] result;
	logic [63:0] carryLogic;
	parameter DELAY = 0.5;

	full_adder adder0(.out(result[0]), .Cout(carryLogic[0]), .A(A[0]), .B(B[0]), .Cin(1'b0));
	genvar i;
	generate
		for(i = 1; i < 64; i++) begin: eachAdder
			full_adder adders(.out(result[i]), .Cout(carryLogic[i]), .A(A[i]), .B(B[i]), .Cin(carryLogic[i-1]));
		end
	endgenerate
endmodule

module adder64Bit_testbench;
	logic [63:0] A,B;
	logic [63:0] result;
	adder64Bit dut(.result, .A, .B);
	integer i;
	initial begin
		A[63:0] = 12412;
		B[63:0] = 4;
		#100;
		A[63:0] = result[63:0];
		B[63:0] = 4;
		#100;
		A[63:0] = result[63:0];
		B[63:0] = 1234;
		#100;
		A[63:0] = result[63:0];
		B[63:0] = 4;
		#100;
		A[63:0] = result[63:0];
		for(i = 0; i < 63; i++) begin
			B[i] = 1'b1;
		end
		B[63] = 0;
		#100;
		A[63:0] = result[63:0];
	end
endmodule