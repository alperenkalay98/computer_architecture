module tb_extend();
	reg clk;
	reg [7:0] in;
	reg [1:0] len_sel;
	
	reg [7:0] out_exp;
	wire [7:0] out;
	
	reg [3:0] vectornum;
	reg [17:0] testvectors [4:0];
	
	extend dut(
				in,
				len_sel,
				out
				);
	
always begin
	clk=0; #25; clk=1; #25;
end
	
initial begin
	$readmemb("testvector_extend.tv", testvectors);
	vectornum = 0; 
end

	always @(negedge clk)
		begin
	   {in,len_sel,out_exp} = testvectors[vectornum];
		end
	
	always @(posedge clk)
		begin
			vectornum = vectornum + 1;
			if (vectornum == 3'b101) begin 
				$display("%d tests completed ",vectornum);
				$stop;
			end
		end
		
endmodule
