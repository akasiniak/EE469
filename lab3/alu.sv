`timescale 1ns/10ps
module alu (A, B, cntrl, result, negative, zero, overflow, carry_out);
	parameter DELAY = 0.5;
	input logic [63:0] A, B;
	input logic [2:0] cntrl;
	output logic [63:0] result;
	output logic negative, zero, overflow, carry_out;
	logic [63:0] adder_out, carryLogic, negSelectMux;
	logic [63:0][7:0] muxLogic;
	
	full_adder fullAdd0(.out(adder_out[0]), .Cout(carryLogic[0]), .A(A[0]), .B(negSelectMux[0]), .Cin(cntrl[0]));
	
	genvar i, j;
	generate
		for(i = 1; i < 64; i++) begin: eachAdder
			full_adder fullAdd(.out(adder_out[i]), .Cout(carryLogic[i]), .A(A[i]), .B(negSelectMux[i]), .Cin(carryLogic[i-1]));
		end
		for(j = 0; j < 64; j++) begin: each8Mux
			assign muxLogic[j][0] = B[j];
			assign muxLogic[j][2] = adder_out[j];
			assign muxLogic[j][3] = adder_out[j];
			and #DELAY andGate(muxLogic[j][4], A[j], B[j]);
			or #DELAY orGate(muxLogic[j][5], A[j], B[j]);
			xor #DELAY xorGate(muxLogic[j][6], A[j], B[j]);
			mux8to1 mux8(.out(result[j]), .select(cntrl[2:0]), .muxIn(muxLogic[j][7:0]));
			mux2to1 mux2(.out(negSelectMux[j]), .in({(~B[j]), (B[j])}), .select(cntrl[0]));
		end
	endgenerate
	
	xor #DELAY xorFlagGate(overflow, carryLogic[63], carryLogic[62]);
	assign negative = adder_out[63];
	assign carry_out = carryLogic[63];
	nor64to1 zeroFlag(zero, result);
	
endmodule

module alu_testbench;
	logic [63:0] A, B;
	logic [2:0] cntrl;
	logic [63:0] result;
	logic negative, zero, overflow, carry_out;
	
	alu dut(.A, .B, .cntrl, .result, .negative, .zero, .overflow, .carry_out);
	
	
	initial begin
		A = 30740;
		B = 200342;
		cntrl = 000; // result = B
		#400;

		cntrl = 010; // result = A + B
		#10000;

		cntrl = 011; // result = A - B
		#10000;

		cntrl = 100; // result = A&B
		#400;

		cntrl = 101; // result = A|B
		#400;

		cntrl = 110; // result = A XOR B
		#400;
	end
endmodule