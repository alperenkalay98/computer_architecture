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
// CREATED		"Thu Jun 10 21:13:49 2021"

module datapath(
	adr_source,
	mem_Write,
	ir_Write,
	reg_Write,
	alu_srcA,
	clk,
	pc_Write,
	reset,
	alu_control,
	alu_srcB,
	imm_src,
	RegSrc,
	result_src,
	shft_op,
	alu_flags,
	instruction,
	link_reg,
	mem_32,
	reg1,
	reg2,
	shiftop
);


input wire	adr_source;
input wire	mem_Write;
input wire	ir_Write;
input wire	reg_Write;
input wire	alu_srcA;
input wire	clk;
input wire	pc_Write;
input wire	reset;
input wire	[2:0] alu_control;
input wire	[1:0] alu_srcB;
input wire	[1:0] imm_src;
input wire	[3:0] RegSrc;
input wire	[1:0] result_src;
input wire	[2:0] shft_op;
output wire	[3:0] alu_flags;
output wire	[4:0] instruction;
output wire	[7:0] link_reg;
output wire	[7:0] mem_32;
output wire	[7:0] reg1;
output wire	[7:0] reg2;
output wire	[2:0] shiftop;

wire	[3:0] alu_flags_ALTERA_SYNTHESIZED;
wire	[13:0] instr;
wire	[13:0] mem_value;
wire	[2:0] SYNTHESIZED_WIRE_0;
wire	[2:0] SYNTHESIZED_WIRE_1;
wire	[7:0] SYNTHESIZED_WIRE_30;
wire	[7:0] SYNTHESIZED_WIRE_31;
wire	[7:0] SYNTHESIZED_WIRE_4;
wire	[7:0] SYNTHESIZED_WIRE_32;
wire	[7:0] SYNTHESIZED_WIRE_33;
wire	[7:0] SYNTHESIZED_WIRE_7;
wire	[7:0] SYNTHESIZED_WIRE_34;
wire	[2:0] SYNTHESIZED_WIRE_10;
wire	[2:0] SYNTHESIZED_WIRE_11;
wire	[2:0] SYNTHESIZED_WIRE_12;
wire	[7:0] SYNTHESIZED_WIRE_14;
wire	[7:0] SYNTHESIZED_WIRE_16;
wire	[7:0] SYNTHESIZED_WIRE_17;
wire	[7:0] SYNTHESIZED_WIRE_18;
wire	[7:0] SYNTHESIZED_WIRE_35;
wire	[7:0] SYNTHESIZED_WIRE_21;
wire	[7:0] SYNTHESIZED_WIRE_23;
wire	[7:0] SYNTHESIZED_WIRE_25;
wire	[7:0] SYNTHESIZED_WIRE_27;





mux_2x1	b2v_a1_sel(
	.sel(RegSrc[3]),
	.in0(instr[5:3]),
	.in1(SYNTHESIZED_WIRE_0),
	.out(SYNTHESIZED_WIRE_10));
	defparam	b2v_a1_sel.W = 3;


mux_2x1	b2v_a2_sel(
	.sel(RegSrc[2]),
	.in0(instr[2:0]),
	.in1(instr[8:6]),
	.out(SYNTHESIZED_WIRE_11));
	defparam	b2v_a2_sel.W = 3;


mux_2x1	b2v_a3_sel(
	.sel(RegSrc[1]),
	.in0(instr[8:6]),
	.in1(SYNTHESIZED_WIRE_1),
	.out(SYNTHESIZED_WIRE_12));
	defparam	b2v_a3_sel.W = 3;


mux_2x1	b2v_adr_sel(
	.sel(adr_source),
	.in0(SYNTHESIZED_WIRE_30),
	.in1(SYNTHESIZED_WIRE_31),
	.out(SYNTHESIZED_WIRE_7));
	defparam	b2v_adr_sel.W = 8;


ALU	b2v_alu(
	.A(SYNTHESIZED_WIRE_4),
	.B(SYNTHESIZED_WIRE_32),
	.control(alu_control),
	.N(alu_flags_ALTERA_SYNTHESIZED[3]),
	.Z(alu_flags_ALTERA_SYNTHESIZED[2]),
	.C(alu_flags_ALTERA_SYNTHESIZED[1]),
	.V(alu_flags_ALTERA_SYNTHESIZED[0]),
	.out(SYNTHESIZED_WIRE_33));
	defparam	b2v_alu.W = 8;


register_simple	b2v_alu_res_reg(
	.clk(clk),
	.reset(reset),
	.in(SYNTHESIZED_WIRE_33),
	.out(SYNTHESIZED_WIRE_18));
	defparam	b2v_alu_res_reg.W = 8;


