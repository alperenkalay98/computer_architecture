module register_file #(parameter W=32)(clk,reset,en,in_sel,out1_sel,out2_sel,in,out1,out2);
	input clk,reset,en;
	input [1:0] in_sel,out1_sel,out2_sel;
	input [(W-1):0] in;
	
	wire [3:0] decoder_out;
	wire [(W-1):0] reg_out[3:0];
	output wire [(W-1):0] out1,out2;
	
	decoder_2x4 dest_select(in_sel,decoder_out);

	register_we #W reg0(clk,reset,en & decoder_out[0],in,reg_out[0]);
	register_we #W reg1(clk,reset,en & decoder_out[1],in,reg_out[1]);
	register_we #W reg2(clk,reset,en & decoder_out[2],in,reg_out[2]);
	register_we #W reg3(clk,reset,en & decoder_out[3],in,reg_out[3]);

	mux_4x1 #W source1_sel(reg_out[0],reg_out[1],reg_out[2],reg_out[3],out1_sel,out1);
	mux_4x1 #W source2_sel(reg_out[0],reg_out[1],reg_out[2],reg_out[3],out2_sel,out2);

endmodule
