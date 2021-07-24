module tb_decoder_2x4();
	reg clk,reset;
	reg [1:0] inp;
	reg [3:0] op_expected;
	wire [3:0] op;
	
	reg [5:0] vectornum,errors;
	reg [5:0] testvectors[3:0];
	
	decoder_2x4 dut(inp,op);
	
	always 
		begin
			clk=1; #10; clk=0; #10;
		end
		
	initial
		begin
			$readmemb("testvector_decoder_2x4.tv",testvectors);
			vectornum=0; errors=0;
			reset=1; #30; reset=0;
		end
		
	always @(posedge clk)
		begin
			{inp,op_expected}=testvectors[vectornum];
		end
		
	always @(negedge clk)
		if(~reset) begin
			if(op !== op_expected) begin
				$display("Error: input = %b",inp);
				$display(" output = %b (%b op_expected)",op,op_expected);
				errors=errors+1;
			end
			
			vectornum=vectornum+1;
			if(testvectors[vectornum] == 3'b100) begin
				$display("%d tests completed with %d errors",vectornum,errors);
				$stop;
			end
		end

endmodule