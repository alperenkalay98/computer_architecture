// Copyright (C) 2017  Intel Corporation. All rights reserved.
// Your use of Intel Corporation's design tools, logic functions 
// and other software and tools, and its AMPP partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Intel Program License 
// Subscription Agreement, the Intel Quartus Prime License Agreement,
// the Intel MegaCore Function License Agreement, or other 
// applicable license agreement, including, without limitation, 
// that your use is for the sole purpose of programming logic 
// devices manufactured by Intel and sold by Intel or its 
// authorized distributors.  Please refer to the applicable 
// agreement for further details.

// PROGRAM		"Quartus Prime"
// VERSION		"Version 17.0.0 Build 595 04/25/2017 SJ Lite Edition"
// CREATED		"Sat Apr 17 18:26:26 2021"

module datapath(
	clk,
	R0_rst,
	R0_en,
	R1_rst,
	R1_en,
	alu_srcA_sel,
	acc_rst,
	q_rst,
	acc_en,
	acc_load_sel,
	acc_dir_sel,
	q_load_sel,
	q_dir_sel,
	q_en,
	q_n1_rst,
	qs_en,
	erre_rst,
	erre_en,
	as_en,
	e_sel,
	alu_control,
	alu_srcB_sel,
	data_in,
	R0_sel,
	R1_sel,
	zero,
	zero9,
	q_n1_reg,
	qs,
	as,
	q_lsb,
	r1_s,
	r0_s,
	out_erre,
	out_R0,
	out_R1
);


input wire	clk;
input wire	R0_rst;
input wire	R0_en;
input wire	R1_rst;
input wire	R1_en;
input wire	alu_srcA_sel;
input wire	acc_rst;
input wire	q_rst;
input wire	acc_en;
input wire	acc_load_sel;
input wire	acc_dir_sel;
input wire	q_load_sel;
input wire	q_dir_sel;
input wire	q_en;
input wire	q_n1_rst;
input wire	qs_en;
input wire	erre_rst;
input wire	erre_en;
input wire	as_en;
input wire	e_sel;
input wire	[2:0] alu_control;
input wire	[1:0] alu_srcB_sel;
input wire	[3:0] data_in;
input wire	[1:0] R0_sel;
input wire	[1:0] R1_sel;
input wire	[3:0] zero;
input wire	[3:0] zero9;
output wire	q_n1_reg;
output wire	qs;
output wire	as;
output wire	q_lsb;
output wire	r1_s;
output wire	r0_s;
output wire	[1:0] out_erre;
output wire	[3:0] out_R0;
output wire	[3:0] out_R1;

wire	[3:0] acc_out;
wire	[1:0] erre_in;
wire	[1:0] out_erre_ALTERA_SYNTHESIZED;
wire	[3:0] out_R_ALTERA_SYNTHESIZED0;
wire	[3:3] out_R_ALTERA_SYNTHESIZED1;
wire	[3:0] q_out;
wire	[3:0] SYNTHESIZED_WIRE_19;
wire	SYNTHESIZED_WIRE_1;
wire	SYNTHESIZED_WIRE_2;
wire	SYNTHESIZED_WIRE_3;
wire	SYNTHESIZED_WIRE_4;
wire	SYNTHESIZED_WIRE_5;
wire	SYNTHESIZED_WIRE_6;
wire	SYNTHESIZED_WIRE_7;
wire	[3:0] SYNTHESIZED_WIRE_8;
wire	[3:0] SYNTHESIZED_WIRE_9;
wire	[3:0] SYNTHESIZED_WIRE_10;
wire	SYNTHESIZED_WIRE_11;
wire	SYNTHESIZED_WIRE_13;
wire	SYNTHESIZED_WIRE_14;
wire	[3:0] SYNTHESIZED_WIRE_15;
wire	[3:0] SYNTHESIZED_WIRE_17;

assign	out_R1 = SYNTHESIZED_WIRE_10;
assign	SYNTHESIZED_WIRE_1 = 0;
assign	SYNTHESIZED_WIRE_11 = 0;
assign	SYNTHESIZED_WIRE_13 = 0;




mux_2x1	b2v_a_sel(
	.sel(alu_srcA_sel),
	.in0(zero),
	.in1(out_R_ALTERA_SYNTHESIZED0),
	.out(SYNTHESIZED_WIRE_8));
	defparam	b2v_a_sel.W = 4;


register_shft	b2v_acc(
	.clk(clk),
	.reset(acc_rst),
	.en(acc_en),
	.load_sel(acc_load_sel),
	.dir_sel(acc_dir_sel),
	.s_in_l(acc_out[3]),
	.s_in_r(q_out[0]),
	.p_in(SYNTHESIZED_WIRE_19),
	.out(acc_out));
	defparam	b2v_acc.W = 4;


