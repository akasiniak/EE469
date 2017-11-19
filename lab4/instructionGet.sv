`timescale 1ns/10ps
module instructionGet(OPCode, clk, reset, BrTaken, UncondBr);
	input logic clk, reset, BrTaken, UncondBr;
	output logic [31:0] OPCode;

	logic [63:0] PCOut;
	instructmem instructMEM(.address(PCOut), .instruction(OPCode), .clk);

	logic [63:0] PCPlus4, CondAddr, BrAddr, UncondBrMuxOut, shiftOut, PCPlusBranch, BrTakenMuxOut;
	adder64Bit PCPlus4Adder(.result(PCPlus4), .A(PCOut), .B(64'd4));

	signExtend #(.WIDTH(19)) condAddrSE (.out(CondAddr), .in(OPCode[23:5]));
	signExtend #(.WIDTH(26)) brAddrSE (.out(BrAddr), .in(OPCode[25:0]));

	genvar i;
	generate 
		for(i = 0; i < 64; i++) begin: eachUncondMux
			mux2to1 eachShiftMux(.out(UncondBrMuxOut[i]), .in({BrAddr[i], CondAddr[i]}), .select(UncondBr));
			mux2to1 eachBrMux(.out(BrTakenMuxOut[i]), .in({PCPlusBranch[i], PCPlus4[i]}), .select(BrTaken));
		end // eachMux
	endgenerate

	shifter shiftAddr(.value(UncondBrMuxOut), .direction(1'b0), .distance(6'b000010), .result(shiftOut));

	adder64Bit PCPlusSE(.result(PCPlusBranch), .A(PCOut), .B(shiftOut));

	programCounter PC(.in(BrTakenMuxOut), .out(PCOut), .clk, .reset);
endmodule

module instructionGet_testbench;
	logic clk, reset, BrTaken, UncondBr;
	logic [31:0] OPCode;

	instructionGet dut(.reset, .clk, .OPCode, .BrTaken, .UncondBr);

	parameter CLOCK_PERIOD= 1;
	initial begin
	clk <= 0;
	forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	integer i;
	always_comb begin
		if(OPCode[31:26] == 6'b000101) begin
			UncondBr = 1'b1;
			BrTaken = 1'b1;
		end
		else begin
			UncondBr = 1'b0;
			BrTaken = 1'b0;
		end
	end
	initial begin
		reset <= 1'b1;
		@(posedge clk);
		reset <= 1'b0;
		for(i = 0; i < 15; i++) begin
			@(posedge clk);
		end
		$stop;
	end
endmodule
