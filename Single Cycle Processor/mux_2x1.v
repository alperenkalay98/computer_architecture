module mux_2x1 #(parameter W=4) (in0,in1,sel,out);
	input [(W-1):0] in0,in1;
	input sel;
	output [(W-1):0] out;
	
	assign out = sel ? in1 : in0;
	
endmodule
