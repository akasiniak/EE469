`timescale 1ns/10ps
//This module does all of the neccessary operations of the IFETCH stage of our processor. Increments the program counter, pulls the OPCode from Imem
//calculates PC + 4, and calculates PC + either the unconditional branch target, or the conditional branch target. It also takes in data directly from
//the CPU control module since we don't want any delay on the control signals coming to this stage.
module IFETCH (OPCode, clk, reset, UncondBr, BrTaken);
	output logic [31:0] OPCode;
	input logic clk, reset, UncondBr, BrTaken;
	logic [63:0] PCOut, BrAddrSE, CondAddrSE, UncondMuxOut, PCPlusImm, PCPlus4, BrTakenMuxOut, RegPC;
	logic [31:0] intoRegOPCode;
	genvar i;

	programCounter PC (.in(BrTakenMuxOut), .out(PCOut), .clk, .reset);
	instructmem IMem (.address(PCOut), .instruction(intoRegOPCode), .clk);
	//set up registers to send data to the next stage
	register #(.WIDTH(32)) OPCodeReg (.dataOut(OPCode), .dataIn(intoRegOPCode), .enable(1'b1), .clk, .reset); //sends OPCode
	register #(.WIDTH(64)) PCReg (.dataOut(RegPC), .dataIn(PCOut), .enable(1'b1), .clk, .reset); //sends PC value

	signExtend #(.WIDTH(19)) UncondAddr19 (.out(CondAddrSE), .in(OPCode[23:5]));
	signExtend #(.WIDTH(26)) BrAddr26 (.out(BrAddrSE), .in(OPCode[25:0]));

	adder64Bit PCPlusImmAdder (.result(PCPlusImm), .A(RegPC), .B((UncondMuxOut << 2)));
	adder64Bit PCPlus4Adder (.result(PCPlus4), .A(PCOut), .B(64'd4));

	generate
		for(i = 0; i < 64; i++) begin: eachMux
			mux2to1 SESelectMux (.out(UncondMuxOut[i]), .in({BrAddrSE[i], CondAddrSE[i]}), .select(UncondBr));
			mux2to1 BrTakenMux (.out(BrTakenMuxOut[i]), .in({PCPlusImm[i], PCPlus4[i]}), .select(BrTaken));
		end
	endgenerate
endmodule

module IFETCH_testbench ();
	logic [31:0] OPCode;
	logic clk, reset, UncondBr, BrTaken;
	integer i;

	IFETCH dut (.OPCode, .clk, .reset, .UncondBr, .BrTaken);

	parameter CLOCK_PERIOD=100;
	initial begin
	clk <= 0;
	forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end

	always_comb begin
		if(OPCode[31:26] != 6'b000101 && OPCode[31:24] != 8'b01010100 && OPCode[31:24] != 8'b10110100) begin
			BrTaken = 1'b0;
			UncondBr = 1'b0;
		end
		if(OPCode[31:26] == 6'b000101) begin
			BrTaken = 1'b1;
			UncondBr = 1'b1;
		end 
		if (OPCode[31:24] == 8'b01010100) begin
			BrTaken = 1'b1;
			UncondBr = 1'b0;
		end 
		if (OPCode[31:24] == 8'b10110100) begin
			BrTaken = 1'b1;
			UncondBr = 1'b0;
		end
	end

	initial begin
		reset <= 1'b1;
		@(posedge clk);
		reset <= 1'b0;
		@(posedge clk);
		for(i = 0; i < 7; i++)begin
			@(posedge clk);
		end
		@(posedge clk);
		$stop;
	end
endmodule
