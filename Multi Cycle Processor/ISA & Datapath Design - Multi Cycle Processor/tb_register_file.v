module tb_register_file();
	reg clk,reset,WE3;
	reg [2:0] A1,A2,A3;
	reg [7:0] WD3,R7;
	wire [7:0] RD1, RD2,tbout1,tbout2,tbout6;
	
	reg [2:0] vectornum;
	reg [26:0] testvectors [3:0];
	
	register_file dut(
							clk,
							reset,
							A1,
							A2,
							A3,
							WE3,
							WD3,
							R7,
							RD1,
							RD2,
							tbout1,
							tbout2,
							tbout6
							);
	
always begin
	clk=0; #25; clk=1; #25;
end
	
initial begin
	$readmemb("testvector_register_file.tv", testvectors);
	vectornum = 0; 
end

	always @(negedge clk)
		begin
	   {reset,A1,A2,A3,WE3,WD3,R7} = testvectors[vectornum];
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