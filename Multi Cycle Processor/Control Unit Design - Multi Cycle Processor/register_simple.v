module register_simple #(parameter W=8) (clk,reset,in,out);

	input clk, reset;
	input [(W-1):0] in;
	output reg [(W-1):0] out;

	always @(posedge clk)
	begin
		if (reset) begin
			out <= 0;
		end 
		else begin
			out <= in;
		end
	end

endmodule

