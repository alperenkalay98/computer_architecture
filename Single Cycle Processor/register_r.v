module register_r #(parameter W=32)(clk, reset, in, out);
	input clk;
	input wire [(W-1):0] in;
	input wire reset;
	output reg [(W-1):0] out;
	
	always @(posedge clk)
		out = (reset==1) ? 0 : in;
endmodule
