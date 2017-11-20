`timescale 1ns/10ps
module CPUControl (Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemWrite, BrTaken, UncondBr, LDURB, xfer_size, read_enable,
					MOVZ, MOVK, ALUCntrl, OPCode, zero, negative, overflow, NOOP);
	parameter DELAY = 0.05;	
	output logic Reg2Loc, MemtoReg, RegWrite, MemWrite, BrTaken, UncondBr, read_enable, LDURB, MOVZ, MOVK, NOOP;
	output logic [1:0] ALUSrc;
	output logic [2:0] ALUCntrl;
	output logic [3:0] xfer_size;
	input logic [31:0] OPCode;
	input logic zero, negative, overflow;
			
	xor #DELAY actuallyNegative(negativeOverflow, negative, overflow);
	
	always_comb begin
		casez (OPCode[31:21])
			11'b000101zzzzz: begin //B
				Reg2Loc = 1'bz;
				ALUSrc = 2'bzz;
				MemtoReg = 1'bz;
				RegWrite = 1'b0;
				MemWrite = 1'b0;
				BrTaken = 1'b1;
				UncondBr = 1'b1;
				read_enable = 1'b0;
				LDURB = 1'bz;
				xfer_size = 4'b1000;
				MOVZ = 1'bz;
				MOVK = 1'bz;
				ALUCntrl = 3'bzzz;
				NOOP = 1'b1;
			end
			11'b01010100zzz: begin //B.LT
				Reg2Loc = 1'bz;
				ALUSrc = 2'bzz;
				MemtoReg = 1'bz;
				RegWrite = 1'b0;
				MemWrite = 1'b0;
				BrTaken = negativeOverflow;
				UncondBr = 1'b0;
				read_enable = 1'b0;
				LDURB = 1'bz;
				xfer_size = 4'b1000;
				MOVZ = 1'bz;
				MOVK = 1'bz;
				ALUCntrl = 3'bzzz;
				NOOP = 1'b1;
			end
			11'b10110100zzz: begin //CBZ
				Reg2Loc = 1'b0;
				ALUSrc = 2'b00;
				MemtoReg = 1'bz;
				RegWrite = 1'b0;
				MemWrite = 1'b0;
				BrTaken = zero;
				UncondBr = 1'b0;
				read_enable = 1'b0;
				LDURB = 1'bz;
				xfer_size = 4'b1000;
				MOVZ = 1'bz;
				MOVK = 1'bz;
				ALUCntrl = 3'b000;
				NOOP = 1'b0;
			end
			11'b1001000100z: begin //ADDI
				Reg2Loc = 1'b1;
				ALUSrc = 2'b10;
				MemtoReg = 1'b0;
				RegWrite = 1'b1;
				MemWrite = 1'b0;
				BrTaken = 1'b0;
				UncondBr = 1'bz;
				read_enable = 1'b0;
				LDURB = 1'b0;
				xfer_size = 4'b1000;
				MOVZ = 1'b0;
				MOVK = 1'b0;
				ALUCntrl = 3'b010;
				NOOP = 1'b1;
			end
			11'b10101011000: begin //ADDS
				Reg2Loc = 1'b1;
				ALUSrc = 2'b00;
				MemtoReg = 1'b0;
				RegWrite = 1'b1;
				MemWrite = 1'b0;
				BrTaken = 1'b0;
				UncondBr = 1'bz;
				read_enable = 1'b0;
				LDURB = 1'b0;
				xfer_size = 4'b1000;
				MOVZ = 1'b0;
				MOVK = 1'b0;
				ALUCntrl = 3'b010;
				NOOP = 1'b0;
			end
			11'b11111000010: begin //LDUR
				Reg2Loc = 1'bz;
				ALUSrc = 2'b01;
				MemtoReg = 1'b1;
				RegWrite = 1'b1;
				MemWrite = 1'b0;
				BrTaken = 1'b0;
				UncondBr = 1'bz;
				read_enable = ~MemWrite;
				LDURB = 1'b0;
				xfer_size = 4'b1000;
				MOVZ = 1'b0;
				MOVK = 1'b0;
				ALUCntrl = 3'b010;
				NOOP = 1'b1;
			end
			11'b00111000010: begin //LDURB
				Reg2Loc = 1'bz;
				ALUSrc = 2'b01;
				MemtoReg = 1'b1;
				RegWrite = 1'b1;
				MemWrite = 1'b0;
				BrTaken = 1'b0;
				UncondBr = 1'bz;
				read_enable = ~MemWrite;
				LDURB = 1'b1;
				xfer_size = 4'b0001;
				MOVZ = 1'b0;
				MOVK = 1'b0;
				ALUCntrl = 3'b010;
				NOOP = 1'b1;
			end
			11'b11111000000: begin //STUR
				Reg2Loc = 1'b0;
				ALUSrc = 2'b01;
				MemtoReg = 1'bz;
				RegWrite = 1'b0;
				MemWrite = 1'b1;
				BrTaken = 1'b0;
				UncondBr = 1'bz;
				read_enable = 1'b0;
				LDURB = 1'bz;
				xfer_size = 4'b1000;
				MOVZ = 1'bz;
				MOVK = 1'bz;
				ALUCntrl = 3'b010;
				NOOP = 1'b1;
			end
			11'b00111000000: begin //STURB
				Reg2Loc = 1'b0;
				ALUSrc = 2'b01;
				MemtoReg = 1'bz;
				RegWrite = 1'b0;
				MemWrite = 1'b1;
				BrTaken = 1'b0;
				UncondBr = 1'bz;
				read_enable = 1'b0;
				LDURB = 1'bz;
				xfer_size = 4'b0001;
				MOVZ = 1'bz;
				MOVK = 1'bz;
				ALUCntrl = 3'b010;
				NOOP = 1'b1;
			end
			11'b11101011000: begin //SUBS
				Reg2Loc = 1'b1;
				ALUSrc = 2'b00;
				MemtoReg = 1'b0;
				RegWrite = 1'b1;
				MemWrite = 1'b0;
				BrTaken = 1'b0;
				UncondBr = 1'bz;
				read_enable = 1'b0;
				LDURB = 1'bz;
				xfer_size = 4'b1000;
				MOVZ = 1'b0;
				MOVK = 1'b0;
				ALUCntrl = 3'b011;
				NOOP = 1'b0;
			end
			11'b111100101zz: begin //MOVK
				Reg2Loc = 1'b0;
				ALUSrc = 2'bzz;
				MemtoReg = 1'bz;
				RegWrite = 1'b1;
				MemWrite = 1'b0;
				BrTaken = 1'b0;
				UncondBr = 1'bz;
				read_enable = 1'b0;
				LDURB = 1'bz;
				xfer_size = 4'b1000;
				MOVZ = 1'b0;
				MOVK = 1'b1;
				ALUCntrl = 3'bzzz;
				NOOP = 1'b1;
			end
			11'b110100101zz: begin //MOVZ
				Reg2Loc = 1'b0;
				ALUSrc = 2'bzz;
				MemtoReg = 1'bz;
				RegWrite = 1'b1;
				MemWrite = 1'b0;
				BrTaken = 1'b0;
				UncondBr = 1'bz;
				read_enable = 1'b0;
				LDURB = 1'bz;
				xfer_size = 4'b1000;
				MOVZ = 1'b1;
				MOVK = 1'bz;
				ALUCntrl = 3'bzzz;
				NOOP = 1'b1;
			end
			default: begin //No instruction
				Reg2Loc = 1'b0;
				ALUSrc = 2'bzz;
				MemtoReg = 1'bz;
				RegWrite = 1'bz;
				MemWrite = 1'bz;
				BrTaken = 1'b0;
				UncondBr = 1'bz;
				read_enable = 1'b0;
				LDURB = 1'bz;
				xfer_size = 4'bzzzz;
				MOVZ = 1'bz;
				MOVK = 1'bz;	
				ALUCntrl = 3'bzzz;	
				NOOP = 1'bz;	
			end
		endcase
	end
endmodule 

module CPUControl_testbench;
	logic Reg2Loc, MemtoReg, RegWrite, MemWrite, BrTaken, UncondBr, LDURB, read_enable, MOVZ, MOVK, zero, negative;
	logic [1:0] ALUSrc;
	logic [2:0] ALUCntrl;
	logic [3:0] xfer_size;
	logic [31:0] OPCode;

	CPUControl dut(.Reg2Loc, .ALUSrc, .MemtoReg, .RegWrite, .MemWrite, .BrTaken, .UncondBr, .LDURB, .xfer_size, 
					.read_enable, .MOVZ, .MOVK, .ALUCntrl, .OPCode, .zero, .negative);
	initial begin
		negative = 1'b1;
		zero = 1'b1;
		OPCode[31:20] = 11'b00010110101; //B
		$display("@%0dps instruction is B", $time);
		#1000;
		assert(RegWrite == 1'b0);
		assert(MemWrite == 1'b0);
		assert(BrTaken == 1'b1);
		assert(UncondBr == 1'b1);
		OPCode[31:20] = 11'b01010100101; //B.LT
		$display("@%0dps instruction is B.LT", $time);
		#1000;
		OPCode[31:20] = 11'b10110100101; //CBZ
		$display("@%0dps instruction is CBZ", $time);
		#1000;
		OPCode[31:20] = 11'b10010001001; //ADDI
		$display("@%0dps instruction is ADDI", $time);
		#1000;
		OPCode[31:20] = 11'b10001011000; //ADDS
		$display("@%0dps instruction is ADDS", $time);
		#1000;
		OPCode[31:20] = 11'b11111000010; //LDUR
		$display("@%0dps instruction is LDUR", $time);
		#1000;
		OPCode[31:20] = 11'b00111000010; //LDURB
		$display("@%0dps instruction is LDURB", $time);
		#1000;
		OPCode[31:20] = 11'b11111000000; //STUR
		$display("@%0dps instruction is STUR", $time);
		#1000;
		OPCode[31:20] = 11'b00111000000; //xfer_size
		$display("@%0dps instruction is xfer_size", $time);
		#1000;
		OPCode[31:20] = 11'b11001011000; //SUBS
		$display("@%0dps instruction is SUBS", $time);
		#1000;
		OPCode[31:20] = 11'b11110010110; //MOVK
		$display("@%0dps instruction is MOVK", $time);
		#1000;
		OPCode[31:20] = 11'b11010010101; //MOVZ
		$display("@%0dps instruction is MOVZ", $time);
		#1000;
		$stop;
	end
endmodule