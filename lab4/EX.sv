module EX (ALUOut, Db, OPCode, MemWrite, MOVZ, MOVK, STURB, Mem2Reg, RegWrite, read_enable, xfer_size, negative, overflow,
		   clk, reset, ALUCntrlIn, MemWriteIn, MOVZIn, MOVKIn, STURBIn, Mem2RegIn, RegWriteIn, read_enableIn,
		   xfer_sizeIn, NOOPIn, ALUA, ALUB, DbIn, OPCodeIn);
	output logic [63:0] ALUOut, Db;
	output logic [31:0] OPCode;
	output logic MemWrite, MOVZ, MOVK, STURB, Mem2Reg, RegWrite, read_enable, negative, zero;
	output logic [3:0] xfer_size;
	input logic clk, reset, MemWriteIn, MOVZIn, MOVKIn, STURBIn, Mem2RegIn, RegWriteIn, read_enableIn, NOOPIn;
	input logic [3:0] xfer_sizeIn
	input logic [2:0] ALUCntrlIn;
	input logic [63:0] ALUA, ALUB, DbIn;
	input logic [31:0] OPCodeIn;

	logic negativeFromALU, overflowFromALU, zeroFromALU, carryOutFromALU, carryOutFromFlag, zeroFromFlag;
	logic [63:0] resultToNextStage;

	alu ahloo (.A(ALUA), .B(ALUB), .cntrl(ALUCntrlIn), .result(resultToNextStage), .negative(negativeFromALU), .zero(zeroFromALU), 
				.overflow(overflowFromALU), .carry_out(carryOutFromALU));
	flags flagRegister (.in({negativeFromALU, zeroFromALU, overflowFromALU, carryOutFromALU}),
						.out({negative, zeroFromFlag, overflow, carryOutFromFlag}), .clk, .reset, .enable(~NOOP));
	assign negative = flagReg.eachFF[3].flipFlop.intoTheDFF;
	assign overflow = flagReg.eachFF[1].flipFlop.intoTheDFF;

	register #(.WIDTH(64)) ALUOutReg (.dataOut(ALUOut), .dataIn(resultToNextStage), .enable(1'b1), .clk, .reset); //send ALU result
	register #(.WIDTH(64)) DbReg (.dataOut(Db), .dataIn(DbIn), .enable(1'b1), .clk, .reset); //send Db
	register #(.WIDTH(32)) OPCodeReg (.dataOut(OPCode), .dataIn(OPCodeIn), .enable(1'b1), .clk, .reset); //send OPCode
	register #(.WIDTH(11)) ControlReg (.dataOut({MemWrite, MOVZ, MOVK, STURB, Mem2Reg, RegWrite, read_enable, xfer_size})
									 .dataIn({MemWriteIn, MOVZIn, MOVKIn, STURBIn, Mem2RegIn, RegWriteIn, read_enableIn, xfer_sizeIn})
									 .enable(1'b1), .clk, .reset); //send control logic
endmodule
