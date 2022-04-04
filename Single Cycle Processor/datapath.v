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
// CREATED		"Sat May 01 18:36:14 2021"

module datapath(
	reg_Write,
	alu_srcB,
	shift_dir,
	mem_Write,
	alu_or_shift,
	mem_to_reg,
	clk,
	A2src,
	pcsrc,
	extend_length,
	pc_reset,
	alu_op,
	aluflags,
	cond,
	funct,
	op
);


input wire	reg_Write;
input wire	alu_srcB;
input wire	shift_dir;
input wire	mem_Write;
input wire	alu_or_shift;
input wire	mem_to_reg;
input wire	clk;
input wire	A2src;
input wire	pcsrc;
input wire	extend_length;
input wire	pc_reset;
input wire	[2:0] alu_op;
output wire	[3:0] aluflags;
output wire	[3:0] cond;
output wire	[5:0] funct;
output wire	[1:0] op;

wire	[3:0] aluflags_ALTERA_SYNTHESIZED;
wire	[31:0] instr;
wire	[31:0] SYNTHESIZED_WIRE_21;
wire	[31:0] SYNTHESIZED_WIRE_22;
wire	[31:0] SYNTHESIZED_WIRE_23;
wire	[31:0] SYNTHESIZED_WIRE_3;
wire	[31:0] SYNTHESIZED_WIRE_24;
wire	[31:0] SYNTHESIZED_WIRE_5;
wire	[31:0] SYNTHESIZED_WIRE_25;
wire	[31:0] SYNTHESIZED_WIRE_9;
wire	[31:0] SYNTHESIZED_WIRE_10;
wire	[31:0] SYNTHESIZED_WIRE_11;
wire	[31:0] SYNTHESIZED_WIRE_26;
wire	[3:0] SYNTHESIZED_WIRE_14;
wire	[31:0] SYNTHESIZED_WIRE_15;
wire	[31:0] SYNTHESIZED_WIRE_27;





add_four	b2v_adder4_1(
	.in(SYNTHESIZED_WIRE_21),
	.out(SYNTHESIZED_WIRE_22));


add_four	b2v_adder4_2(
	.in(SYNTHESIZED_WIRE_22),
	.out(SYNTHESIZED_WIRE_15));


ALU	b2v_alu(
	.A(SYNTHESIZED_WIRE_23),
	.B(SYNTHESIZED_WIRE_3),
	.control(alu_op),
	.C(aluflags_ALTERA_SYNTHESIZED[1]),
	.V(aluflags_ALTERA_SYNTHESIZED[0]),
	.N(aluflags_ALTERA_SYNTHESIZED[3]),
	.Z(aluflags_ALTERA_SYNTHESIZED[2]),
	.out(SYNTHESIZED_WIRE_24));
	defparam	b2v_alu.W = 32;


mux_2x1	b2v_aluorshft(
	.sel(alu_or_shift),
	.in0(SYNTHESIZED_WIRE_24),
	.in1(SYNTHESIZED_WIRE_5),
	.out(SYNTHESIZED_WIRE_10));
	defparam	b2v_aluorshft.W = 32;


data_mem	b2v_datamem(
	.clk(clk),
	.WE(mem_Write),
	.A(SYNTHESIZED_WIRE_24),
	.WD(SYNTHESIZED_WIRE_25),
	.RD(SYNTHESIZED_WIRE_9));


extend	b2v_inst1(
	.len_sel(extend_length),
	.in(instr[11:0]),
	.out(SYNTHESIZED_WIRE_27));


instr_mem	b2v_instmem(
	.in(SYNTHESIZED_WIRE_21),
	.out(instr));


mux_2x1	b2v_memtoreg(
	.sel(mem_to_reg),
	.in0(SYNTHESIZED_WIRE_9),
	.in1(SYNTHESIZED_WIRE_10),
	.out(SYNTHESIZED_WIRE_26));
	defparam	b2v_memtoreg.W = 32;


register_r	b2v_PC(
	.clk(clk),
	.reset(pc_reset),
	.in(SYNTHESIZED_WIRE_11),
	.out(SYNTHESIZED_WIRE_21));
	defparam	b2v_PC.W = 32;


mux_2x1	b2v_PC_src(
	.sel(pcsrc),
	.in0(SYNTHESIZED_WIRE_26),
	.in1(SYNTHESIZED_WIRE_22),
	.out(SYNTHESIZED_WIRE_11));
	defparam	b2v_PC_src.W = 32;


mux_2x1	b2v_reg_A2src(
	.sel(A2src),
	.in0(instr[3:0]),
	.in1(instr[15:12]),
	.out(SYNTHESIZED_WIRE_14));
	defparam	b2v_reg_A2src.W = 4;


register_file	b2v_regfile(
	.CLK(clk),
	.WE3(reg_Write),
	.A1(instr[19:16]),
	.A2(SYNTHESIZED_WIRE_14),
	.A3(instr[15:12]),
	.R15(SYNTHESIZED_WIRE_15),
	.WD3(SYNTHESIZED_WIRE_26),
	.RD1(SYNTHESIZED_WIRE_23),
	.RD2(SYNTHESIZED_WIRE_25));


shifter	b2v_shifter(
	.dir_sel(shift_dir),
	.A(SYNTHESIZED_WIRE_23),
	.B(SYNTHESIZED_WIRE_27),
	.out(SYNTHESIZED_WIRE_5));


mux_2x1	b2v_srcB(
	.sel(alu_srcB),
	.in0(SYNTHESIZED_WIRE_25),
	.in1(SYNTHESIZED_WIRE_27),
	.out(SYNTHESIZED_WIRE_3));
	defparam	b2v_srcB.W = 32;

assign	aluflags = aluflags_ALTERA_SYNTHESIZED;
assign	cond[3:0] = instr[31:28];
assign	funct[5:0] = instr[25:20];
assign	op[1:0] = instr[27:26];

endmodule
