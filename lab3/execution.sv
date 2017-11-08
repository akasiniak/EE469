module execution();
	input logic [31:0] OPCode;
	input logic Reg2Loc, Mem2Reg, LDURB, STURB, MOVZ, MOVK, MemWrite, ALUSrc, RegWrite, clk, reset;
	input logic [2:0] ALUCntrl;
 	output logic zero, negative, carryOut, overflow;

	logic [63:0] ALUSrcMuxOut, STURBMuxOut, Mem2RegMuxOut, LDURBMuxOut, MOVMuxOut, ALUOut, Da, Db, MemOut, MOVResult
	Daddr9SE, Imm12SE;
	logic [4:0] Reg2MuxOut;
	logic negFlag, overFlag, carryFlag;

	regfile registers (
			.ReadData1(Da), 
			.ReadData2(Db), 
			.WriteData(MOVMuxOut), 
			.WriteRegister(OPCode[4:0]), 
			.RegWrite(RegWrite), 
			.ReadRegister1(OPCode[9:5]), 
			.ReadRegister2(Reg2MuxOut), 
			.clk);
	
	alu comp (
			.A(Da), 
			.B(ALUSrcMuxOut), 
			.cntrl(ALUCntrl), 
			.result(ALUOut), 
			.negative(negFlag), 
			.zero(zero), 
			.overflow(overFlag), 
			.carry_out(carryFlag));
	
	//need to figure out what the xfer_size is
	datamem memory (.address(ALUOut), 
					.write_enable(MemWrite), 
					.read_enable(1), 
					.write_data(STURBMuxOut), 
					.clk, 
					.xfer_size, 
					.read_data(MemOut));
	
	//need to figure out OPCode for IMM16 and SHAMT
	MOVUnit MOVCommand (.result(MOVResult), 
						.IMM16(OPCode[]), 
						.Rd(Db), 
						.MOVZ(MOVZ), 
						.SHAMT(OPCode[]));

	//signExtendUnits
	signExtend #(.WIDTH(9)) Daddr9(.out(Daddr9SE), .in(OPCode[23:5]));
	signExtend #(.WIDTH(12)) Imm12(.out(IMM12SE), .in(OPCode[21:10]));

	
