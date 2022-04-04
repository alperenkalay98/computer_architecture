module tb_datapath();
	reg adr_source;
	reg mem_Write;
	reg ir_Write;
	reg reg_Write;
	reg alu_srcA;
	reg clk;
	reg pc_Write;
	reg reset;
	reg [2:0] alu_control;
	reg [1:0] alu_srcB;
	reg [1:0] imm_src;
	reg [3:0] RegSrc;
	reg [1:0] result_src;
	reg [2:0] shft_op;
	
	reg [7:0] reg1_exp;
	wire[7:0] reg1;
	reg [7:0] reg2_exp;
	wire [7:0] reg2;
	wire [3:0] alu_flags;
	wire [7:0] pc_out;
	wire [7:0] alu_out;
	wire [7:0] ext_out;
	wire [7:0] reg_a_out;
	wire [7:0] shft_out;
	wire [7:0] link_reg;
	wire [7:0] mem_32;
	
	reg [4:0] vectornum;
	reg [37:0] testvectors [21:0];
	
	/*
	reg [4:0] vectornum;
	reg [37:0] testvectors [14:0];
	*/
	/*
	reg [4:0] vectornum;
	reg [37:0] testvectors [26:0];
	*/
	
	datapath dut(
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
				alu_out,
				ext_out,
				link_reg,
				mem_32,
				pc_out,
				reg1,
				reg2,
				reg_a_out,
				shft_out
				);
	

always begin
	clk=0; #25; clk=1; #25;
end

initial begin
	reset = 1; #30; reset = 0;
	$readmemb("testvector_datapath.tv", testvectors);
	vectornum = 0; 
end

always @(negedge clk)
		begin
	   {adr_source,mem_Write,ir_Write,reg_Write,alu_srcA,pc_Write,alu_control,alu_srcB,imm_src,RegSrc,result_src,shft_op,reg1_exp,reg2_exp} = testvectors[vectornum];
		end
	
	always @(posedge clk)
		begin
			vectornum = vectornum + 1;
			if (vectornum == 5'b11100) begin 
				$display("%d tests completed ",vectornum);
				$stop;
			end
		end
		
endmodule

