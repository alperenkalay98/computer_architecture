module tb_ALP();
	reg clk,load,comp,clr;
	reg [3:0] data_in;
	reg [2:0] op;
	wire [3:0] out_0,out_1;
	wire err;
	reg [3:0] out_0_exp,out_1_exp;
	reg err_exp;
	reg [5:0] vectornum; 
	reg [18:0] testvectors[28:0]; 
	
	ALP dut(
			clk,
			data_in,
			op,
			load,
			comp,
			clr,
			out_0,
			out_1,
			err
			);
	
	
	always 
	begin
		clk = 0; #25; clk = 1; #25;
	end
	
	initial
		begin
		$readmemb("testvector_ALP.tv", testvectors);
		vectornum = 0;
	end
	
	always @(negedge clk)
		begin
	   {data_in,op,load,comp,clr,out_0_exp,out_1_exp,err_exp} = testvectors[vectornum];
		end
	
	always @(posedge clk)
		begin
			vectornum = vectornum + 1;
			if (vectornum == 5'b11110) begin 
				$display("%d tests completed",vectornum);
				$stop;
			end
		end
endmodule 