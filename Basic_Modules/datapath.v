module datapath(
	clk,
	reset,
	mux_2x1_R1_sel,
	mux_2x1_alu_a_sel,
	mux_2x1_acc_sel,
	acc_load_sel,
	q_dir_sel,
	alu_control,
	in,
	out
);

input	clk;
input	reset;
input	mux_2x1_R1_sel;
input	mux_2x1_alu_a_sel;
input mux_2x1_acc_sel;
input	acc_load_sel;
input	q_dir_sel;
input	[2:0] alu_control;
input	[3:0] in;
output wire	[3:0] out;

wire [3:0] R1_in;
wire [3:0] R1_out;
wire [3:0] alu_a;
wire [3:0] alu_b;
wire [3:0] alu_out;
wire [3:0] acc_in;
wire [3:0] acc_out;
wire [3:0] q_out;
wire [3:0] alu_a_mux_2x1_in_0;
wire [3:0] alu_a_mux_2x1_in_1;

assign out = R1_out;

register_r R0(
	.clk(clk),
	.reset(reset),
	.in(in),
	.out(alu_b)
	);
	defparam	R0.W = 4;

register_r R1(
	.clk(clk),
	.reset(reset),
	.in(R1_in),
	.out(R1_out)
	);
	defparam	R1.W = 4;

	
register_shft acc(
	.clk(clk),
	.reset(reset),
	.load_sel(acc_load_sel),
	.dir_sel(1),
	.p_in(acc_in),
	.s_in_l(acc_out[0]),
	.s_in_r(0),
	.out(acc_out)
	);
	defparam	acc.W = 4;

register_shft q(
	.clk(clk),
	.reset(reset),
	.load_sel(0),
	.dir_sel(q_dir_sel),
	.p_in(4'b0000),
	.s_in_l(acc_out[0]),
	.s_in_r(acc_out[0]),
	.out(q_out)
	);
	defparam	q.W = 4;

ALU alu(
	.A(alu_a),
	.B(alu_b),
	.control(alu_control),
	.out(alu_out));
	defparam	alu.W = 4;


mux_2x1 R1_sel(
	.in0(acc_out),
	.in1(alu_out),
	.sel(mux_2x1_R1_sel),
	.out(R1_in)
	);
	defparam	R1_sel.W = 4;

mux_2x1 alu_a_sel(
	.in0(4'b0000),
	.in1(4'b0001),
	.sel(mux_2x1_alu_a_sel),
	.out(alu_a)
	);
	defparam	alu_a_sel.W = 4;

mux_2x1 acc_sel(
	.in0(alu_out),
	.in1(q_out),
	.sel(mux_2x1_acc_sel),
	.out(acc_in)
	);
	defparam	acc_sel.W = 4;


endmodule
