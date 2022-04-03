module tb_controller();
	reg clk;
	reg [2:0] op;
	reg load,comp,clr;
	reg q_lsb,q_n1_reg,r1_s,r0_s,e,as,qs;
	
	reg [1:0] R0_sel_exp,R1_sel_exp,alu_srcB_exp;
	reg R0_en_exp,R1_en_exp,R0_rst_exp,R1_rst_exp,alu_srcA_exp,e_sel_exp,acc_en_exp,q_en_exp,q_rst_exp,as_en_exp,erre_en_exp,erre_rst_exp;
	reg acc_load_sel_exp,acc_dir_sel_exp,q_load_sel_exp,q_dir_sel_exp,qs_en_exp,acc_rst_exp,q_n1_rst_exp;
	reg [2:0] alu_control_exp;
	wire [1:0] R0_sel,R1_sel,alu_srcB;
	wire R0_en,R1_en,R0_rst,R1_rst,alu_srcA,e_sel,acc_en,q_en,q_rst,as_en,erre_en,erre_rst;
	wire acc_load_sel,acc_dir_sel,q_load_sel,q_dir_sel,qs_en,acc_rst,q_n1_rst;
	wire [2:0] alu_control;
	
	reg [12:0] vectornum; 
	reg [40:0] testvectors[12:0]; 
	
	controller  dut(
					clk,
					op,
					load,
					comp,
					clr,
					e,
					R0_en,
					R0_rst,
					R1_en,
					R1_rst,
					R0_sel,
					R1_sel,
					alu_srcA,
					alu_srcB,
					e_sel,
					acc_rst,
					acc_load_sel,
					acc_dir_sel,
					q_load_sel,
					q_dir_sel,
					qs,
					qs_en,
					alu_control,
					q_n1_rst,
					q_lsb,
					q_n1_reg,
					acc_en,
					q_en,
					q_rst,
					as,
					as_en,
					r1_s,
					r0_s,
					erre_en,
					erre_rst);
	
	
	always 
	begin
		clk = 0; #25; clk = 1; #25;
	end

	initial
		begin
		$readmemb("testvector_controller.tv", testvectors);
		vectornum = 0; 
	end
	
	always @(negedge clk)
		begin
	   {op,load,comp,clr,e,R0_en_exp,R0_rst_exp,R1_en_exp,R1_rst_exp,R0_sel_exp,R1_sel_exp,alu_srcA_exp,alu_srcB_exp,e_sel_exp,acc_rst_exp,acc_load_sel_exp,acc_dir_sel_exp,q_load_sel_exp,q_dir_sel_exp,qs,qs_en_exp,alu_control_exp,q_n1_rst_exp,q_lsb,q_n1_reg,acc_en_exp,q_en_exp,q_rst_exp,as,as_en_exp,r1_s,r0_s,erre_en_exp,erre_rst_exp} = testvectors[vectornum];
		end
	//load,clr,add,xor,mul1,mul4,mul2,mul4,mul3 in testvectors
	
	always @(posedge clk)
		begin
			vectornum = vectornum + 1;
			if (vectornum == 5'b01101) begin 
				$display("%d tests completed ",vectornum);
				$stop;
			end
		end
endmodule 