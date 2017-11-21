`timescale 1ns/10ps
module PipelinedProcessor (clk, reset);
	input logic clk, reset;
	logic[31:0] IFETCHOPCode, EXOPCode, MEMOPCode;
	logic CntrlUncondBr, CntrlBrTaken, CntrlReg2Loc, CntrlMem2Reg, CntrlRegWrite, CntrlMemWrite, CntrlLDURB, Cntrlread_enable, CntrlMOVZ, CntrlMOVK, CntrlNOOP;
	logic Cntrlzero, Cntrloverflow, Cntrlnegative;
	logic[3:0] Cntrlxfer_size;
	logic[1:0] CntrlALUSrc;
	logic[2:0] CntrlALUCntrl;
	logic[63:0] ALUInputA, ALUInputB, DbFromRegFile;
	
	logic EXMem2Reg, EXRegWrite, EXMemWrite, EXLDURB, EXread_enable, EXMOVZ, EXMOVK, EXNOOP;
	logic[3:0] EXxfer_size;
	logic[1:0] EXALUSrc;
	logic[2:0] EXALUCntrl;
	logic[63:0] EXOut, DbFromEX;

	logic[4:0] RdFromMem;
	logic[63:0] DwFromMem, MEMForwardData;
	logic MEMMemWrite, MEMMOVZ, MEMMOVK, MEMLDURB, MEMMem2Reg, MEMRegWrite, MEMread_enable; 
	logic[3:0] MEMxfer_size;
	logic REGDECRegWrite;

	logic[1:0] ForwardMuxControlA, ForwardMuxControlB;

	IFETCH fetcher (.OPCode(IFETCHOPCode), .clk, .reset, .UncondBr(CntrlUncondBr), .BrTaken(CntrlBrTaken));
	
	REGDEC registers (.ALUCntrl(EXALUCntrl), .MemWrite(EXMemWrite), .MOVZ(EXMOVZ), .MOVK(EXMOVK), .LDURB(EXLDURB), .Mem2Reg(EXMem2Reg), 
					  .read_enable(EXread_enable), .xfer_size(EXxfer_size), .RegWrite(EXRegWrite), .NOOP(EXNOOP), .ALUA(ALUInputA), .ALUB(ALUInputB),
		   			  .OPCode(EXOPCode), .Db(DbFromRegFile), .zero(Cntrlzero), .ALUSrc(CntrlALUSrc), .Reg2Loc(CntrlReg2Loc), .OPCodeIn(IFETCHOPCode), 
		   			  .ExForward(execution.MOVMuxOut), .MemForward(MEMForwardData), .WritetoReg(DwFromMem), .ForwardMuxA(ForwardMuxControlA), 
		   			  .ForwardMuxB(ForwardMuxControlB), .clk, .reset, .MemWriteIn(CntrlMemWrite), .MOVZIn(CntrlMOVZ), .MOVKIn(CntrlMOVK), .LDURBIn(CntrlLDURB), 
		   			  .Mem2RegIn(CntrlMem2Reg), .RegWriteIn(CntrlRegWrite), .ALUCntrlIn(CntrlALUCntrl), .xfer_sizeIn(Cntrlxfer_size), .read_enableIn(Cntrlread_enable), 
		   			  .NOOPIn(CntrlNOOP), .Rd(RdFromMem), .RegWriteFromMem(REGDECRegWrite));
	
	EX execution (.EXOut, .Db(DbFromEX), .OPCode(MEMOPCode), .MemWrite(MEMMemWrite), .MOVZ(MEMMOVZ), .MOVK(MEMMOVK), .LDURB(MEMLDURB), .Mem2Reg(MEMMem2Reg), 
				  .RegWrite(MEMRegWrite), .read_enable(MEMread_enable), .xfer_size(MEMxfer_size), .negative(Cntrlnegative), .overflow(Cntrloverflow),
	   			  .clk, .reset, .ALUCntrlIn(EXALUCntrl), .MemWriteIn(EXMemWrite), .MOVZIn(EXMOVZ), .MOVKIn(EXMOVK), .LDURBIn(EXLDURB), 
	   			  .Mem2RegIn(EXMem2Reg), .RegWriteIn(EXRegWrite), .read_enableIn(EXread_enable), .xfer_sizeIn(EXxfer_size), .NOOPIn(EXNOOP), .ALUA(ALUInputA), 
	   			  .ALUB(ALUInputB), .DbIn(DbFromRegFile), .OPCodeIn(EXOPCode));
	
	MEM memory (.Dw(DwFromMem), .MemForward(MEMForwardData), .RegWrite(REGDECRegWrite), .Rd(RdFromMem), .OPCodeIn(MEMOPCode), .EXOut, .DbIn(DbFromEX), .MemWriteIn(MEMMemWrite), 
			    .MOVZIn(MEMMOVZ), .MOVKIn(MEMMOVK), .LDURBIn(MEMLDURB), .Mem2RegIn(MEMMem2Reg), .RegWriteIn(MEMRegWrite), .read_enableIn(MEMread_enable), 
				.xfer_sizeIn(MEMxfer_size), .clk, .reset);

	CPUControl controller (.Reg2Loc(CntrlReg2Loc), .ALUSrc(CntrlALUSrc), .MemtoReg(CntrlMem2Reg), .RegWrite(CntrlRegWrite), 
						   .MemWrite(CntrlMemWrite), .BrTaken(CntrlBrTaken), .UncondBr(CntrlUncondBr), .LDURB(CntrlLDURB), 
						   .xfer_size(Cntrlxfer_size), .read_enable(Cntrlread_enable), .MOVZ(CntrlMOVZ), .MOVK(CntrlMOVK), .ALUCntrl(CntrlALUCntrl), 
						   .OPCode(IFETCHOPCode), .zero(Cntrlzero), .negative(Cntrlnegative), .overflow(Cntrloverflow), .NOOP(CntrlNOOP));
	
	forwardingUnit forwarding (.ForwardMuxControlA, .ForwardMuxControlB, .REGDECOPCode(IFETCHOPCode), .EXOPWriteReg(EXOPCode[4:0]), 
							   .MEMOPWriteReg(MEMOPCode[4:0]), .RdOrRm(registers.Reg2LocMuxOut), .Rn(IFETCHOPCode[9:5]), .EXRegWrite(EXRegWrite), .MEMRegWrite);
endmodule

module PipelinedProcessor_testbench();
	logic clk, reset;
	PipelinedProcessor dut(.clk, .reset);
	parameter ClockDelay = 500;
	integer i;
	initial begin // Set up the clock
		clk <= 0;
		forever #(ClockDelay/2) clk <= ~clk;
	end
	initial begin
		reset <= 1;
		@(posedge clk);
		reset <= 0;
		@(posedge clk);
		while(dut.MEMOPCode[31:0] != 32'b00010100000000000000000000000000) begin
			@(posedge clk);
		end
		$display("end reached at: %d", $time * 1000);
		@(posedge clk);
		@(posedge clk);
		$stop;
	end
endmodule