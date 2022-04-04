module tb_idm();
	reg clk;
	reg memWrite;
	reg [7:0] adr;
	reg [7:0] WD;
	
	wire [13:0] out;
	reg [13:0] out_exp;
	wire [7:0] mem32;
	
	reg [2:0] vectornum;
	reg [30:0] testvectors [3:0];
	
	idm dut(
		     clk,
		     memWrite,
		     adr,
		     WD,
			  out,
			  mem32
		     );
	
always begin
	clk=0; #25; clk=1; #25;
end
	
initial begin
	$readmemb("testvector_idm.tv", testvectors);
	vectornum = 0; 
end

	always @(negedge clk)
		begin
	   {memWrite,adr,WD,out_exp} = testvectors[vectornum];
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