register_simple	b2v_data(
	.clk(clk),
	.reset(reset),
	.in(mem_value[7:0]),
	.out(SYNTHESIZED_WIRE_35));
	defparam	b2v_data.W = 8;


extend	b2v_extend(
	.in(instr[7:0]),
	.len_sel(imm_src),
	.out(SYNTHESIZED_WIRE_25));


idm	b2v_inst(
	.clk(clk),
	.memWrite(mem_Write),
	.adr(SYNTHESIZED_WIRE_7),
	.WD(SYNTHESIZED_WIRE_34),
	.mem32(mem_32),
	.out(mem_value));


shif_unit	b2v_inst1(
	.clk(clk),
	.in(SYNTHESIZED_WIRE_32),
	.op(shft_op),
	.out(SYNTHESIZED_WIRE_21));


register_file	b2v_inst4(
	.clk(clk),
	.reset(reset),
	.WE3(reg_Write),
	.A1(SYNTHESIZED_WIRE_10),
	.A2(SYNTHESIZED_WIRE_11),
	.A3(SYNTHESIZED_WIRE_12),
	.R7(SYNTHESIZED_WIRE_31),
	.WD3(SYNTHESIZED_WIRE_14),
	.RD1(SYNTHESIZED_WIRE_16),
	.RD2(SYNTHESIZED_WIRE_17),
	.tbout1(reg1),
	.tbout2(reg2),
	.tbout6(link_reg));


register_we	b2v_ir(
	.clk(clk),
	.reset(reset),
	.en(ir_Write),
	.in(mem_value),
	.out(instr));
	defparam	b2v_ir.W = 14;


register_we	b2v_pc(
	.clk(clk),
	.reset(reset),
	.en(pc_Write),
	.in(SYNTHESIZED_WIRE_31),
	.out(SYNTHESIZED_WIRE_30));
	defparam	b2v_pc.W = 8;


constant_value_generator2	b2v_pc_add_one(
	.out(SYNTHESIZED_WIRE_27));
	defparam	b2v_pc_add_one.D = 8'b00000001;


register_simple	b2v_rd1_reg(
	.clk(clk),
	.reset(reset),
	.in(SYNTHESIZED_WIRE_16),
	.out(SYNTHESIZED_WIRE_23));
	defparam	b2v_rd1_reg.W = 8;


register_simple	b2v_rd2_reg(
	.clk(clk),
	.reset(reset),
	.in(SYNTHESIZED_WIRE_17),
	.out(SYNTHESIZED_WIRE_34));
	defparam	b2v_rd2_reg.W = 8;


mux_4x1	b2v_result_mux(
	.in0(SYNTHESIZED_WIRE_18),
	.in1(SYNTHESIZED_WIRE_35),
	.in2(SYNTHESIZED_WIRE_33),
	.in3(SYNTHESIZED_WIRE_21),
	.sel(result_src),
	.out(SYNTHESIZED_WIRE_31));
	defparam	b2v_result_mux.W = 8;


constant_value_generator	b2v_seven(
	.out(SYNTHESIZED_WIRE_0));
	defparam	b2v_seven.D = 3'b111;


constant_value_generator	b2v_six(
	.out(SYNTHESIZED_WIRE_1));
	defparam	b2v_six.D = 3'b110;


mux_2x1	b2v_srcA_mux(
	.sel(alu_srcA),
	.in0(SYNTHESIZED_WIRE_30),
	.in1(SYNTHESIZED_WIRE_23),
	.out(SYNTHESIZED_WIRE_4));
	defparam	b2v_srcA_mux.W = 8;


mux_4x1	b2v_srcB_mux(
	.in0(SYNTHESIZED_WIRE_34),
	.in1(SYNTHESIZED_WIRE_25),
	.in2(SYNTHESIZED_WIRE_35),
	.in3(SYNTHESIZED_WIRE_27),
	.sel(alu_srcB),
	.out(SYNTHESIZED_WIRE_32));
	defparam	b2v_srcB_mux.W = 8;


mux_2x1	b2v_wd_sel(
	.sel(RegSrc[0]),
	.in0(SYNTHESIZED_WIRE_30),
	.in1(SYNTHESIZED_WIRE_31),
	.out(SYNTHESIZED_WIRE_14));
	defparam	b2v_wd_sel.W = 8;

assign	alu_flags = alu_flags_ALTERA_SYNTHESIZED;
assign	instruction[4:0] = instr[13:9];
assign	shiftop[2:0] = instr[2:0];

endmodule
