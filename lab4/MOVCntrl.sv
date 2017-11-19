`timescale 1ns/10ps
module MOVCntrl (muxCntrl, SHAMT, MOVZ);
	parameter DELAY = 0.05;	
	output logic [3:0][1:0] muxCntrl;
	input logic [1:0] SHAMT;
	input logic MOVZ;

	logic [3:0] cntrl1Logic, cntrl0Logic;
	logic [1:0] cntrl1Inverter;
	logic [1:0] cntrl0Inverter;

	//Start putting together the control logic
	//Control logic for mux 0-15:
	or #DELAY orUnit0(cntrl1Logic[0], SHAMT[1], SHAMT[0]);
	and #DELAY andUnit0(muxCntrl[0][1], MOVZ, cntrl1Logic[0]);
	
	nor #DELAY norUnit0(muxCntrl[0][0], SHAMT[1], SHAMT[0]);

	//Control logic for mux 16-31:
	not #DELAY notUnit0(cntrl1Inverter[0], SHAMT[1]);
	nand #DELAY nandUnit0(cntrl1Logic[1], cntrl1Inverter[0], SHAMT[0]);
	and #DELAY andUnit1(muxCntrl[1][1], cntrl1Logic[1], MOVZ);

	not #DELAY notUnit1(cntrl0Inverter[0], SHAMT[1]);
	and #DELAY andUnit2(muxCntrl[1][0], cntrl0Inverter[0], SHAMT[0]);

	//Control logic for mux 32-47:
	not #DELAY notUnit2(cntrl1Inverter[1], SHAMT[0]);
	nand #DELAY nandUnit1(cntrl1Logic[2], cntrl1Inverter[1], SHAMT[1]);
	and #DELAY andUnit3(muxCntrl[2][1], cntrl1Logic[2], MOVZ);

	not #DELAY notUnit3(cntrl0Inverter[1], SHAMT[0]);
	and #DELAY andUnit4(muxCntrl[2][0], cntrl0Inverter[1], SHAMT[1]);

	//Control logic for mux 48-63:
	nand #DELAY nandUnit2(cntrl1Logic[3], SHAMT[1], SHAMT[0]);
	and #DELAY andUnit5(muxCntrl[3][1], cntrl1Logic[3], MOVZ);

	and #DELAY andUnit6(muxCntrl[3][0], SHAMT[0], SHAMT[1]);
endmodule

module MOVCntrl_testbench;
	logic [3:0][1:0] muxCntrl;
	logic [1:0] SHAMT;
	logic MOVZ;
	integer i;

	MOVCntrl dut (.muxCntrl, .SHAMT, .MOVZ);

	initial begin
		MOVZ = 1'b1;
		for(i = 0; i < 8; i++) begin
			SHAMT[1:0] = i/2;
			MOVZ = ~MOVZ;
			#10;
		end 
	end
endmodule