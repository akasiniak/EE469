module MOVUNIT (result, IMM16, Rd, MOVZ, SHAMT);
	paramter DELAY = 0.05;
	output logic [63:0] result;
	input logic [63:0] Rd;
	input logic [15:0] IMM16;
	input logic [1:0] SHAMT;
	input logic MOVZ;
	logic [3:0][1:0] muxCntrl;

	MOVCntrl controlUnit(.muxCntrl, .SHAMT, .MOVZ);
	
	
	

