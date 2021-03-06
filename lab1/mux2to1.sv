`timescale 1ns/10ps
module mux2to1 (out, in, select);
	input logic [1:0] in;
	input logic select;
	output logic out;
	logic topBitSelect, bottomBitSelect;
	
	and #50 theTopAndGate(topBitSelect, in[1], select);
	and #50 theBottomAndGate(bottomBitSelect, in[0], ~select);
	or #50 theOrGate(out, topBitSelect, bottomBitSelect);
endmodule

module mux2to1_testbench;
	logic [1:0] in;
	logic select;
	logic out;
	initial begin
		in = 'b00; select = 0; #10;
                 select = 1; #10;
		in = 'b01; select = 0; #10;
                 select = 1; #10;
		in = 'b10; select = 0; #10;
					  select = 1; #10;
		in = 'b11; select = 0; #10;
					  select = 1; #10;
	end
	mux2to1 dut (.out, .in, .select);	
endmodule
