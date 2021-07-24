module tb_register_r();
	reg clk, reset;
	reg [7:0] in;
	wire[7:0] out;
	reg [7:0] out_expected;
	reg [3:0] vectornum, errors; 
	reg [16:0] testvectors[3:0]; 
	
	register_r #8 dut(clk,reset,in,out);
	
	
	always 
	begin
		clk = 0; #20; clk = 1; #20;
	end
	
	initial
		begin
		$readmemb("testvector_register_r.tv", testvectors);
		vectornum = 0; errors = 0;
		reset = 1; #30; 
		reset = 0;
	end
	
	always @(negedge clk)
		begin
	   {reset,in,out_expected} = testvectors[vectornum];
		end
	
	always @(posedge clk)
		begin
		#1;if (out !== out_expected) 			
		begin		
			$display("Error: reset = %b , input= %b ", reset,in);
			$display(" outputs = %b (%b expected)",out,out_expected);
			errors = errors + 1;
		end
	
	vectornum = vectornum + 1;
	if (vectornum == 3'b100) begin 
		$display("%d tests completed with %d errors",vectornum, errors);
		$stop;
	end
	end
endmodule

