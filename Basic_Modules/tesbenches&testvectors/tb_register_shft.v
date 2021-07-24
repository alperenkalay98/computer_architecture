module tb_register_shft();
	reg clk,reset,load_sel,dir_sel,s_in_l,s_in_r;
	reg [7:0] p_in;
	wire[7:0] out;
	reg [7:0] out_expected;
	reg [5:0] vectornum, errors; 
	reg [20:0] testvectors[5:0]; 
	
	register_shft #8 dut(clk,reset,load_sel,dir_sel,p_in,s_in_l,s_in_r,out);
	
	
	always 
	begin
		clk = 0; #20; clk = 1; #20;
	end
	
	initial
		begin
		$readmemb("testvector_register_shft.tv", testvectors);
		vectornum = 0; errors = 0;
		//reset = 1; #30; 
		reset = 0;
	end
	
	always @(negedge clk)
		begin
	   {reset,load_sel,dir_sel,s_in_l,s_in_r,p_in,out_expected} = testvectors[vectornum];
		end
	
	always @(posedge clk)
		begin
		#1;if (out !== out_expected) 			
		begin		
			$display("Error: reset = %b , load_sel = %b,dir_sel = %b,left = %b, right = %b, p_input= %b ", reset,load_sel,dir_sel,s_in_l,s_in_r,p_in);
			$display(" outputs = %b (%b expected)",out,out_expected);
			errors = errors + 1;	
		end
	
	vectornum = vectornum + 1;
	if (vectornum == 4'b0111) begin 
		$display("%d tests completed with %d errors",vectornum, errors);
		$stop;
	end
	end
endmodule
