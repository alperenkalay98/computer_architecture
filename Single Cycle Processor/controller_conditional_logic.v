module controller_conditional_logic(clk,ALU_flags,cond,flagW,pcs,regW,memW,pc_src,regWrite,memWrite);
	input clk;
	input [3:0] ALU_flags;
	input [3:0] cond;
	input flagW,pcs,regW,memW;
	output wire pc_src,regWrite,memWrite;
	
	reg N,Z,C,V;
	initial begin
		N=0;
		Z=0;
		C=0;
		V=0;
	end
	
	assign pc_src = pcs & (cond==4'b0000);
	assign regWrite = regW & (cond==4'b0000);
	assign memWrite = memW & (cond==4'b0000);
	
	always @(*)begin
	
		if(flagW==1)begin
			N<=ALU_flags[3];
			Z<=ALU_flags[2];
			C<=ALU_flags[1];
			V<=ALU_flags[0];
		end
		
	end
	
	
endmodule
