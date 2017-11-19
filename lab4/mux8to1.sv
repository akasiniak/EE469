module mux8to1 (out, select, muxIn);
	input logic [2:0] select;
	input logic [7:0] muxIn;
	output logic out;
	logic [1:0] outBottom2Bits;
	
	mux4to1 selectBottom2Bits1 (.out(outBottom2Bits[0]), .muxIn(muxIn[3:0]), .select(select[1:0]));
	mux4to1 selectBottom2Bits2 (.out(outBottom2Bits[1]), .muxIn(muxIn[7:4]), .select(select[1:0]));
	mux2to1 selectTopBit (.out(out), .in(outBottom2Bits), .select(select[2]));
endmodule

module mux8to1_testbench;
	logic [2:0] select;
	logic [7:0] muxIn;
	logic out;
	initial begin
		integer i;
		integer j;
		for(i = 0; i < 8; i++) begin
			select = i;
			muxIn = 1;
			for(j = 0; j < 8; j++) begin
				#10;
				muxIn = muxIn << 1;
			end
		end
	end
	mux8to1 dut(.out, .select, .muxIn);
endmodule