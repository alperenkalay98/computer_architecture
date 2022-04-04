module shifter(A,B,dir_sel,out);
	input [31:0] A,B;
	input dir_sel;
	output reg [31:0] out;
	
	always @(*)begin
			if(dir_sel==0)begin
				out=A<<B;
			end else if(dir_sel==1)begin
				out=A>>B;
			end
	end
endmodule
