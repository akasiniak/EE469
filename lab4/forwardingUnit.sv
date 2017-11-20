module forwardingUnit (ForwardMuxControlA, ForwardMuxControlB, REGDECOPCode, EXOPWriteReg, MEMOPWriteReg, RdOrRm, Rn, EXRegWrite, MEMRegWrite);
	output logic [1:0] ForwardMuxControlB, ForwardMuxControlA;
	input logic [31:0] REGDECOPCode;
	input logic [4:0] MEMOPWriteReg, EXOPWriteReg, RdOrRm, Rn;
	input logic EXRegWrite, MEMRegWrite;

	//logic for ForwardMuxControlA
	always_comb begin
		if(Rn[4:0] != 5'b11111) begin
			if(REGDECOPCode[31:22] == 10'b1001000100 ||
			   REGDECOPCode[31:21] == 11'b10101011000 ||
			   REGDECOPCode[31:21] == 11'b11111000010 ||
			   REGDECOPCode[31:21] == 11'b00111000010 ||
			   REGDECOPCode[31:21] == 11'b11111000000 ||
			   REGDECOPCode[31:21] == 11'b00111000000 ||
			   REGDECOPCode[31:21] == 11'b11101011000) begin //ADDI, ADDS, LDUR, LDURB, STUR, STURB, SUBS
				if(EXOPWriteReg[4:0] == Rn[4:0]) begin //EX Rd matches REG Rn
					if(EXRegWrite) begin //EX is writing
						ForwardMuxControlA[1:0] = 2'b01;
					end
					else begin //EX is not writing
						ForwardMuxControlA[1:0] = 2'b00;
					end
				end 
				else if (MEMOPWriteReg[4:0] == Rn[4:0]) begin //MEM Rd matches REG Rn
					if(MEMRegWrite) begin//MEM is writing
						ForwardMuxControlA[1:0] = 2'b10;
					end
					else begin //MEM is not writing
						ForwardMuxControlA[1:0] = 2'b00;
					end
				end 
				else begin //Neither matches
					ForwardMuxControlA[1:0] = 2'b00;
				end
			end
			else begin //Not an instruction where we read Rn
				ForwardMuxControlA[1:0] = 2'b00;
			end
		end 
		else begin
			ForwardMuxControlA[1:0] = 2'b00;
		end 
	end
		
	//logic for ForwardMuxControlB
	always_comb begin
		if(RdOrRm[4:0] != 5'b11111) begin
			if(REGDECOPCode[31:21] == 11'b10101011000 ||
			   REGDECOPCode[31:24] == 8'b10110100 ||
			   REGDECOPCode[31:21] == 11'b11111000000 ||
			   REGDECOPCode[31:21] == 11'b00111000000 ||
			   REGDECOPCode[31:21] == 11'b11101011000 ||
			   REGDECOPCode[31:23] == 9'b111100101 ||
			   REGDECOPCode[31:23] == 9'b110100101) begin //ADDS, CBZ, STUR, STURB, SUBS, MOVK, MOVZ
				if(EXOPWriteReg[4:0] == RdOrRm[4:0]) begin //EX Rd matches REG Rn
					if(EXRegWrite) begin //EX is writing
						ForwardMuxControlB[1:0] = 2'b01;
					end
					else begin //EX is not writing
						ForwardMuxControlB[1:0] = 2'b00;
					end
				end 
				else if (MEMOPWriteReg[4:0] == RdOrRm[4:0]) begin //MEM Rd matches REG Rn
					if(MEMRegWrite) begin//MEM is writing
						ForwardMuxControlB[1:0] = 2'b10;
					end
					else begin //MEM is not writing
						ForwardMuxControlB[1:0] = 2'b00;
					end
				end 
				else begin //Neither matches
					ForwardMuxControlB[1:0] = 2'b00;
				end
			end
			else begin //Not an instruction where we read Rn
				ForwardMuxControlB[1:0] = 2'b00;
			end
		end 
		else begin
			ForwardMuxControlB[1:0] = 2'b00;
		end
	end
endmodule

module forwardingUnit_testbench();
	logic [1:0] ForwardMuxControlB, ForwardMuxControlA;
	logic [31:0] REGDECOPCode;
	logic [4:0] MEMOPWriteReg, EXOPWriteReg, RdOrRm, Rn;
	logic EXRegWrite, MEMRegWrite;

	forwardingUnit dut (.ForwardMuxControlA, .ForwardMuxControlB, .REGDECOPCode, .EXOPWriteReg, .MEMOPWriteReg, .RdOrRm, .Rn, .EXRegWrite, .MEMRegWrite);

	initial begin
		REGDECOPCode[31:21] = 11'b11101011000; //SUBS
		Rn[4:0] = 5'b11111;
		RdOrRm[4:0] = 5'b11111;
		EXOPWriteReg[4:0] = 5'b11111;
		MEMOPWriteReg[4:0] = 5'b00000;
		EXRegWrite = 1'b1;
		MEMRegWrite = 1'b1;
		$display("no forwarding %d", $time);
		#200;
		Rn[4:0] = 5'b00001;
		RdOrRm[4:0] = 5'b00001;
		$display("no forwarding %d", $time);
		#200;
		EXOPWriteReg[4:0] = 5'b00001;
		$display("forwarding from EX at %d", $time);
		#200;
		EXOPWriteReg[4:0] = 5'b01000;
		MEMOPWriteReg[4:0] = 5'b00001;
		$display("forwarding from MEM at %d", $time);
		#200;
		EXRegWrite = 1'b0;
		$display("forwarding from MEM %d", $time);
		#200;
		MEMOPWriteReg[4:0] = 5'b01000;
		$display("no forwarding at %d", $time);
		#200;
		EXRegWrite = 1'b1;
		MEMRegWrite = 1'b0;
		EXOPWriteReg[4:0] = 5'b00010;
		$display("no forwarding at %d", $time);
		#200;
		EXOPWriteReg[4:0] = 5'b00001;
		$display("forwarding from EX %d", $time);
		#200;
	end
endmodule