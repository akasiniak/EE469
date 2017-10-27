`timescale 1ns/10ps
module decoder3to8 (decoded, coded, writeEn);
	output logic [7:0] decoded;
	input logic writeEn;
	input logic [2:0] coded;
	
	and #50 theAndGate1(decoded[0], ~coded[0], ~coded[1], ~coded[2], writeEn); //XX000
	and #50 theAndGate2(decoded[1], coded[0], ~coded[1], ~coded[2], writeEn); //XX001
	and #50 theAndGate3(decoded[2], ~coded[0], coded[1], ~coded[2], writeEn); //XX010
	and #50 theAndGate4(decoded[3], coded[0], coded[1], ~coded[2], writeEn); //XX011
	and #50 theAndGate5(decoded[4], ~coded[0], ~coded[1], coded[2], writeEn); //XX100
	and #50 theAndGate6(decoded[5], coded[0], ~coded[1], coded[2], writeEn); //XX101
	and #50 theAndGate7(decoded[6], ~coded[0], coded[1], coded[2], writeEn); //XX110
	and #50 theAndGate8(decoded[7], coded[0], coded[1], coded[2], writeEn); //XX111
endmodule

module decoder3to8_testbench;
	logic writeEn;
	logic [2:0] coded;
	logic [7:0] decoded;
	initial begin
		integer i;
		writeEn = 1;
		for(i = 0; i < 8; i++) begin
			coded = i;
			#10;
		end
	end
	decoder3to8 dut(.decoded, .coded, .writeEn);
endmodule
