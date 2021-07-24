module tb_register_we();
	reg clk, reset, en;
	reg [7:0] in;
	wire[7:0] out;
	reg [7:0] out_expected;
	reg [2:0] vectornum, errors; 
	reg [17:0] testvectors[3:0]; 
	
	register_we #8 dut(clk,reset,en,in,out);
	
	
	always 
	begin
		clk = 0; #20; clk = 1; #20;
	end
	
	initial
		begin
		$readmemb("testvector_register_we.tv", testvectors);
		vectornum = 0; errors = 0;
		//reset = 1; #30; 
		reset = 0;
	end
	
	always @(negedge clk)
		begin
	   {reset,en,in,out_expected} = testvectors[vectornum];
		end
	
	always @(posedge clk)
		begin
		#1;if (out !== out_expected) 			
		begin		
			$display("Error: reset = %b , enable = %b, input= %b ", reset,en,in);
			$display(" outputs = %b (%b expected)",out,out_expected);
			errors = errors + 1;
		end

		vectornum = vectornum + 1;
		if (vectornum == 3'b101) begin 
			$display("%d tests completed with %d errors",vectornum, errors);
			$stop;
		end
		end
		
endmodule 