register_we	b2v_as_reg(
	.clk(clk),
	.reset(SYNTHESIZED_WIRE_1),
	.en(as_en),
	.in(out_R_ALTERA_SYNTHESIZED1),
	.out(as));
	defparam	b2v_as_reg.W = 1;


mux_2x1	b2v_e_sell(
	.sel(e_sel),
	.in0(SYNTHESIZED_WIRE_2),
	.in1(acc_out[0]),
	.out(erre_in[0]));
	defparam	b2v_e_sell.W = 1;

assign	erre_in[1] = SYNTHESIZED_WIRE_3 | SYNTHESIZED_WIRE_4;


register_we	b2v_erre(
	.clk(clk),
	.reset(erre_rst),
	.en(erre_en),
	.in(erre_in),
	.out(out_erre_ALTERA_SYNTHESIZED));
	defparam	b2v_erre.W = 2;

assign	SYNTHESIZED_WIRE_4 = SYNTHESIZED_WIRE_5 & SYNTHESIZED_WIRE_6;

assign	SYNTHESIZED_WIRE_6 = SYNTHESIZED_WIRE_7 & alu_control[1] & alu_control[0];




ALU	b2v_inst10(
	.A(SYNTHESIZED_WIRE_8),
	.B(SYNTHESIZED_WIRE_9),
	.control(alu_control),
	.C(SYNTHESIZED_WIRE_2),
	.V(SYNTHESIZED_WIRE_3),
	
	
	.out(SYNTHESIZED_WIRE_19));
	defparam	b2v_inst10.W = 4;


assign	SYNTHESIZED_WIRE_7 =  ~alu_control[2];


mux_4x1	b2v_inst8(
	.in0(zero9),
	.in1(acc_out),
	.in2(q_out),
	.in3(SYNTHESIZED_WIRE_10),
	.sel(alu_srcB_sel),
	.out(SYNTHESIZED_WIRE_9));
	defparam	b2v_inst8.W = 4;


register_r	b2v_q_n1(
	.clk(clk),
	.reset(q_n1_rst),
	.in(q_out[0]),
	.out(q_n1_reg));
	defparam	b2v_q_n1.W = 1;


register_shft	b2v_q_register(
	.clk(clk),
	.reset(q_rst),
	.en(q_en),
	.load_sel(q_load_sel),
	.dir_sel(q_dir_sel),
	.s_in_l(acc_out[0]),
	.s_in_r(SYNTHESIZED_WIRE_11),
	.p_in(SYNTHESIZED_WIRE_19),
	.out(q_out));
	defparam	b2v_q_register.W = 4;


register_we	b2v_qs_reg(
	.clk(clk),
	.reset(SYNTHESIZED_WIRE_13),
	.en(qs_en),
	.in(SYNTHESIZED_WIRE_14),
	.out(qs));
	defparam	b2v_qs_reg.W = 1;


register_we	b2v_R0(
	.clk(clk),
	.reset(R0_rst),
	.en(R0_en),
	.in(SYNTHESIZED_WIRE_15),
	.out(out_R_ALTERA_SYNTHESIZED0));
	defparam	b2v_R0.W = 4;

assign	SYNTHESIZED_WIRE_5 = ~(out_R_ALTERA_SYNTHESIZED0[3] | out_R_ALTERA_SYNTHESIZED0[1] | out_R_ALTERA_SYNTHESIZED0[2] | out_R_ALTERA_SYNTHESIZED0[0]);


mux_4x1	b2v_R0_sel_mux(
	.in0(SYNTHESIZED_WIRE_19),
	.in1(acc_out),
	.in2(q_out),
	.in3(data_in),
	.sel(R0_sel),
	.out(SYNTHESIZED_WIRE_15));
	defparam	b2v_R0_sel_mux.W = 4;


register_we	b2v_R1(
	.clk(clk),
	.reset(R1_rst),
	.en(R1_en),
	.in(SYNTHESIZED_WIRE_17),
	.out(SYNTHESIZED_WIRE_10));
	defparam	b2v_R1.W = 4;


mux_4x1	b2v_R1_sel_mux(
	.in0(SYNTHESIZED_WIRE_19),
	.in1(acc_out),
	.in2(q_out),
	
	.sel(R1_sel),
	.out(SYNTHESIZED_WIRE_17));
	defparam	b2v_R1_sel_mux.W = 4;

assign	SYNTHESIZED_WIRE_14 = out_R_ALTERA_SYNTHESIZED0[3] ^ out_R_ALTERA_SYNTHESIZED1;

assign	q_lsb = q_out[0];
assign	r1_s = out_R_ALTERA_SYNTHESIZED1;
assign	r0_s = out_R_ALTERA_SYNTHESIZED0[3];
assign	out_erre = out_erre_ALTERA_SYNTHESIZED;
assign	out_R0 = out_R_ALTERA_SYNTHESIZED0;

endmodule
