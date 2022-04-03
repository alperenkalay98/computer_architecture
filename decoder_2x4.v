module decoder_2x4 (X,Y);
	input [1:0] X;
	output [3:0] Y;
	
	assign Y[0] = (~X[1]) & (~X[0]);
	assign Y[1] = (~X[1]) & X[0];
	assign Y[2] = X[1] & (~X[0]);
	assign Y[3] = X[1] & X[0];

endmodule