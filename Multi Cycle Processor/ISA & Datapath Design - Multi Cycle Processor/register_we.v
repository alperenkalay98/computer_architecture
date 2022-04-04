module register_we #(parameter W=8) (clk, reset, en, in, out);

	input clk, reset, en;
	input [(W-1):0] in;
	output reg [(W-1):0] out;

	always @(posedge clk)
		begin
		
			if (reset) begin
				out <= 0;
			end
			
			else if (en) begin
				out <= in;
			end
		
		end

endmodule
