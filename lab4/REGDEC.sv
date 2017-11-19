`timescale 1ns/10ps
//This module does all of the neccessary operations of the REG/DEC stage. Selects which data to read from the RegFile, chooses what goes into the
//B port of the ALU, decides on forwarding, and sends all the control logic to the next stage.

module REGDEC (ALUCntrl, MemWrite, MOVZ, MOVK, STURB, Mem2Reg, read_enable, xfer_size, RegWrite, NOOP, ALUA, ALUB,
				OPCode, Db, zero, ALUSrc, Reg2Loc, OPCodeIn, ExForward, MemForward, WritetoReg, ForwardMuxA, ForwardMuxB, clk, reset,
				MemWriteIn, MOVZIn, MOVKIn, STURBIn, Mem2RegIn, RegWriteIn, ALUCntrlIn, xfer_sizeIn, read_enableIn, NOOPIn, Rd);
	parameter DELAY = 0.05;
	output logic [63:0] ALUA, ALUB, Db;
	output logic [31:0] OPCode;
	output logic MemWrite, MOVZ, MOVK, STURB, Mem2Reg, read_enable, NOOP, zero, RegWrite;
	output logic [3:0] xfer_size;
	output logic [2:0] ALUCntrl;
	input logic [31:0] OPCodeIn;
	input logic [63:0] ExForward, MemForward, WritetoReg;
	input logic [1:0] ALUSrc;
	input logic Reg2Loc, clk, reset;
	input logic [1:0] ForwardMuxB, ForwardMuxA;
	input logic MemWriteIn, MOVZIn, MOVKIn, STURBIn, Mem2RegIn, RegWriteIn, read_enableIn, NOOPIn;
	input logic [2:0] ALUCntrlIn;
	input logic [3:0] xfer_sizeIn;
	input logic [4:0] Rd;

	logic [63:0] ImmSE, AddrSE, Da, DbFromReg, ALUSrcMuxOut, ForwardMuxAOut, ForwardMuxBOut;
	logic [4:0] Reg2LocMuxOut;
	genvar i;

	regfile registers (.ReadData1(Da), 
					   .ReadData2(DbFromReg), 
					   .WriteData(WritetoReg), 
					   .WriteRegister(Rd),
					   .RegWrite(RegWriteIn), 
					   .ReadRegister1(OPCodeIn[9:5]), 
					   .ReadRegister2(Reg2LocMuxOut) , 
					   .clk);

	nor64to1 #DELAY zeroGate (.out(zero), .Din(DbFromReg)); //zero flag will now come from here
	signExtend #(.WIDTH(9)) Daddr9(.out(AddrSE), .in(OPCodeIn[20:12]));
	zeroPad #(.WIDTH(12)) Imm12(.out(ImmSE), .in(OPCodeIn[21:10]));
	generate
		for(i = 0; i < 5; i++) begin: eachRegMux
			mux2to1 Reg2Mux(.out(Reg2LocMuxOut[i]), .in({OPCodeIn[i+16], OPCodeIn[i]}), .select(Reg2Loc)); // Rm and Rd
		end
		for(i = 0; i < 64; i++) begin: eachMux
			mux4to1 ALUSrcMux(.out(ALUSrcMuxOut[i]), .select(ALUSrc), .muxIn({1'bz, ImmSE[i], AddrSE[i], DbFromReg[i]})); //pick what goes into forwarding mux
			mux4to1 AForwardMuxs (.out(ForwardMuxAOut[i]), .select(ForwardMuxA), .muxIn({1'bz, MemForward[i], ExForward[i], Da[i]}));
			mux4to1 BForwardMuxs (.out(ForwardMuxBOut[i]), .select(ForwardMuxB), .muxIn({1'bz, MemForward[i], ExForward[i], ALUSrcMuxOut[i]}));
		end
	endgenerate
	
	//set up register that will pass values to the next stage
	register #(.WIDTH(64)) ALUBReg (.dataOut(ALUB), .dataIn(ForwardMuxBOut), .enable(1'b1), .clk, .reset); //send ALUB
	register #(.WIDTH(64)) ALUAReg (.dataOut(ALUA), .dataIn(ForwardMuxAOut), .enable(1'b1), .clk, .reset); //send ALUA
	register #(.WIDTH(32)) OPCodeReg (.dataOut(OPCode), .dataIn(OPCodeIn), .enable(1'b1), .clk, .reset); //send OPCode
	register #(.WIDTH(64)) DbReg (.dataOut(Db), .dataIn(DbFromReg), .enable(1'b1), .clk, .reset); //send Db for writing to memory
	register #(.WIDTH(15)) ControlReg (.dataOut({ALUCntrl, MemWrite, MOVZ, MOVK, STURB, Mem2Reg, RegWrite, read_enable, xfer_size, NOOP}), 
									.dataIn({ALUCntrlIn, MemWriteIn, MOVZIn, MOVKIn, STURBIn, Mem2RegIn, RegWriteIn, read_enableIn, xfer_sizeIn, NOOPIn}), 
									.enable(1'b1), 
									.clk, 
									.reset); //send all necessary control logic
endmodule

module REGDEC_testbench();
	logic [63:0] ALUA, ALUB, Db;
	logic [31:0] OPCode;
	logic MemWrite, MOVZ, MOVK, STURB, Mem2Reg, read_enable, NOOP, zero, RegWrite;
	logic [3:0] xfer_size;
	logic [2:0] ALUCntrl;
	logic [31:0] OPCodeIn;
	logic [63:0] ExForward, MemForward, WritetoReg;
	logic [1:0] ALUSrc;
	logic Reg2Loc, clk, reset;
	logic [1:0] ForwardMuxB, ForwardMuxA;
	logic MemWriteIn, MOVZIn, MOVKIn, STURBIn, Mem2RegIn, RegWriteIn, read_enableIn, NOOPIn;
	logic [2:0] ALUCntrlIn;
	logic [3:0] xfer_sizeIn;
	logic [4:0] Rd;

	REGDEC dut (.ALUCntrl, .MemWrite, .MOVZ, .MOVK, .STURB, .Mem2Reg, .read_enable, .xfer_size, .NOOP, .ALUA, .ALUB,
		.OPCode, .Db, .zero, .ALUSrc, .Reg2Loc, .OPCodeIn, .ExForward, .MemForward, .RegWrite, .WritetoReg, .ForwardMuxA, .ForwardMuxB, .clk, .reset,
		.MemWriteIn, .MOVZIn, .MOVKIn, .STURBIn, .Mem2RegIn, .RegWriteIn, .ALUCntrlIn, .xfer_sizeIn, .read_enableIn, .NOOPIn, .Rd);
	parameter CLOCK_PERIOD=200;
	initial begin
	clk <= 0;
	forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	initial begin
		reset <= 1'b1;
		@(posedge clk);
		reset <= 1'b0;
		//write data to registers
		//X0 = 15
		//X1 = 23
		//X2 = 0
		RegWriteIn <= 1'b1;
		Rd <= 5'b00000;
		WritetoReg <= 64'd15;
		$display("writing to register X0 at %d", $time);
		@(posedge clk);
		Rd <= 5'b00001;
		WritetoReg <= 64'd23;
		$display("writing to register X1 at %d", $time);
		@(posedge clk);
		Rd <= 5'b00010;
		WritetoReg <= 64'd0;
		$display("writing to register X2 at %d", $time);
		@(posedge clk);
		//read data that was just written
		RegWriteIn <= 1'b0;
		WritetoReg <= 64'd133; //should not overwrite X2
		Reg2Loc <= 1'b1;
		OPCodeIn[31:0] = 32'b10101011000000010000000000000000; //ADDS X0, X0, X1
		$display("reading register X0 and X1 at %d", $time);
		@(posedge clk);
		OPCodeIn[31:0] = 32'b10101011000000010000000001000000;   // ADDS X5, X2, X1
		$display("reading register X2 and X1 at  %d", $time);
		@(posedge clk);
		//test ALUSrc mux
		ALUSrc[1:0] <= 2'b00; //let through Db
		$display("letting through Db %d", $time);
		@(posedge clk);
		ALUSrc[1:0] <= 2'b01; //let through Daddr9
		$display("letting through Daddr9 %d", $time);
		@(posedge clk);
		ALUSrc[1:0] <= 2'b10; //let through Imm12
		$display("letting through Imm12 %d", $time);
		@(posedge clk);
		//test forwarding muxes
		ALUSrc[1:0] <= 2'b00;
		ExForward[63:0] <= 64'd165;
		MemForward[63:0] <= 64'd2341;
		ForwardMuxA[1:0] <= 2'b00;
		ForwardMuxB[1:0] <= 2'b00;
		$display("letting through Da and Db %d", $time);
		@(posedge clk);
		ForwardMuxA[1:0] <= 2'b01;
		ForwardMuxB[1:0] <= 2'b01;
		$display("letting through ExForward and ExForward %d", $time);
		@(posedge clk);
		ForwardMuxA[1:0] <= 2'b10;
		ForwardMuxB[1:0] <= 2'b10;
		$display("letting through MemForward and MemForward %d", $time);
		@(posedge clk);
		//test the cntrl forwarding of the register
		ALUCntrlIn[2:0] <= 3'b010;
		MemWriteIn <= 1'b1;
		MOVZIn <= 1'b1;
		MOVKIn <= 1'b1;
		STURBIn <= 1'b0;
		Mem2RegIn <= 1'b1;
		read_enableIn <= 1'b0;
		xfer_sizeIn[3:0] <= 4'b0000;
		NOOPIn <= 1'b1;
		@(posedge clk);
		@(posedge clk);
		$stop;
	end
endmodule
