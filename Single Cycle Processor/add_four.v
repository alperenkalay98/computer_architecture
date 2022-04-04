  module add_four (in,out);
	input [31:0] in;
	output [31:0] out;
	assign out = in + 2'b01;
endmodule 