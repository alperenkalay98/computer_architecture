module multi_cycle_CPU(clk);
	input clk;
	reg RESET,RUN;
	
	wire[4:0] ins_w;
	wire[3:0] alu_flags_w,regsrc_w;
	wire[2:0] ins3_w,alu_cont_w,shft_op_w;
	wire[1:0] alu_src_b_w,imm_src_w,res_src_w;
	wire adr_src_w,mem_w_w,ir_w_w,reg_w_w,alu_src_a_w,pc_w_w;
	
	wire [3:0] ALU_flags_w;
	wire[7:0] link_reg_w,reg1_w,reg2_w;
	wire[7:0] mem_32_w;
	
initial begin
	RESET=1; #25;
	RESET=0; #25;
	RUN=1;
end

control_unit CU(.clk(clk),
					 .instr(ins_w),
					 .inst3(ins3_w),
					 .alu_flags(alu_flags_w),
					 .adr_source(adr_src_w),
					 .mem_Write(mem_w_w),
					 .ir_Write(ir_w_w),
					 .reg_Write(reg_w_w),
					 .alu_srcA(alu_src_a_w),
					 .pc_Write(pc_w_w),
					 .RESET(RESET),
					 .RUN(RUN),
					 .alu_control(alu_cont_w),
					 .alu_srcB(alu_src_b_w),
					 .imm_src(imm_src_w),
					 .RegSrc(regsrc_w),
					 .result_src(res_src_w),
					 .shft_op(shft_op_w),
					 .ALU_flags(ALU_flags_w)
					 );
					
datapath DU(.adr_source(adr_src_w),
				.mem_Write(mem_w_w),
				.ir_Write(ir_w_w),
				.reg_Write(reg_w_w),
				.alu_srcA(alu_src_a_w),
				.clk(clk),
				.pc_Write(pc_w_w),
				.reset(RESET),
				.alu_control(alu_cont_w),
				.alu_srcB(alu_src_b_w),
				.imm_src(imm_src_w),
				.RegSrc(regsrc_w),
				.result_src(res_src_w),
				.shft_op(shft_op_w),
				.alu_flags(alu_flags_w),
				.instruction(ins_w),
				.link_reg(link_reg_w),
				.mem_32(mem_32_w),
				.reg1(reg1_w),
				.reg2(reg2_w),
				.shiftop(ins3_w)
				);
				
endmodule
