`timescale 1ns/10ps
module SingleCycleCPU (clk, reset);
	input logic clk, reset;
	logic zero, negative, carryOut, overflow, Reg2Loc, MemWrite, LDURB, MemtoReg, MOVZ, MOVK, RegWrite, read_enable, BrTaken, NOOP;
	logic UncondBr;
	logic [2:0] ALUCntrl;
	logic [31:0] OPCode;
	logic [1:0] ALUSrc;
	logic [3:0] xfer_size;
	execution EXEC (.zeroOut(zero), .negative, .carryOut, .overflow, .OPCode, .Reg2Loc, .MemWrite, .LDURB, .MemtoReg, .MOVZ, .MOVK, 
				.RegWrite, .ALUSrc, .ALUCntrl, .xfer_size, .clk, .reset, .read_enable, .NOOP);
	CPUControl CONTROL (.Reg2Loc, .ALUSrc, .MemtoReg, .RegWrite, .MemWrite, .BrTaken, .UncondBr, .LDURB, .xfer_size, .read_enable,
					.MOVZ, .MOVK, .ALUCntrl, .OPCode, .zero, .negative, .overflow, .NOOP);
	instructionGet FETCH (.OPCode, .clk, .reset, .BrTaken, .UncondBr);
endmodule

module SingleCycleCPU_testbench;
	logic clk, reset;
	SingleCycleCPU dut(.clk, .reset);
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
		while(dut.OPCode[31:0] != 32'b00010100000000000000000000000000) begin
			@(posedge clk);
		end
		$diplay("end reached at: %d", $time * 1000);
		@(posedge clk);
		@(posedge clk);
		$stop;
	end
endmodule
