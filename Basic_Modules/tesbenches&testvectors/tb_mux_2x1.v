module tb_mux_2x1 ();
	reg clk,reset;
	reg in0,in1;
	reg sel;
	reg op_expected;
	wire op;
	
	reg [3:0] vectornum,errors;
	reg [3:0] testvectors[1:0];
	
	mux_2x1 dut(in0,in1,sel,op);
	
	always 
		begin
			clk=1; #10; clk=0; #10;
		end
		
	initial
		begin
			$readmemb("testvector_mux_2x1.tv",testvectors);
			vectornum=0; errors=0;
			reset=1; #20; reset=0;
		end
		
	always @(posedge clk)
		begin
			{in0,in1,sel,op_expected}=testvectors[vectornum];
		end
		
	always @(negedge clk)
		if(~reset) begin
			#1;if(op !== op_expected) begin
				$display("Error: input0 = %b",in0);
				$display(" input1 = %b",in1);
				$display(" select = %b",sel);
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
