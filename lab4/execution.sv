`timescale 1ns/10ps
module execution(zeroOut, negative, carryOut, overflow, OPCode, Reg2Loc, MemWrite, LDURB, MemtoReg, MOVZ, MOVK, 
				RegWrite, ALUSrc, ALUCntrl, xfer_size, clk, reset, read_enable, NOOP);
	parameter DELAY = 0.05;	
	input logic [31:0] OPCode;
	input logic Reg2Loc, read_enable, MemWrite, LDURB, MemtoReg, MOVZ, MOVK, RegWrite, clk, reset, NOOP; // Will need to add separate read_enable signal if setting it to ~MemWrite doesn't work
	input logic [1:0] ALUSrc;
	input logic [2:0] ALUCntrl;
	input logic [3:0] xfer_size;
 	output logic zeroOut, negative, carryOut, overflow;

	logic [63:0] Da, Db, Daddr9SE, Imm12SE, ALUSrcMuxOut, ALUOut, MemOut,LDURBzp, LDURBMuxOut, MemtoRegMuxOut, 
				MOVResult, MOVMuxOut;
	logic [4:0] Reg2LocMuxOut;
	logic negFlag, overFlag, carryFlag, MOVOROut, zero, zeroFlag;
	assign zeroOut = flagReg.eachFF[0].flipFlop.intoTheDFF;

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
			.zero(zeroFlag), 
			.overflow(overFlag), 
			.carry_out(carryFlag));

	// Flag register NOTE: zero flag does not need to be stored, goes immediately to CPUControl
	flags flagReg (.in({carryFlag, overFlag, negFlag, zeroFlag}), .out({carryOut, overflow, negative, zero}), .clk, .reset, .enable(~NOOP));
	
	// Data Memory
	datamem memory (
			.address(ALUOut), 
			.write_enable(MemWrite), 
			.read_enable, 
			.write_data(Db), 
			.clk, 
			.xfer_size, 
			.read_data(MemOut));
	
	// MOV Unit
	MOVUNIT MOVCommand (
			.result(MOVResult), 
			.IMM16(OPCode[20:5]), 
			.Rd(Db), 
			.MOVZ(MOVZ), 
			.SHAMT(OPCode[22:21]));

	//signExtendUnits
	signExtend #(.WIDTH(9)) Daddr9(.out(Daddr9SE), .in(OPCode[20:12]));
	zeroPad #(.WIDTH(12)) Imm12(.out(Imm12SE), .in(OPCode[21:10]));

	// Zero pad for LDRUB
	zeroPad #(.WIDTH(8)) LDURBZPad(.out(LDURBzp), .in(MemOut[7:0]));

	// OR gate for MOVZ and MOVK signal
	or #DELAY movOR(MOVOROut, MOVZ, MOVK);


	genvar i,j;
	generate
		for(i = 0; i < 5; i++) begin: eachRegMux
			mux2to1 Reg2Mux(.out(Reg2LocMuxOut[i]), .in({OPCode[i+16], OPCode[i]}), .select(Reg2Loc)); // Rm and Rd
		end
		for(j = 0; j < 64; j++) begin: eachMux
			mux4to1 ALUSrcMux(.out(ALUSrcMuxOut[j]), .select(ALUSrc), .muxIn({1'bz, Imm12SE[j], Daddr9SE[j], Db[j]}));
			mux2to1 LDURBMux(.out(LDURBMuxOut[j]), .in({LDURBzp[j], MemOut[j]}), .select(LDURB));
			mux2to1 MemtoRegMux(.out(MemtoRegMuxOut[j]), .in({LDURBMuxOut[j], ALUOut[j]}), .select(MemtoReg));
			mux2to1 MOVMux(.out(MOVMuxOut[j]), .in({MOVResult[j], MemtoRegMuxOut[j]}), .select(MOVOROut));
		end
	endgenerate
endmodule // execution

module execution_testbench;
	parameter ClockDelay = 100;
	logic [31:0] OPCode;
	logic Reg2Loc, MemWrite, LDURB, MemtoReg, MOVZ, MOVK, RegWrite, clk, reset, read_enable; // Will need to add separate read_enable signal if setting it to ~MemWrite doesn't work
	logic [1:0] ALUSrc;
	logic [2:0] ALUCntrl;
	logic [3:0] xfer_size;
 	logic zero, negative, carryOut, overflow;

	logic [63:0] Da, Db, Daddr9SE, Imm12SE, ALUSrcMuxOut, ALUOut, MemOut,LDURBzp, LDURBMuxOut, MemtoRegMuxOut, 
				MOVResult, MOVMuxOut;
	logic [4:0] Reg2LocMuxOut;
	logic negFlag, overFlag, carryFlag, MOVOROut;

	logic  BrTaken, UncondBr; // Will need to add separate read_enable signal if setting it to ~MemWrite doesn't work

	execution dut(.zero, .negative, .carryOut, .overflow, .OPCode, .Reg2Loc, .MemWrite, .LDURB, .MemtoReg, .MOVZ, 
		.MOVK, .RegWrite, .ALUSrc, .ALUCntrl, .xfer_size, .clk, .reset, .read_enable);

	CPUControl cpu(.Reg2Loc, .ALUSrc, .MemtoReg, .RegWrite, .MemWrite, .BrTaken, .UncondBr, .LDURB, .xfer_size,
					.MOVZ, .MOVK, .ALUCntrl, .OPCode, .zero, .negative, .overflow, .read_enable);

	initial begin // Set up the clock
		clk <= 0;
		forever #(ClockDelay/2) clk <= ~clk;
	end

	initial begin

		reset = 1'b1;
		@(posedge clk)
		reset = 1'b0;
		@(posedge clk)
		OPCode[31:21] = 11'b10110100101; //CBZ
		OPCode[20:0] = 21'd1311;
		$display("@%0dps instruction is CBZ", $time * 1000);
		@(posedge clk);
		OPCode[31:21] = 11'b10010001001; //ADDI
		OPCode[20:0] = 21'd1216;
		$display("@%0dps instruction is ADDI", $time * 1000);
		@(posedge clk);
		OPCode[31:21] = 11'b10001011000; //ADDS
		OPCode[20:0] = 21'd4491;
		$display("@%0dps instruction is ADDS", $time * 1000);
		@(posedge clk);
		OPCode[31:21] = 11'b11111000010; //LDUR
		OPCode[20:0] = 21'd3231;
		$display("@%0dps instruction is LDUR", $time * 1000);
		@(posedge clk);
		OPCode[31:21] = 11'b00111000010; //LDURB
		OPCode[20:0] = 21'd1774;
		$display("@%0dps instruction is LDURB", $time * 1000);
		@(posedge clk);
		OPCode[31:21] = 11'b11111000000; //STUR
		OPCode[20:0] = 21'd7936;
		$display("@%0dps instruction is STUR", $time * 1000);
		@(posedge clk);
		OPCode[31:21] = 11'b00111000000; //xfer_size
		OPCode[20:0] = 21'd8987;
		$display("@%0dps instruction is xfer_size", $time * 1000);
		@(posedge clk);
		OPCode[31:21] = 11'b11001011000; //SUBS
		OPCode[20:0] = 21'd7236;
		$display("@%0dps instruction is SUBS", $time * 1000);
		@(posedge clk);
		OPCode[31:21] = 11'b11110010110; //MOVK
		OPCode[20:0] = 21'd9234;
		$display("@%0dps instruction is MOVK", $time * 1000);
		@(posedge clk);
		OPCode[31:21] = 11'b11010010101; //MOVZ
		OPCode[20:0] = 21'd3475;
		$display("@%0dps instruction is MOVZ", $time * 1000);
		@(posedge clk);
		$stop;
	end
endmodule
