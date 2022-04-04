module single_cycle_processor(clk);
	input clk;
	wire [3:0] condwire;
	wire [1:0] opwire;
	wire [5:0] functwire;
	wire [3:0] alu_flags_wire;
	wire [3:0] alu_op_wire;
	wire PCSwire,reg_A2src_wire,regWrite_wire,immsrc_wire,alu_srcB_wire,shftdir_wire,memWrite_wire,aluorshft_wire,memtoreg_wire;
	
	reg pc_reset;
	initial begin
		pc_reset=1; #30;
		pc_reset=0;
	end
	
	controller CU(.clk(clk),
					  .cond(condwire),
					  .op(opwire),
					  .funct(functwire),
					  .ALU_flags(alu_flags_wire),
					  .pc_src(PCSwire),
					  .reg_A2src(reg_A2src_wire),
					  .regWrite(regWrite_wire),
					  .immsrc(immsrc_wire),
					  .alu_srcB(alu_srcB_wire),
					  .alu_op(alu_op_wire),
					  .shift_dir(shftdir_wire),
					  .memWrite(memWrite_wire),
					  .aluorshft(aluorshft_wire),
					  .memtoreg(memtoreg_wire)
						);
						
	datapath DP(.reg_Write(regWrite_wire),
					.alu_srcB(alu_srcB_wire),
					.shift_dir(shftdir_wire),
					.mem_Write(memWrite_wire),
					.alu_or_shift(aluorshft_wire),
					.mem_to_reg(memtoreg_wire),
					.clk(clk),
					.A2src(reg_A2src_wire),
					.pcsrc(PCSwire),
					.extend_length(immsrc_wire),
					.pc_reset(pc_reset),
					.alu_op(alu_op_wire),
					.aluflags(alu_flags_wire),
					.cond(condwire),
					.funct(functwire),
					.op(opwire)
					);
					
endmodule