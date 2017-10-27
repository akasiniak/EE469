module mux4to1 (out, select, muxIn);
	input logic [1:0] select;
	input logic [3:0] muxIn;
	output logic out;
	logic [1:0] outBottomBit;
	
	mux2to1 selectBottomBit1 (.out(outBottomBit[0]), .in(muxIn[1:0]), .select(select[0]));
	mux2to1 selectBottomBit2 (.out(outBottomBit[1]), .in(muxIn[3:2]), .select(select[0]));
	mux2to1 selectTopBit (.out(out), .in(outBottomBit), .select(select[1]));
endmodule

module mux4to1_testbench;
	logic [1:0] select;
	logic [3:0] muxIn;
	logic out;
	initial begin
		integer i;
		integer j;
		for(i = 0; i < 4; i++) begin
			select = i;
			muxIn = 1;
			for(j = 0; j < 4; j++) begin
				#10;
				muxIn = muxIn << 1;
			end
		end
	end
	mux4to1 dut(.out, .select, .muxIn);
endmodule