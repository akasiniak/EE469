`timescale 1ns/10ps
//This module does all of the neccessary operations of the MEM stage. Selects which data to read from the RegFile, chooses what goes into the
//B port of the ALU, decides on forwarding, and sends all the control logic to the next stage.

module MEM (Dw, MemForward, RegWrite, Rd, OPCodeIn, ALUOut, DbIn, MemWriteIn, MOVZIn, MOVKIn, LDURBIn, Mem2RegIn, RegWriteIn, read_enableIn, 
			xfer_sizeIn, clk, reset);
	parameter DELAY = 0.05;
	output logic [63:0] Dw, MemForward;
	output logic RegWrite;
	output logic [4:0] Rd;
	input logic [31:0] OPCodeIn;
	input logic [63:0] ALUOut, DbIn;
	input logic clk, reset;
	input logic MemWriteIn, MOVZIn, MOVKIn, LDURBIn, Mem2RegIn, RegWriteIn, read_enableIn;
	input logic [3:0] xfer_sizeIn;

	logic [63:0] MemOut, MemOutZP, LDURBMuxOut, Mem2RegMuxOut, MOVResult;
	logic MOVOROut;

	// Data Memory
	datamem memory (
			.address(ALUOut), 
			.write_enable(MemWriteIn), 
			.read_enable(read_enableIn), 
			.write_data(DbIn), 
			.clk, 
			.xfer_size(xfer_sizeIn), 
			.read_data(MemOut));

	// MOV Unit
	MOVUNIT MOVCommand (
			.result(MOVResult), 
			.IMM16(OPCodeIn[20:5]), 
			.Rd(DbIn), 
			.MOVZ(MOVZIn), 
			.SHAMT(OPCodeIn[22:21]));

	// Zero pad for LDRUB
	zeroPad #(.WIDTH(8)) LDURBZPad(.out(MemOutZP), .in(MemOut[7:0]));

	// OR gate for MOVZ and MOVK signal
	or #DELAY movOR(MOVOROut, MOVZ, MOVK);

	assign MemForward = LDURBMuxOut;

	genvar i;
	generate
		for(i = 0; i < 64; i++) begin: eachMux
			mux2to1 LDURBMux(.out(LDURBMuxOut[i]), .in({MemOutZP[i], MemOut[i]}), .select(LDURB));
			mux2to1 MemtoRegMux(.out(Mem2RegMuxOut[i]), .in({LDURBMuxOut[i], ALUOut[i]}), .select(Mem2Reg));
			mux2to1 MOVMux(.out(Dw[i]), .in({MOVResult[i], Mem2RegMuxOut[i]}), .select(MOVOROut));
		end
	endgenerate

	//set up register that will pass values to the next stage
	register #(.WIDTH(5)) RdReg (.dataOut(Rd), .dataIn(OPCodeIn[4:0]), .enable(1'b1), .clk, .reset); //send Rd
	register #(.WIDTH(64)) DwReg (.dataOut(Dw), .dataIn(MOVMuxOut), .enable(1'b1), .clk, .reset); // send Dw for writing to regfile
	register #(.WIDTH(1)) ControlReg (.dataOut(RegWrite), .dataIn(RegWriteIn), .enable(1'b1), .clk, .reset); //send all necessary control logic

endmodule // MEM

module MEM_testbench();
	logic [63:0] Dw, MemForward;
	logic RegWrite;
	logic [4:0] Rd;
	logic [31:0] OPCodeIn;
	logic [63:0] ALUOut, DbIn;
	logic clk, reset;
	logic MemWriteIn, MOVZIn, MOVKIn, LDURBIn, Mem2RegIn, RegWriteIn, read_enableIn;
	logic [3:0] xfer_sizeIn;

	MEM dut (.Dw, .MemForward, .RegWrite, .Rd, .OPCodeIn, .ALUOut, .DbIn, .MemWriteIn, .MOVZIn, .MOVKIn, .LDURBIn, .Mem2RegIn, .RegWriteIn, 
			.read_enableIn, .xfer_sizeIn, .clk, .reset);

	parameter CLOCK_PERIOD=200;
	initial begin
	clk <= 0;
	forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	initial begin
		reset <= 1'b1;
		@(posedge clk);
		reset <= 1'b0;
		// Write to memory
		OPCodeIn[31:0] <= 32'b11111000000_000000000_00_00000_00001; //STUR X1, [X0, #0]
		ALUOut[63:0] <= 64'd100; // Address 100
		DbIn[63:0] <= 64'd1024;
		MemWriteIn <= 1'b1;
		MOVZIn <= 1'b0;
		MOVKIn <= 1'b0;
		LDURBIn <= 1'b0;
		Mem2RegIn <= 1'b0;
		RegWriteIn <= 1'b0;
		read_enableIn <= 1'b0;
		xfer_sizeIn[3:0] <= 4'd8;
		$display("writing to memory address 100 at %d", $time);
		@(posedge clk);
		ALUOut[63:0] <= 64'd101; // Address 101
		$display("writing to memory address 150 at %d", $time);
		@(posedge clk);
		ALUOut[63:0] <= 64'd1022; // Address 1022
		$display("writing to memory address 1000 at %d", $time);
		@(posedge clk);
		ALUOut[63:0] <= 64'd1023; // Address 1023
		$display("writing to memory address 1023 at %d", $time);
		@(posedge clk);
		ALUOut[63:0] <= 64'd101; // Address 101
		DbIn[63:0] <= 64'd2; // 2
		$display("writing to memory address 101 at %d", $time);
		@(posedge clk);
		// Read data that was just written
		MemWriteIn <= 1'b0;
		ALUOut[63:0] <= 64'd97; // Address 97
		read_enableIn <= 1'b1;
		Mem2RegIn <= 1'b1;
		LDURBIn <= 1'b1;
		OPCodeIn[31:0] = 32'b00111000010_000000000_00_00000_00001;	// LDURB X1, [X0, #0]
		$display("reading memory address 97 at %d", $time);
		@(posedge clk);
		@(posedge clk);
		ALUOut[63:0] <= 64'd96; // Address 101
		$display("reading memory address 96 at %d", $time);
		@(posedge clk);
		@(posedge clk);
		// Test muxes
		LDURBIn <= 1'b0; // let through data no ZP
		$display("letting through MemOut %d", $time);
		@(posedge clk);
		LDURBIn <= 1'b1; // let through data with ZP
		$display("letting through MemOutZP %d", $time);
		@(posedge clk);
		Mem2RegIn <= 1'b0; // let through ALUOut
		$display("letting through ALUOut %d", $time);
		@(posedge clk);
		Mem2RegIn <= 1'b1; // let through data from memory
		$display("letting through MemOutZP %d", $time);
		@(posedge clk);
		// Test MOV mux and OR gate
		MOVZIn <= 1'b0; 
		MOVKIn <= 1'b0; // let through Mem2RegMuxOut
		$display("letting through Mem2RegMuxOut %d", $time);
		@(posedge clk);
		MOVZIn <= 1'b1; 
		MOVKIn <= 1'b0; // let through Mov
		$display("letting through MOVResult %d", $time);
		@(posedge clk);
		MOVZIn <= 1'b0; 
		MOVKIn <= 1'b1; // let through Mov
		$display("letting through MOVResult %d", $time);
		@(posedge clk);
		MOVZIn <= 1'b1; 
		MOVKIn <= 1'b1; // let through Mov
		$display("letting through MOVResult %d", $time);
		@(posedge clk);
		// Test Rd out
		OPCodeIn[31:0] = 32'b00111000010_000000000_00_00000_00001;	// LDURB X1, [X0, #0]
		$display("Rd should be 1 %d", $time);
		@(posedge clk);
		OPCodeIn[31:0] = 32'b00111000010_000000000_00_00000_00100;	// LDURB X1, [X0, #0]
		$display("Rd should be 4 %d", $time);
		@(posedge clk);
		OPCodeIn[31:0] = 32'b00111000010_000000000_00_00000_10000;	// LDURB X1, [X0, #0]
		$display("Rd should be 16 %d", $time);
		@(posedge clk);
		//test the cntrl forwarding of the register
		RegWriteIn <= 1'b0;
		@(posedge clk);
		RegWriteIn <= 1'b1;
		@(posedge clk);
		@(posedge clk);
		$stop;
	end
endmodule