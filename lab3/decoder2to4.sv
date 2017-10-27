`timescale 1ns/10ps
module decoder2to4 (decoded, coded, writeEn);
	output logic [3:0] decoded;
	input logic writeEn;
	input logic [1:0] coded;
	
	and #50 theAndGate1(decoded[0], ~coded[0], ~coded[1], writeEn); //00XXX
	and #50 theAndGate2(decoded[1], coded[0], ~coded[1], writeEn);  //01XXX
	and #50 theAndGate3(decoded[2], ~coded[0], coded[1], writeEn);  //10XXX
	and #50 theAndGate4(decoded[3], coded[0], coded[1], writeEn);   //11XXX
endmodule

module decoder2to4_testbench;
	logic writeEn;
	logic [3:0]decoded;
	logic [1:0] coded;
	initial begin
		integer i;
		writeEn = 1;
		for(i = 0; i < 4; i++) begin
			coded = i;
			#10;
		end
	end
	decoder1to2 dut(.decoded, .coded, .writeEn);
endmodule
	