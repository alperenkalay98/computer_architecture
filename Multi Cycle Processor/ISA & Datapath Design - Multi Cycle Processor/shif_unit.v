module shif_unit (clk,in,op,out);
	input clk;
	input signed [7:0] in;
	input [2:0] op;
	output reg [7:0] out;
	
	
	always @(posedge clk)begin
			
			case(op)
			3'b000: out<={in[6:0],in[7]}; //RTL
			3'b100: out<={in[0],in[7:1]}; //RTR
			3'b010: out<=in<<1;   			//SHL
			3'b011: out<=in<<1;				//SHL
			3'b110: out<=in>>>1;				//ASR
			3'b111: out<=in>>1;				//LSR
			3'b001: out<=in;					//no change
			3'b101: out<=in;					//no change
			endcase
			
	end
	
	
endmodule
