module extend(in,len_sel,out);
	input [11:0] in;
	input len_sel;
	output reg [31:0] out;
	
	always @ (*)
	begin
		if(len_sel==0)begin
			if(in[11]==0)begin
			out={24'b0, in[7:0]};			
			end
			else if(in[11]==1)begin
			out={24'b1, in[7:0]};
			end
		end
		else if(len_sel==1)begin
			if(in[11]==0)begin
			out={20'b0, in};			
			end
			else if(in[11]==1)begin
			out={20'b1, in};
			end
		end
	end
	
endmodule
