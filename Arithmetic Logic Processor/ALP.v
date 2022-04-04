module ALP (clk,data_in,op,load,comp,clr,out_0,out_1,err);
	input clk,load,comp,clr;
	input [3:0] data_in;
	input [2:0] op;
	output wire [3:0] out_0,out_1;
	output wire err;
	
	wire [1:0] r0sel;
	wire [1:0] r1sel;
	wire r0en;
	wire r1en;
	wire r0rst;
	wire r1rst;
	wire alusrca;
	wire [1:0] alusrcb;
	wire accen;
	wire qen;
	wire esel;
	wire accloadsel;
	wire accdirsel;
	wire qloadsel;
	wire qdirsel;
	wire accrst;
	wire qrst;
	wire asen;
	wire qsen;
	wire erreen;
	wire errerst;
	wire qn1rst;
	wire [2:0] alucontrol;
	wire [1:0] errehold;
	wire qshold;
	wire ashold;
	wire qlsb;
	wire qn1reg;
	wire r0s;
	wire r1s;
	wire [3:0] r0out;
	wire [3:0] r1out;
	
	assign err=errehold[1];
	assign out_0=r0out;
	assign out_1=r1out;
	
	
	controller CU(
					.clk(clk),
					.op(op),
					.load(load),
					.comp(comp),
					.clr(clr),
					.e(errehold[0]),
					.R0_en(r0en),
					.R0_rst(r0rst),
					.R1_en(r1en),
					.R1_rst(r1rst),
					.R0_sel(r0sel),
					.R1_sel(r1sel),
					.alu_srcA(alusrca),
					.alu_srcB(alusrcb),
					.e_sel(esel),
					.acc_rst(accrst),
					.acc_load_sel(accloadsel),
					.acc_dir_sel(accdirsel),
					.q_load_sel(qloadsel),
					.q_dir_sel(qdirsel),
					.qs(qshold),
					.qs_en(qsen),
					.alu_control(alucontrol),
					.q_n1_rst(qn1rst),
					.q_lsb(qlsb),
					.q_n1_reg(qn1reg),
					.acc_en(accen),
					.q_en(qen),
					.q_rst(qrst),
					.as(ashold),
					.as_en(asen),
					.r1_s(r1s),
					.r0_s(r0s),
					.erre_en(erreen),
					.erre_rst(errerst)
					);
	
	datapath DP(
					.clk(clk),
					.R0_rst(r0rst),
					.R0_en(r0en),
					.R1_rst(r1rst),
					.R1_en(r1en),
					.alu_srcA_sel(alusrca),
					.acc_rst(accrst),
					.q_rst(qrst),
					.acc_en(accen),
					.acc_load_sel(accloadsel),
					.acc_dir_sel(accdirsel),
					.q_load_sel(qloadsel),
					.q_dir_sel(qdirsel),
					.q_en(qen),
					.q_n1_rst(qn1rst),
					.qs_en(qsen),
					.erre_rst(errerst),
					.erre_en(erreen),
					.as_en(asen),
					.e_sel(esel),
					.alu_control(alucontrol),
					.alu_srcB_sel(alusrcb),
					.data_in(data_in),
					.R0_sel(r0sel),
					.R1_sel(r1sel),
					.zero(4'b0000),
					.zero9(4'b0000),
					.q_n1_reg(qn1reg),
					.qs(qshold),
					.as(ashold),
					.q_lsb(qlsb),
					.r1_s(r1s),
					.r0_s(r0s),
					.out_erre(errehold),
					.out_R0(r0out),
					.out_R1(r1out)
					);
	
endmodule
