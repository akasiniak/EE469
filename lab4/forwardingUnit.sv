module forwardingUnit (ForwardMuxControlA, ForwardMuxControlB, REGDECOPCode, EXOPCode, MEMOPCode, EXRegWrite, MEMRegWrite);
	output logic ForwardMuxControlB, ForwardMuxControlA;
	input logic [31:0] REGDECOPCode, EXOPCode, MEMOPCode;
	input logic EXRegWrite, MEMRegWrite;

	initial begin //default case: no forwarding
		ForwardMuxControlA[1:0] = 2'b00;
		ForwardMuxControlB[1:0] = 2'b00;
	end

	always_comb begin
		case({EXRegWrite, MEMRegWrite}) begin
			2'b10: begin //Writing in the EX stage, but not MEM
				if(EXOPCode != 5'b11111) begin
					case(REGDECOPCode) begin
						11'b10110100zzz: begin //CBZ
							if(REGDECOPCode[4:0] == EXOPCode[4:0]) begin //Rd's of both OPCodes match
								ForwardMuxControlB[1:0] = 2'b01;
							end
						end
						11'b1001000100z: begin //ADDI
							if(REGDECOPCode[9:5] == EXOPCode[4:0]) begin //Rn of REGDEC matches Rd of EX
								ForwardMuxControlA[1:0] = 2'b01;
							end
						end
						11'b10101011000: begin //ADDS
							if(REGDECOPCode[9:5] == EXOPCode[4:0]) begin //Rn of REGDEC matches Rd of EX
								ForwardMuxControlA[1:0] = 2'b01;
							end
							if(REGDECOPCode[20:16] == EXOPCode[4:0]) begin //Rm of REGDEC matches Rd of EX
								ForwardMuxControlB[1:0] = 2'b01;
							end
						end
						11'b11111000010: begin //LDUR
							if(REGDECOPCode[9:5] == EXOPCode[4:0]) begin //Rn of REGDEC matches Rd of EX
								ForwardMuxControlA[1:0] = 2'b01;
							end
						end
						11'b00111000010: begin //LDURB
							if(REGDECOPCode[9:5] == EXOPCode[4:0]) begin //Rn of REGDEC matches Rd of EX
								ForwardMuxControlA[1:0] = 2'b01;
							end
						end
						11'b11111000000: begin //STUR
							if(REGDECOPCode[4:0] == EXOPCode[4:0]) begin //Rd of REGDEC matches Rd of EX
								ForwardMuxControlB[1:0] = 2'b01;
							end							
							if(REGDECOPCode[9:5] == EXOPCode[4:0]) begin //Rn of REGDEC matches Rd of EX
								ForwardMuxControlA[1:0] = 2'b01;
							end
						end
						11'b00111000000: begin //STURB
							if(REGDECOPCode[4:0] == EXOPCode[4:0]) begin //Rd of REGDEC matches Rd of EX
								ForwardMuxControlB[1:0] = 2'b01;
							end							
							if(REGDECOPCode[9:5] == EXOPCode[4:0]) begin //Rn of REGDEC matches Rd of EX
								ForwardMuxControlA[1:0] = 2'b01;
							end
						end
						11'b11101011000: begin //SUBS
							if(REGDECOPCode[9:5] == EXOPCode[4:0]) begin //Rn of REGDEC matches Rd of EX
								ForwardMuxControlA[1:0] = 2'b01;
							end
							if(REGDECOPCode[20:16] == EXOPCode[4:0]) begin //Rm of REGDEC matches Rd of EX
								ForwardMuxControlB[1:0] = 2'b01;
							end
						end
						default: begin //Instruction where you don't read from a register
							ForwardMuxControlA[1:0] = 2'b00;
							ForwardMuxControlA[1:0] = 2'b00;
						end 
					endcase
				end
			end
			2'b01: begin //Writing in the MEM stage, but not EX
				if(MEMOPCode != 5'b11111) begin
					case(REGDECOPCode) begin
						11'b10110100zzz: begin //CBZ
							if(REGDECOPCode[4:0] == MEMOPCode[4:0]) begin //Rd's of both OPCodes match
								ForwardMuxControlB[1:0] = 2'b10;
							end
						end
						11'b1001000100z: begin //ADDI
							if(REGDECOPCode[9:5] == MEMOPCode[4:0]) begin //Rn of REGDEC matches Rd of EX
								ForwardMuxControlA[1:0] = 2'b10;
							end
						end
						11'b10101011000: begin //ADDS
							if(REGDECOPCode[9:5] == MEMOPCode[4:0]) begin //Rn of REGDEC matches Rd of EX
								ForwardMuxControlA[1:0] = 2'b10;
							end
							if(REGDECOPCode[20:16] == MEMOPCode[4:0]) begin //Rm of REGDEC matches Rd of EX
								ForwardMuxControlB[1:0] = 2'b10;
							end
						end
						11'b11111000010: begin //LDUR
							if(REGDECOPCode[9:5] == MEMOPCode[4:0]) begin //Rn of REGDEC matches Rd of EX
								ForwardMuxControlA[1:0] = 2'b10;
							end
						end
						11'b00111000010: begin //LDURB
							if(REGDECOPCode[9:5] == MEMOPCode[4:0]) begin //Rn of REGDEC matches Rd of EX
								ForwardMuxControlA[1:0] = 2'b10;
							end
						end
						11'b11111000000: begin //STUR
							if(REGDECOPCode[4:0] == MEMOPCode[4:0]) begin //Rd of REGDEC matches Rd of EX
								ForwardMuxControlB[1:0] = 2'b10;
							end							
							if(REGDECOPCode[9:5] == MEMOPCode[4:0]) begin //Rn of REGDEC matches Rd of EX
								ForwardMuxControlA[1:0] = 2'b10;
							end
						end
						11'b00111000000: begin //STURB
							if(REGDECOPCode[4:0] == MEMOPCode[4:0]) begin //Rd of REGDEC matches Rd of EX
								ForwardMuxControlB[1:0] = 2'b10;
							end							
							if(REGDECOPCode[9:5] == MEMOPCode[4:0]) begin //Rn of REGDEC matches Rd of EX
								ForwardMuxControlA[1:0] = 2'b10;
							end
						end
						11'b11101011000: begin //SUBS
							if(REGDECOPCode[9:5] == MEMOPCode[4:0]) begin //Rn of REGDEC matches Rd of EX
								ForwardMuxControlA[1:0] = 2'b10;
							end
							if(REGDECOPCode[20:16] == MEMOPCode[4:0]) begin //Rm of REGDEC matches Rd of EX
								ForwardMuxControlB[1:0] = 2'b10;
							end
						end
						default: begin //Instruction where you don't read from a register
							ForwardMuxControlA[1:0] = 2'b00;
							ForwardMuxControlB[1:0] = 2'b00;
						end 
					endcase
				end
			end
			2'b11: begin //Writing in the EX stage, and MEM
				case(REGDECOPCode) begin
					11'b10110100zzz: begin //CBZ
						if(REGDECOPCode[4:0] != 5'b11111) begin
							if(REGDECOPCode[4:0] == EXOPCode[4:0]) begin
								ForwardMuxControlB[1:0] = 2'b01;
							end 
							else if (REGDECOPCode[4:0] == MEMOPCode[4:0]) begin
								ForwardMuxControlB[1:0] = 2'b10;
							end
						end
					end
					11'b1001000100z: begin //ADDI
						if(REGDECOPCode[9:5] != 5'b11111) begin
							if(REGDECOPCode[9:5] == EXOPCode[4:0]) begin
								ForwardMuxControlA[1:0] = 2'b01;
							end 
							else if (REGDECOPCode[9:5] == MEMOPCode[4:0]) begin
								ForwardMuxControlA[1:0] = 2'b10;
							end
						end
					end
					11'b10101011000: begin //ADDS
						if(REGDECOPCode[20:16] != 5'b11111) begin
							if(REGDECOPCode[20:16] == EXOPCode[4:0]) begin
								ForwardMuxControlB[1:0] = 2'b01;
							end 
							else if (REGDECOPCode[20:16] == MEMOPCode[4:0]) begin
								ForwardMuxControlB[1:0] = 2'b10;
							end
						end
						if(REGDECOPCode[9:5] != 5'b11111) begin
							if(REGDECOPCode[9:5] == EXOPCode[4:0]) begin
								ForwardMuxControlA[1:0] = 2'b01;
							end 
							else if (REGDECOPCode[9:5] == MEMOPCode[4:0]) begin
								ForwardMuxControlA[1:0] = 2'b10;
							end
						end
					end
					11'b11111000010: begin //LDUR
						if(REGDECOPCode[9:5] != 5'b11111) begin
							if(REGDECOPCode[9:5] == EXOPCode[4:0]) begin //Rn of REGDEC matches Rd of EX
								ForwardMuxControlA[1:0] = 2'b01;
							end 
							else if(REGDECOPCode[9:5] == MEMOPCode[4:0]) begin
								ForwardMuxControlA[1:0] = 2'b10;
							end
						end
					end
					11'b00111000010: begin //LDURB
						if(REGDECOPCode[9:5] != 5'b11111) begin
							if(REGDECOPCode[9:5] == EXOPCode[4:0]) begin //Rn of REGDEC matches Rd of EX
								ForwardMuxControlA[1:0] = 2'b01;
							end 
							else if(REGDECOPCode[9:5] == MEMOPCode[4:0]) begin
								ForwardMuxControlA[1:0] = 2'b10;
							end
						end
					end
					11'b11111000000: begin //STUR
						if(REGDECOPCode[4:0] != 5'b11111) begin
							if(REGDECOPCode[4:0] == EXOPCode[4:0]) begin
								ForwardMuxControlB[1:0] = 2'b01;
							end 
							else if (REGDECOPCode[4:0] == MEMOPCode[4:0]) begin
								ForwardMuxControlB[1:0] = 2'b10;
							end
						end
						if(REGDECOPCode[9:5] != 5'b11111) begin
							if(REGDECOPCode[9:5] == EXOPCode[4:0]) begin
								ForwardMuxControlA[1:0] = 2'b01;
							end 
							else if (REGDECOPCode[9:5] == MEMOPCode[4:0]) begin
								ForwardMuxControlA[1:0] = 2'b10;
							end
						end
					end
					11'b00111000000: begin //STURB
						if(REGDECOPCode[4:0] != 5'b11111) begin
							if(REGDECOPCode[4:0] == EXOPCode[4:0]) begin
								ForwardMuxControlB[1:0] = 2'b01;
							end 
							else if (REGDECOPCode[4:0] == MEMOPCode[4:0]) begin
								ForwardMuxControlB[1:0] = 2'b10;
							end
						end
						if(REGDECOPCode[9:5] != 5'b11111) begin
							if(REGDECOPCode[9:5] == EXOPCode[4:0]) begin
								ForwardMuxControlA[1:0] = 2'b01;
							end 
							else if (REGDECOPCode[9:5] == MEMOPCode[4:0]) begin
								ForwardMuxControlA[1:0] = 2'b10;
							end
						end
					end
					11'b11101011000: begin //SUBS
						if(REGDECOPCode[20:16] != 5'b11111) begin
							if(REGDECOPCode[20:16] == EXOPCode[4:0]) begin
								ForwardMuxControlB[1:0] = 2'b01;
							end 
							else if (REGDECOPCode[20:16] == MEMOPCode[4:0]) begin
								ForwardMuxControlB[1:0] = 2'b10;
							end
						end
						if(REGDECOPCode[9:5] != 5'b11111) begin
							if(REGDECOPCode[9:5] == EXOPCode[4:0]) begin
								ForwardMuxControlA[1:0] = 2'b01;
							end 
							else if (REGDECOPCode[9:5] == MEMOPCode[4:0]) begin
								ForwardMuxControlA[1:0] = 2'b10;
							end
						end
					end
					default: begin //Instruction where you don't read from a register
						ForwardMuxControlA[1:0] = 2'b00;
						ForwardMuxControlB[1:0] = 2'b00;
					end 
				endcase
			end
			default: begin //Neither stage has a write enable
				ForwardMuxControlA[1:0] = 2'b00;
				ForwardMuxControlB[1:0] = 2'b00;
			end
		endcase
	end
end

