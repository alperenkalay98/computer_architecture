module tb_ALU();
	reg clk,reset;
	reg [7:0] A,B;
	reg [2:0] control;
	reg [7:0] out_expected;
	wire [7:0] op;
	reg C_exp,V_exp,N_exp,Z_exp;
	wire c,v,n,z;
	reg [3:0] vectornum, errors;
	reg [30:0] testvectors[11:0];
	
	ALU #8 dut(A,B,control,c,v,n,z,op);
	
	always 
		begin
		clk = 1; #5; clk = 0; #5;
	end
	
	initial
		begin
		$readmemb("testvector_ALU.tv", testvectors); 
		vectornum = 0; errors = 0;
		reset = 1; #30; reset = 0;
		end
	
	always @(posedge clk)
		begin
		#1; {A,B,control,C_exp,V_exp,N_exp,Z_exp,out_expected} = testvectors[vectornum];
		end
		
	always @(negedge clk)
		if (~reset) begin 

		if (op !== out_expected) begin
			$display("Error: inputs = control: %b , A: %b, B: %b", control,A,B);
			$display(" outputs = %b (%b expected)",op,out_expected);
			errors = errors + 1;
		end
		
		if ({c,v,n,z} != {C_exp,V_exp,N_exp,Z_exp}) begin
			$display("Error: inputs = control: %b , A: %b, B: %b", control,A,B);
			$display(" flags(CVNZ) = %b (%b expected)",{c,v,n,z},{C_exp,V_exp,N_exp,Z_exp});
			errors = errors + 1;	
		end
	
		vectornum = vectornum + 1;
		if (vectornum == 4'b1100) begin 
			$display("%d tests completed with %d errors",vectornum, errors);
			$stop;
		end
		end
		
endmodule  