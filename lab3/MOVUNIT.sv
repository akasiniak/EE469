`timescale 1ns/10ps
module MOVUNIT (result, IMM16, Rd, MOVZ, SHAMT);
	parameter DELAY = 0.05;
	output logic [63:0] result;
	input logic [63:0] Rd;
	input logic [15:0] IMM16;
	input logic [1:0] SHAMT;
	input logic MOVZ;
	logic [3:0][1:0] muxCntrl;
	logic [63:0][3:0] intoMux;
	integer i;
	always_comb begin
		for(i = 0; i < 64; i++) begin
			intoMux[i][0] = Rd[i];
			intoMux[i][1] = IMM16[i % 16];
			intoMux[i][2] = 0;
		end
	end

	MOVCntrl controlUnit(.muxCntrl, .SHAMT, .MOVZ);
	genvar j;
	generate
		for(j = 0; j < 64; j++) begin: MOVLogic
			mux4to1 eachMux(.out(result[j]), .select(muxCntrl[j / 16][1:0]), .muxIn(intoMux[j][3:0]));
		end
	endgenerate
endmodule

module MOVUNIT_testbench;
	logic [63:0] result, Rd;
	logic [15:0] IMM16;
	logic [1:0] SHAMT;
	logic MOVZ;

	MOVUNIT dut(.result, .IMM16, .Rd, .MOVZ, .SHAMT);
	integer i;
	
	initial begin
		Rd[63:0] = 4125124;
		IMM16[15:0] = 342341;
		for(i = 0; i < 8; i++) begin
			SHAMT[1:0] = i;
			MOVZ = i/4;
			#1000;
		end
	end
endmodule
	
	

