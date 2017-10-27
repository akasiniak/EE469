module regfile (ReadData1, ReadData2, WriteData, WriteRegister, RegWrite, ReadRegister1, ReadRegister2, clk);
	input logic [63:0] WriteData;
	input logic [4:0] ReadRegister1, ReadRegister2, WriteRegister;
	input logic RegWrite, clk;
	output logic [63:0] ReadData1, ReadData2;
	logic [31:0] decoderOutput;
	logic [31:0][63:0] registerWires;
	logic [63:0][31:0] intoMuxes;
	
	integer j, k;
	always_comb begin
		for(j = 0; j < 64; j++)
			for(k = 0; k < 32; k++)
				intoMuxes[j][k] = registerWires[k][j];
	end
	
	decoder5to32 ourDecoder (.whichReg(decoderOutput[31:0]), .registerSelect(WriteRegister[4:0]), .registerWrite(RegWrite));
	
	genvar i; 
	generate
		for(i = 0; i < 31; i++) begin: eachReg
			register ourRegisters (.dataOut(registerWires[i][63:0]), .dataIn(WriteData[63:0]), 
											.enable(decoderOutput[i]), .clk, .reset(1'b0));
		end
	endgenerate
	register zeroReg (.dataOut(registerWires[31][63:0]), .dataIn(64'b0), .enable(1'b1), .clk, .reset(1'b0));
	
	generate
		for(i = 0; i < 64; i++) begin: whichBit1
			mux32to1 ourMuxes1 (.out(ReadData1[i]), .select(ReadRegister1[4:0]), .muxIn(intoMuxes[i][31:0]));
		end
	endgenerate
	
	generate
		for(i = 0; i < 64; i++) begin: whichBit2
			mux32to1 ourMuxes2 (.out(ReadData2[i]), .select(ReadRegister2[4:0]), .muxIn(intoMuxes[i][31:0]));
		end
	endgenerate
endmodule

// Test bench for Register file
`timescale 1ns/10ps

module regstim(); 		

	parameter ClockDelay = 5000;

	logic	[4:0] 	ReadRegister1, ReadRegister2, WriteRegister;
	logic [63:0]	WriteData;
	logic 			RegWrite, clk;
	logic [63:0]	ReadData1, ReadData2;

	integer i;

	// Your register file MUST be named "regfile".
	// Also you must make sure that the port declarations
	// match up with the module instance in this stimulus file.
	regfile dut (.ReadData1, .ReadData2, .WriteData, 
					 .ReadRegister1, .ReadRegister2, .WriteRegister,
					 .RegWrite, .clk);

	// Force %t's to print in a nice format.
	initial $timeformat(-9, 2, " ns", 10);

	initial begin // Set up the clock
		clk <= 0;
		forever #(ClockDelay/2) clk <= ~clk;
	end

	initial begin
		// Try to write the value 0xA0 into register 31.
		// Register 31 should always be at the value of 0.
		RegWrite <= 5'd0;
		ReadRegister1 <= 5'd0;
		ReadRegister2 <= 5'd0;
		WriteRegister <= 5'd31;
		WriteData <= 64'h00000000000000A0;
		@(posedge clk);
		
		$display("%t Attempting overwrite of register 31, which should always be 0", $time);
		RegWrite <= 1;
		@(posedge clk);

		// Write a value into each  register.
		$display("%t Writing pattern to all registers.", $time);
		for (i=0; i<31; i=i+1) begin
			RegWrite <= 0;
			ReadRegister1 <= i-1;
			ReadRegister2 <= i;
			WriteRegister <= i;
			WriteData <= i*64'h0000010204080001;
			@(posedge clk);
			
			RegWrite <= 1;
			@(posedge clk);
		end

		// Go back and verify that the registers
		// retained the data.
		$display("%t Checking pattern.", $time);
		for (i=0; i<32; i=i+1) begin
			RegWrite <= 0;
			ReadRegister1 <= i-1;
			ReadRegister2 <= i;
			WriteRegister <= i;
			WriteData <= i*64'h0000000000000100+i;
			@(posedge clk);
		end
		$stop;
	end
endmodule