module CPUControl (Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemWrite, BrTaken, UncondBr, LDURB, STURB, MOVZ, MOVK, ALUCntrl, OPCode, zero, negative);
	output logic Reg2Loc, MemtoReg, RegWrite, MemWrite, BrTaken, UncondBr, LDURB, STURB, MOVZ, MOVK;
	output logic [1:0] ALUSrc;
	output logic [2:0] ALUCntrl;
	input logic [31:0] OPCode;
	input logic zero, negative;

	always_comb begin
		casez (OPCode[31:20])
			11'b000101zzzzz : begin //B
				Reg2Loc = 1'bz;
				ALUSrc = 2'bzz;
				MemtoReg = 1'bz;
				RegWrite = 1'b0;
				MemWrite = 1'b0;
				BrTaken = 1'b1;
				UncondBr = 1'b1;
				LDURB = 1'bz;
				STURB = 1'bz;
				MOVZ = 1'bz;
				MOVK = 1'bz;
				ALUCntrl = 3'bzzz;
			end
			11'b01010100zzz : begin //B.LT
				Reg2Loc = 1'bz;
				ALUSrc = 2'bzz;
				MemtoReg = 1'bz;
				RegWrite = 1'b0;
				MemWrite = 1'b0;
				BrTaken = negative;
				UncondBr = 1'b0;
				LDURB = 1'bz;
				STURB = 1'bz;
				MOVZ = 1'bz;
				MOVK = 1'bz;
				ALUCntrl = 3'bzzz;
			end
			11'b10110100zzz : begin //CBZ
				Reg2Loc = 1'bz;
				ALUSrc = 2'bzz;
				MemtoReg = 1'bz;
				RegWrite = 1'b0;
				MemWrite = 1'b0;
				BrTaken = zero;
				UncondBr = 1'b0;
				LDURB = 1'bz;
				STURB = 1'bz;
				MOVZ = 1'bz;
				MOVK = 1'bz;
				ALUCntrl = 3'bzzz;
			end
			11'b1001000100z : begin //ADDI
				Reg2Loc = 1'b1;
				ALUSrc = 2'b10;
				MemtoReg = 1'b0;
				RegWrite = 1'b1;
				MemWrite = 1'b0;
				BrTaken = 1'b0;
				UncondBr = 1'bz;
				LDURB = 1'b0;
				STURB = 1'bz;
				MOVZ = 1'b0;
				MOVK = 1'b0;
				ALUCntrl = 3'b010;
			end
			11'b10001011000 : begin //ADDS
				Reg2Loc = 1'b1;
				ALUSrc = 2'b00;
				MemtoReg = 1'b0;
				RegWrite = 1'b1;
				MemWrite = 1'b0;
				BrTaken = 1'b0;
				UncondBr = 1'bz;
				LDURB = 1'b0;
				STURB = 1'bz;
				MOVZ = 1'b0;
				MOVK = 1'b0;
				ALUCntrl = 3'b010;
			end
			11'b11111000010 : begin //LDUR
				Reg2Loc = 1'bz;
				ALUSrc = 2'b01;
				MemtoReg = 1'b1;
				RegWrite = 1'b1;
				MemWrite = 1'b0;
				BrTaken = 1'b0;
				UncondBr = 1'bz;
				LDURB = 1'b0;
				STURB = 1'bz;
				MOVZ = 1'b0;
				MOVK = 1'b0;
				ALUCntrl = 3'b010;
			end
			11'b00111000010 : begin //LDURB
				Reg2Loc = 1'bz;
				ALUSrc = 2'b01;
				MemtoReg = 1'b1;
				RegWrite = 1'b1;
				MemWrite = 1'b0;
				BrTaken = 1'b0;
				UncondBr = 1'bz;
				LDURB = 1'b1;
				STURB = 1'bz;
				MOVZ = 1'b0;
				MOVK = 1'b0;
				ALUCntrl = 3'b010;
			end
			11'b11111000000 : begin //STUR
				Reg2Loc = 1'b0;
				ALUSrc = 2'b01;
				MemtoReg = 1'bz;
				RegWrite = 1'b0;
				MemWrite = 1'b0;
				BrTaken = 1'b0;
				UncondBr = 1'bz;
				LDURB = 1'bz;
				STURB = 1'b0;
				MOVZ = 1'bz;
				MOVK = 1'bz;
				ALUCntrl = 3'b010;
			end
			11'b00111000000 : begin //STURB
				Reg2Loc = 1'b0;
				ALUSrc = 2'b01;
				MemtoReg = 1'bz;
				RegWrite = 1'b0;
				MemWrite = 1'b0;
				BrTaken = 1'b0;
				UncondBr = 1'bz;
				LDURB = 1'bz;
				STURB = 1'b1;
				MOVZ = 1'bz;
				MOVK = 1'bz;
				ALUCntrl = 3'b010;
			end
			11'b11001011000 : begin //SUBS
				Reg2Loc = 1'b1;
				ALUSrc = 2'b00;
				MemtoReg = 1'b0;
				RegWrite = 1'b1;
				MemWrite = 1'b0;
				BrTaken = 1'b0;
				UncondBr = 1'bz;
				LDURB = 1'bz;
				STURB = 1'bz;
				MOVZ = 1'b0;
				MOVK = 1'b0;
				ALUCntrl = 3'b011;
			end
			11'b111100101zz : begin //MOVK
				Reg2Loc = 1'bz;
				ALUSrc = 2'bzz;
				MemtoReg = 1'bz;
				RegWrite = 1'b1;
				MemWrite = 1'b0;
				BrTaken = 1'b0;
				UncondBr = 1'bz;
				LDURB = 1'bz;
				STURB = 1'bz;
				MOVZ = 1'b0;
				MOVK = 1'b1;
				ALUCntrl = 3'bzzz;
			end
			11'b110100101zz : begin //MOVZ
				Reg2Loc = 1'bz;
				ALUSrc = 2'bzz;
				MemtoReg = 1'bz;
				RegWrite = 1'b1;
				MemWrite = 1'b0;
				BrTaken = 1'b0;
				UncondBr = 1'bz;
				LDURB = 1'bz;
				STURB = 1'bz;
				MOVZ = 1'b1;
				MOVK = 1'bz;
				ALUCntrl = 3'bzzz;
			end
			default : begin //No instruction
				Reg2Loc = 1'bz;
				ALUSrc = 2'bzz;
				MemtoReg = 1'bz;
				RegWrite = 1'bz;
				MemWrite = 1'bz;
				BrTaken = 1'bz;
				UncondBr = 1'bz;
				LDURB = 1'bz;
				STURB = 1'bz;
				MOVZ = 1'bz;
				MOVK = 1'bz;	
				ALUCntrl = 3'bzzz;		
			end
		endcase
	end
endmodule 

module CPUControl_testbench;
	logic Reg2Loc, MemtoReg, RegWrite, MemWrite, BrTaken, UncondBr, LDURB, STURB, MOVZ, MOVK, zero, negative;
	logic [1:0] ALUSrc;
	logic [2:0] ALUCntrl;
	logic [31:0] OPCode;

	CPUControl dut(.Reg2Loc, .MemtoReg, .RegWrite, .MemWrite, .BrTaken, .UncondBr, .LDURB, .STURB, .MOVZ, .MOVK, .zero, .negative, 
					.ALUSrc, .ALUCntrl, .OPCode);
	initial begin
		negative = 1'b1;
		zero = 1'b1;
		OPCode[31:20] = 11'b00010110101; //B
		$display("@%0dps instruction is B", $time);
		#1000;
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
		OPCode[31:20] = 11'b00111000000; //STURB
		$display("@%0dps instruction is STURB", $time);
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