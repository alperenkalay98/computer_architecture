module ALU #(parameter W=32)(A,B,control,C,V,N,Z,out);
	input [(W-1):0] A,B;
	input [2:0] control;
	output reg C,V,N,Z;
	output reg [(W-1):0] out;
	
	wire [(W-1):0] A_comp,B_comp;
	assign A_comp = ~A + 1;
	assign B_comp = ~B + 1;
	
	always @(*)
		begin
		case(control)
		
			3'b000: begin
				{C,out} = A + B;
				V = (A[W-1] ~^ B[W-1]) & (A[W-1] ^ out[W-1]);
				end
				
			3'b001: begin
				{C,out} = A + B_comp;
				V = (A[W-1] ~^ B_comp[W-1]) & (A[W-1] ^ out[W-1]);
				end
			
			3'b010: begin 
				{C,out} = B + A_comp;
				V = (A_comp[W-1] ~^ B[W-1]) & (A_comp[W-1] ^ out[W-1]);
				end
				
			3'b011: begin
				out = A & ~B;
				C = 0;
				V = 0;
				end
				
			3'b100: begin 
				out = A & B;
				C = 0;
				V = 0;
				end
				
			3'b101: begin 
				out = A | B;
				C = 0;
				V = 0;
				end
				
			3'b110: begin 
				out = A ^ B;
				C = 0;
				V = 0;
				end
				
			3'b111: begin 
				out = ~(A ^ B);
				C = 0;
				V = 0;
				end
				
		endcase
		
		Z = (out==0);
		N = out[W-1];
	
		end
endmodule
