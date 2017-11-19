`timescale 1ns/10ps
module EX (ALUOut, Db, OPCode, MemWrite, MOVZ, MOVK, LDURB, Mem2Reg, RegWrite, read_enable, xfer_size, negative, overflow,
		   clk, reset, ALUCntrlIn, MemWriteIn, MOVZIn, MOVKIn, LDURBIn, Mem2RegIn, RegWriteIn, read_enableIn,
		   xfer_sizeIn, NOOPIn, ALUA, ALUB, DbIn, OPCodeIn);
	output logic [63:0] ALUOut, Db;
	output logic [31:0] OPCode;
	output logic MemWrite, MOVZ, MOVK, LDURB, Mem2Reg, RegWrite, read_enable, negative, overflow;
	output logic [3:0] xfer_size;
	input logic clk, reset, MemWriteIn, MOVZIn, MOVKIn, LDURBIn, Mem2RegIn, RegWriteIn, read_enableIn, NOOPIn;
	input logic [3:0] xfer_sizeIn;
	input logic [2:0] ALUCntrlIn;
	input logic [63:0] ALUA, ALUB, DbIn;
	input logic [31:0] OPCodeIn;

	logic negativeFromALU, overflowFromALU, zeroFromALU, carryOutFromALU, carryOutFromFlag, zeroFromFlag, overFlowFromFlag, negativeFromFlag;
	logic [63:0] resultToNextStage;

	alu ahloo (.A(ALUA), .B(ALUB), .cntrl(ALUCntrlIn), .result(resultToNextStage), .negative(negativeFromALU), .zero(zeroFromALU), 
				.overflow(overflowFromALU), .carry_out(carryOutFromALU));
	flags flagRegister (.in({negativeFromALU, zeroFromALU, overflowFromALU, carryOutFromALU}),
						.out({negativeFromFlag, zeroFromFlag, overFlowFromFlag, carryOutFromFlag}), .clk, .reset, .enable(~NOOPIn));
	assign negative = flagRegister.eachFF[3].flipFlop.intoTheDFF;
	assign overflow = flagRegister.eachFF[1].flipFlop.intoTheDFF;

	register #(.WIDTH(64)) ALUOutReg (.dataOut(ALUOut), .dataIn(resultToNextStage), .enable(1'b1), .clk, .reset); //send ALU result
	register #(.WIDTH(64)) DbReg (.dataOut(Db), .dataIn(DbIn), .enable(1'b1), .clk, .reset); //send Db
	register #(.WIDTH(32)) OPCodeReg (.dataOut(OPCode), .dataIn(OPCodeIn), .enable(1'b1), .clk, .reset); //send OPCode
	register #(.WIDTH(11)) ControlReg (.dataOut({MemWrite, MOVZ, MOVK, LDURB, Mem2Reg, RegWrite, read_enable, xfer_size}),
									 .dataIn({MemWriteIn, MOVZIn, MOVKIn, LDURBIn, Mem2RegIn, RegWriteIn, read_enableIn, xfer_sizeIn}),
									 .enable(1'b1), .clk, .reset); //send control logic
endmodule

module EX_testbench();
	logic [63:0] ALUOut, Db;
	logic [31:0] OPCode;
	logic MemWrite, MOVZ, MOVK, LDURB, Mem2Reg, RegWrite, read_enable, negative, overflow;
	logic [3:0] xfer_size;
	logic clk, reset, MemWriteIn, MOVZIn, MOVKIn, LDURBIn, Mem2RegIn, RegWriteIn, read_enableIn, NOOPIn;
	logic [3:0] xfer_sizeIn;
	logic [2:0] ALUCntrlIn;
	logic [63:0] ALUA, ALUB, DbIn;
	logic [31:0] OPCodeIn;

	EX dut (.ALUOut, .Db, .OPCode, .MemWrite, .MOVZ, .MOVK, .LDURB, .Mem2Reg, .RegWrite, .read_enable, .xfer_size, .negative, .overflow,
		   .clk, .reset, .ALUCntrlIn, .MemWriteIn, .MOVZIn, .MOVKIn, .LDURBIn, .Mem2RegIn, .RegWriteIn, .read_enableIn,
		   .xfer_sizeIn, .NOOPIn, .ALUA, .ALUB, .DbIn, .OPCodeIn);
	parameter CLOCK_PERIOD=200;
	initial begin
	clk <= 0;
	forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	initial begin
		reset <= 1'b1;
		@(posedge clk);
		reset <= 1'b0;
		MemWriteIn <= 1'b1;
		MOVZIn <= 1'b1;
		MOVKIn <= 1'b0;
		LDURBIn <= 1'b1;
		Mem2RegIn <= 1'b1;
		RegWriteIn <= 1'b0;
		read_enableIn <= 1'b1;
		NOOPIn <= 1'b1;
		xfer_sizeIn[3:0] <= 4'b0001;
		ALUCntrlIn[2:0] <= 3'b000; //should just pass through 133
		ALUA[63:0] <= 64'd13;
		ALUB[63:0] <= 64'd133;
		DbIn[63:0] <= 64'd4332;
		OPCodeIn[31:0] <= 32'd213214;
		@(posedge clk);
		NOOPIn <= 1'b0;
		ALUCntrlIn[2:0] <= 3'b011;
		@(posedge clk); //should set negative flags immediately
		@(posedge clk);
		$stop;
	end
endmodule