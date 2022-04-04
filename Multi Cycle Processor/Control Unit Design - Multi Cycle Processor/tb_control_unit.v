module tb_control_unit();
	reg clk,RESET,RUN;
	reg [4:0] instr;
	reg [2:0] inst3;
	reg [3:0] alu_flags;
	
	wire adr_source,mem_Write,ir_Write,reg_Write,alu_srcA,pc_Write;
	wire [1:0] alu_srcB,imm_src,result_src;
	wire [2:0] shft_op;
	wire [3:0] RegSrc,ALU_flags;
	wire [2:0] alu_control;
	
	reg [3:0] vectornum;
	reg [11:0] testvectors [10:0];
	
	
	control_unit dut(
				clk,
				instr,
				inst3,
				alu_flags,
				adr_source,
				mem_Write,
				ir_Write,
				reg_Write,
				alu_srcA,
				pc_Write,
				RESET,
				RUN,
				alu_control,
				alu_srcB,
				imm_src,
				RegSrc,
				result_src,
				shft_op,
				ALU_flags
				);
	

always begin
	clk=0; #25; clk=1; #25;
end

initial begin
	RESET = 1; #30; RESET = 0; RUN = 1;
	$readmemb("testvector_controller.tv", testvectors);
	vectornum = 0; 
end

always @(negedge clk)
		begin
	   {instr,inst3,alu_flags} = testvectors[vectornum];
		end
	
	always @(posedge clk)
		begin
			vectornum = vectornum + 1;
			if (vectornum == 4'b1100) begin 
				$display("%d tests completed ",vectornum);
				$stop;
			end
		end
		
endmodule
