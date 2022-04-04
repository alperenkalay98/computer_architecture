module extend(in,len_sel,out);
	input [7:0] in;
	input [1:0] len_sel;
	output reg [7:0] out;
	
	always @ (*)	
	begin
		case(len_sel)
			2'b00:begin
				out=in;
			end
			2'b01:begin
				out=in;
			end
			2'b10:begin
				if(in[2]==0)begin
				out={5'b00000,in[2:0]};
				end else begin
				out={5'b11111,in[2:0]};
				end
			end
			2'b11:begin
				if(in[5]==0)begin
				out={2'b00,in[5:0]};
				end else begin
				out={2'b11,in[5:0]};
				end
			end
		endcase
	end
	
endmodule
