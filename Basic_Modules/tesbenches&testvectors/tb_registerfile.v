module tb_registerfile();
	reg clk, reset, en;
	reg [7:0] in;
	reg [1:0] in_sel,out1_sel,out2_sel;
	wire[7:0] out1,out2;
	reg [7:0] out1_expected,out2_expected;
	
	reg [5:0] vectornum, errors; 
	reg [31:0] testvectors[7:0]; 
	
	register_file #8 dut(clk,reset,en,in_sel,out1_sel,out2_sel,in,out1,out2);
	
	
	always 
	begin
		clk = 0; #20; clk = 1; #20;
	end
	
	initial
		begin
		$readmemb("testvector_registerfile.tv", testvectors);
		vectornum = 0; errors = 0;
		reset = 0;
	end
	
	always @(negedge clk)
		begin
	   {reset,en,in_sel,out1_sel,out2_sel,in,out1_expected,out2_expected} = testvectors[vectornum];
		end
	
	always @(posedge clk)
		begin
		#1;if (out1 !== out1_expected | out2 !== out2_expected) 			
		begin		
			$display("Error: reset = %b , en = %b, in_sel = %b ", reset,en,in_sel);
			$display("Error: out1_sel = %b , out2_sel = %b, in = %b ", out1_sel,out2_sel,in);
			$display(" outputs = %b , %b (%b , %b expected)",out1,out2,out1_expected,out2_expected);
			errors = errors + 1;	
		end
	
	vectornum = vectornum + 1;
	if (vectornum == 4'b1000) begin 
		$display("%d tests completed with %d errors",vectornum, errors);
		$stop;
	end
	end
endmodule 