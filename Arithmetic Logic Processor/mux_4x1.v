module mux_4x1 #(parameter W=32) (in0,in1,in2,in3,sel,out);
	input [(W-1):0] in0,in1,in2,in3;
	input [1:0] sel;
	output reg [(W-1):0] out;
	
	always @(in0,in1,in2,in3,sel)
		case(sel)
			2'b00: out = in0;
			2'b01: out = in1;
			2'b10: out = in2;
			2'b11: out = in3;
		endcase
		
endmodule
