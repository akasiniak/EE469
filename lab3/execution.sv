module execution(zero, negative, carryOut, overflow, OPCode, Reg2Loc, MemWrite, LDURB, Mem2Reg, MOVZ, MOVK, 
				RegWrite, ALUSrc, ALUCntrl, xfer_size, clk, reset);
	parameter DELAY = 0.05;	
	input logic [31:0] OPCode;
	input logic Reg2Loc, MemWrite, LDURB, Mem2Reg, MOVZ, MOVK, RegWrite, clk, reset; // Will need to add separate read_enable signal if setting it to ~MemWrite doesn't work
	input logic [1:0] ALUSrc;
	input logic [2:0] ALUCntrl;
	input logic [3:0] xfer_size;
 	output logic zero, negative, carryOut, overflow;

	logic [63:0] Da, Db, Daddr9SE, Imm12SE, ALUSrcMuxOut, ALUOut, MemOut,LDURBzp, LDURBMuxOut, Mem2RegMuxOut, 
				MOVResult, MOVMuxOut;
	logic [4:0] Reg2LocMuxOut;
	logic negFlag, overFlag, carryFlag, MOVANDOut;

	// Regfile
	regfile registers (
			.ReadData1(Da), 
			.ReadData2(Db), 
			.WriteData(MOVMuxOut), 
			.WriteRegister(OPCode[4:0]),	// Rd
			.RegWrite(RegWrite), 
			.ReadRegister1(OPCode[9:5]),	// Rn
			.ReadRegister2(Reg2LocMuxOut), 
			.clk);
	
	// ALU 
	alu comp (
			.A(Da), 
			.B(ALUSrcMuxOut), 
			.cntrl(ALUCntrl), 
			.result(ALUOut), 
			.negative(negFlag), 
			.zero(zero), 
			.overflow(overFlag), 
			.carry_out(carryFlag));

	// Flag register NOTE: zero flag does not need to be stored, goes immediately to CPUControl
	flags flagReg (.in({carryFlag, overFlag, negFlag}), .out({carryOut, overflow, negative}), .clk, .reset);
	
	// Data Memory
	datamem memory (
			.address(ALUOut), 
			.write_enable(MemWrite), 
			.read_enable(~MemWrite), 
			.write_data(Db), 
			.clk, 
			.xfer_size, 
			.read_data(MemOut));
	
	// MOV Unit
	MOVUnit MOVCommand (
			.result(MOVResult), 
			.IMM16(OPCode[20:5]), 
			.Rd(Db), 
			.MOVZ(MOVZ), 
			.SHAMT(OPCode[22:21]));

	//signExtendUnits
	signExtend #(.WIDTH(9)) Daddr9(.out(Daddr9SE), .in(OPCode[23:5]));
	signExtend #(.WIDTH(12)) Imm12(.out(IMM12SE), .in(OPCode[21:10]));

	// Zero pad for LDRUB
	zeroPad #(.WIDTH(xfer_size*8)) LDURBZPad(.out(LDURBzp), .in(MemOut));

	// AND gate for MOVZ and MOVK signal
	and #DELAY movAND(MOVANDOut, MOVZ, MOVK);


	genvar i,j;
	generate
		for(i = 0; i < 4; i++) begin: eachRegMux
			mux2to1 Reg2Mux(.out(Reg2LocMuxOut[i]), .in({OPCode[i+16], OPCode[i]}), .select(Reg2Loc)); // Rm and Rd
		end
		for(j = 0; j < 64; j++) begin: eachMux
			mux4to1 ALUSrcMux(.out(ALUSrcMuxOut[j]), .select(ALUSrc), .muxIn({1'bX, Imm12SE[j], Daddr9SE[j], Db[j]})); //how to do x???
			mux2to1 LDURBMux(.out(LDURBMuxOut[j]), .in({LDURBzp[j], MemOut[j]}));
			mux2to1 Mem2RegMux(.out(Mem2RegMuxOut[j]), .in({LDURBMuxOut[j], ALUOut[j]}), .select(Mem2Reg));
			mux2to1 MOVMux(.out(MOVMuxOut[j]), .in({MOVResult[j], Mem2RegMuxOut[j]}), .select(MOVANDOut));
		end
	endgenerate
endmodule // execution

module execution_testbench;
	logic [31:0] OPCode;
	logic Reg2Loc, Mem2Reg, LDURB, MOVZ, MOVK, MemWrite, ALUSrc, RegWrite, read_enable, clk, reset;
	logic [2:0] ALUCntrl;
	logic [3:0] xfer_size;
 	logic zero, negative, carryOut, overflow;

	logic [63:0] ALUSrcMuxOut, STURBMuxOut, Mem2RegMuxOut, LDURBMuxOut, MOVMuxOut, ALUOut, Da, Db, MemOut, MOVResult,
				Daddr9SE, Imm12SE, LDURBzp;
	logic [4:0] Reg2LocMuxOut;
	logic negFlag, overFlag, carryFlag, MOVandOut;



