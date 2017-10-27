module mux16to1 (out, select, muxIn);
	input logic [3:0] select;
	input logic [15:0] muxIn;
	output logic out;
	logic [1:0] outBottom3Bits;
	
	mux8to1 selectBottom3Bits1 (.out(outBottom3Bits[0]), .muxIn(muxIn[7:0]), .select(select[2:0]));
	mux8to1 selectBottom3Bits2 (.out(outBottom3Bits[1]), .muxIn(muxIn[15:8]), .select(select[2:0]));
	mux2to1 selectTopBit (.out(out), .in(outBottom3Bits), .select(select[3]));
endmodule

module mux16to1_testbench;
	logic [3:0] select;
	logic [15:0] muxIn;
	logic out;
	initial begin
		integer i;
		integer j;
		for(i = 0; i < 16; i++) begin
			select = i;
			muxIn = 1;
			for(j = 0; j < 16; j++) begin
				#10;
				muxIn = muxIn << 1;
				
			end
		end
	end
	mux16to1 dut(.out, .select, .muxIn);
endmodule