module register_shft #(parameter W=8) (clk,reset,load_sel,dir_sel,p_in,s_in_l,s_in_r,out);
	input clk, reset, load_sel, dir_sel, s_in_l, s_in_r;
	input [(W-1):0] p_in;
	output reg [(W-1):0] out;

	always @(posedge clk)
	begin
		if (reset)
			out <= 0;
		else
			if (load_sel)
				out <= p_in;
			else
				if (dir_sel)
					out <= {s_in_l,out[(W-1):1]};
				else
					out <= {out[(W-2):0],s_in_r};
		
	end

endmodule
