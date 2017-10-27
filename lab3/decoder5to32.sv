module decoder5to32(whichReg, registerSelect, registerWrite);
	input logic [4:0] registerSelect;
	input logic registerWrite;
	output logic [31:0] whichReg;
	logic [3:0] output2to4;
	
	decoder2to4 dec2to4 (.decoded(output2to4[3:0]), .coded(registerSelect[4:3]), .writeEn(registerWrite));
	genvar i;
	generate
		for(i = 0; i < 4; i++) begin: eachDecoder
			decoder3to8 dec3to8 (.decoded(whichReg[((8*i) + 7):(8*i)]), .coded(registerSelect[2:0]), .writeEn(output2to4[i]));
		end
	endgenerate
endmodule

module decoder5to32_testbench;
	logic [4:0] registerSelect;
	logic registerWrite;
	logic [31:0]whichReg;
	initial begin
		integer i;
		registerWrite = 1;
		for(i = 0; i < 32; i++) begin
			registerSelect = i;
			#10;
		end
	end
	decoder5to32 dut(.whichReg, .registerSelect, .registerWrite);
endmodule
		