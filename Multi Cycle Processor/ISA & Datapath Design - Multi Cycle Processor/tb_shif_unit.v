module tb_shif_unit();
	reg clk;
	reg [7:0] in;
	reg [2:0] op;
	
	wire [7:0] out;
	reg [7:0] out_exp;
	
	reg [2:0] vectornum;
	reg [18:0] testvectors [4:0];
	
	shif_unit dut(
				 clk,
				 in,
				 op,
				 out
				 );
	
always begin
	clk=0; #25; clk=1; #25;
end
	
initial begin
	$readmemb("testvector_shif_unit.tv", testvectors);
	vectornum = 0; 
end

	always @(negedge clk)
		begin
	   {in,op,out_exp} = testvectors[vectornum];
		end
	
	always @(posedge clk)
		begin
			vectornum = vectornum + 1;
			if (vectornum == 3'b110) begin 
				$display("%d tests completed ",vectornum);
				$stop;
			end
		end
		
endmodule
