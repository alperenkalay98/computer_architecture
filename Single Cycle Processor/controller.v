module controller(clk,cond,op,funct,ALU_flags,pc_src,reg_A2src,regWrite,immsrc,alu_srcB,alu_op,shift_dir,memWrite,aluorshft,memtoreg);
	input clk;
	input [3:0] cond;
	input [1:0] op;
	input [5:0] funct;
	input [3:0] ALU_flags;
	output wire [2:0] alu_op;
	output wire pc_src,reg_A2src,regWrite,immsrc,alu_srcB,shift_dir,memWrite,aluorshft,memtoreg;
	
	wire flag_en,pcs_pcsrc,regw_regWrite,memW_memWrite;
	
	controller_decoder cd(.op(op),
								 .funct(funct),
								 .flagW(flag_en),
								 .pcs(pcs_pcsrc),
								 .reg_A2src(reg_A2src),
								 .regW(regw_regWrite),
								 .immsrc(immsrc),
								 .alu_srcB(alu_srcB),
								 .alu_op(alu_op),
								 .shift_dir(shift_dir),
								 .memW(memW_memWrite),
								 .aluorshft(aluorshft),
								 .memtoreg(memtoreg)
								 );
									
	controller_conditional_logic ccl(.clk(clk),
											  .ALU_flags(ALU_flags),
											  .cond(cond),
											  .flagW(flag_en),
											  .pcs(pcs_pcsrc),
											  .regW(regw_regWrite),
											  .memW(memW_memWrite),
											  .pc_src(pc_src),
											  .regWrite(regWrite),
											  .memWrite(memWrite)
											  );
											
endmodule
