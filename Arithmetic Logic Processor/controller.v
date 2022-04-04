module controller (
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
	erre_rst
	);
	
	input clk;
	input [2:0] op;
	input load,comp,clr;
	input q_lsb,q_n1_reg,r1_s,r0_s,e,as,qs;
	output reg [1:0] R0_sel,R1_sel,alu_srcB;
	output reg R0_en,R1_en,R0_rst,R1_rst,alu_srcA,e_sel,acc_en,q_en,q_rst,as_en,erre_en,erre_rst;
	output reg acc_load_sel,acc_dir_sel,q_load_sel,q_dir_sel,qs_en,acc_rst,q_n1_rst;
	output reg [2:0] alu_control;
	
	reg [2:0] SC;
	reg [4:0] state,next_state;
	parameter s_idle=5'b00000,s_add=5'b00001,s_sub=5'b00010,s_mul1=5'b00011,s_mul2=5'b00100,s_mul3=5'b00101,
				 s_mul4=5'b00110,s_mul5=5'b00111,s_div1=5'b01000,s_div2=5'b01001,s_div3=5'b01010,s_div4=5'b01011,
				 s_div5=5'b01100,s_div6=5'b01101,s_div7=5'b01110,s_div8=5'b01111,s_div9=5'b10000,s_div10=5'b10001,
				 s_div11=5'b10010,s_clr=5'b10011,s_load=5'b10100,s_and=5'b10101,s_or=5'b10110,s_xor=5'b10111,s_bitclr=5'b11000;
				 
	
	initial begin
		state=s_idle;
	end
	
	always @(posedge clk)
		begin
			state <= next_state;
		end
	
	always @(*)
		begin
			case(state)
			
				s_idle:
					begin
						if(comp==1 & op==3'b000)
							next_state=s_add;
						else if(comp==1 & op==3'b001)
							next_state=s_sub;
						else if(comp==1 & op==3'b010)
							next_state=s_mul1;
						else if(comp==1 & op==3'b011)
							next_state=s_div1;
						else if(comp==1 & op==3'b100)
							next_state=s_and;
						else if(comp==1 & op==3'b101)
							next_state=s_or;
						else if(comp==1 & op==3'b110)
							next_state=s_xor;
						else if(comp==1 & op==3'b111)
							next_state=s_bitclr;
						else if(comp==0 & clr==1)
							next_state=s_clr;
						else if(comp==0 & clr==0 & load==1)
							next_state=s_load;
							
						R0_en=0;
						R1_en=0;
						R0_rst=0;
						R1_rst=0;
						acc_en=0;
						q_en=0;
						qs_en=0;
						acc_rst=0;
						q_rst=0;
						q_n1_rst=0;
						erre_en=0;
						R0_sel=2'b00;
						R1_sel=2'b00;
						alu_srcB=2'b00;
						e_sel=0;
						alu_srcA=0;
						as_en=0;
						erre_en=0;
						erre_rst=0;
						acc_load_sel=0;
						acc_dir_sel=0;
						q_load_sel=0;
						q_dir_sel=0;
					end
				
				s_add:
					begin
						next_state=s_idle;
						R0_en=1;
						R1_rst=1;
						R0_sel=2'b00;
						alu_srcA=1;
						alu_srcB=2'b11;
						alu_control=3'b000;
					end
				
				s_sub:
					begin
						next_state=s_idle;
						R0_en=1;
						R1_rst=1;
						R0_sel=2'b00;
						alu_srcA=1;
						alu_srcB=2'b11;
						alu_control=3'b001;
					end
				
				s_mul1:
					begin
						acc_rst=1;
						alu_control=3'b000;
						alu_srcA=0;
						alu_srcB=2'b11;
						q_en=1;
						q_load_sel=1;
						q_n1_rst=1;
						SC=3'b100;
						
						if({q_lsb,q_n1_reg} == 2'b00)
							next_state=s_mul4;
						else if ({q_lsb,q_n1_reg} == 2'b11)
							next_state=s_mul4;
						else if ({q_lsb,q_n1_reg} == 2'b01)
							next_state=s_mul3;
						else if ({q_lsb,q_n1_reg} == 2'b10)
							next_state=s_mul2;
							
					end
				
				s_mul2:
					begin
						next_state=s_mul4;
						alu_srcB=2'b01; //acc
						acc_rst=0;
						acc_en=1;
						q_n1_rst=0;
						q_en=0;
						alu_srcA=1;
						alu_control=3'b010;  //acc-r0
						acc_load_sel=1;		//acc will be loaded with acc-r0
					end
					
				s_mul3:
					begin
						next_state=s_mul4;
						alu_srcB=2'b01; //acc
						acc_rst=0;
						acc_en=1;
						q_n1_rst=0;
						q_en=0;
						alu_srcA=1;
						alu_control=3'b000;  //acc+r0
						acc_load_sel=1;		//acc will be loaded with acc+r0
					end
				
				s_mul4:
					begin
						acc_rst=0;
						acc_en=1;
						q_n1_rst=0;
						q_en=1;
						acc_load_sel=0;
						acc_dir_sel=1;
						q_load_sel=0;
						q_dir_sel=1;
						SC=SC-1;
						
						if(SC==3'b000)
							next_state=s_mul5;
						else if({q_lsb,q_n1_reg} == 2'b00 | {q_lsb,q_n1_reg} == 2'b11)
							next_state=s_mul4;
						else if ({q_lsb,q_n1_reg} == 2'b01)
							next_state=s_mul3;
						else if ({q_lsb,q_n1_reg} == 2'b10)
							next_state=s_mul2;
						
					end
					
				s_mul5:
					begin
						acc_en=0;
						q_en=0;
						R0_en=1;
						R1_en=1;
						R0_sel=2'b10;
						R1_sel=2'b01;
						next_state=s_idle;
					end
				
				s_div1:
					begin
						qs_en=1;
						as_en=1;
						SC=3'b100;
						
						if(r1_s==1)
							next_state=s_div2;
						else if(r1_s==0 & r0_s==1)
							next_state=s_div3;
						else if(r1_s==0 & r0_s==0)
							next_state=s_div4;
					end
		
				s_div2:
					begin
						R1_en=1;
						R1_sel=2'b00;
						alu_srcA=1;
						alu_srcB=2'b00;
						alu_control=3'b010;   // (b-a) 0-r1
						
						if(r0_s==1)
							next_state=s_div3;
						else
							next_state=s_div4;
					
					end
					
				s_div3:
					begin
						R1_en=0;
						R0_en=1;
						R0_sel=2'b00;
						alu_srcA=0;
						alu_srcB=2'b11;
						alu_control=3'b001;  // (a-b) 0-r0
						next_state=s_div4;
					end
					
				s_div4:
					begin
						R0_en=0;
						acc_rst=1;
						q_en=1;
						alu_srcA=0;
						alu_srcB=2'b11;
						alu_control=3'b000;  //0+r1
						q_load_sel=1;        // q will be loaded with r1
						next_state=s_div5;
					end
		
				s_div5:
					begin
						acc_rst=0;
						acc_en=1;
						q_en=1;
						acc_load_sel=0;
						q_load_sel=0;
						acc_dir_sel=0;
						q_dir_sel=0;
						e_sel=0;
						erre_en=1;
						next_state=s_div6;
					end
				
				s_div6:
					begin
						acc_en=1;
						q_en=0;
						erre_en=1;
						alu_srcA=1;
						alu_srcB=2'b00;
						alu_control=3'b010;   //b-a  acc-r0
						acc_load_sel=1;
						
						if(e==0)
							next_state=s_div7;
						else
							next_state=s_div8;
							
					end
					
					
				s_div7:
					begin
						acc_en=1;
						erre_en=1;
						q_en=0;
						alu_srcA=1;
						alu_srcB=2'b00;
						alu_control=3'b000;   //a+b  acc+r0
						acc_load_sel=1;
						SC=SC-1;
						
						if(SC!=0)
							next_state=s_div5;
						else if(SC==0 & qs==1)
							next_state=s_div9;
						else if (SC==0 & qs==0 & as==1)
							next_state=s_div10;
						else if (SC==0 & qs==0 & as==0)
							next_state=s_div11;
							
					end
			
				s_div8:
					begin
						acc_en=0;
						erre_en=0;
						q_en=1;
						q_load_sel=1;
						SC=SC-1;
						
						if(SC!=0)
							next_state=s_div5;
						else if(SC==0 & qs==1)
							next_state=s_div9;
						else if (SC==0 & qs==0 & as==1)
							next_state=s_div10;
						else if (SC==0 & qs==0 & as==0)
							next_state=s_div11;
					end
				
				s_div9:
					begin
						acc_en=0;
						erre_en=0;
						q_en=1;
						q_load_sel=1;
						alu_srcA=0;
						alu_srcB=2'b10; //Q
						alu_control=3'b001; //a-b 0-Q
						
						if(as==1)
							next_state=s_div10;
						else
							next_state=s_div11;
					
					end
				
				s_div10:
					begin
						acc_en=1;
						acc_load_sel=1;
						erre_en=0;
						q_en=0;
						alu_srcA=0;
						alu_srcB=2'b01; //acc
						alu_control=3'b001; //a-b 0-acc
						next_state=s_div11;
					end
				
				s_div11:
					begin
						R0_en=1;
						R1_en=1;
						R0_sel=2'b01; //acc
						R1_sel=2'b10; //q
						acc_en=0;
						erre_en=0;
						q_en=0;
						next_state=s_idle;
					end
					
				s_and:
					begin
						R0_en=1;
						R1_en=0;
						R0_sel=2'b00; //alu
						R1_rst=1;
						alu_srcA=1;
						alu_srcB=2'b11;
						alu_control=3'b100;
						next_state=s_idle;
					end
				
				s_or:
					begin
						R0_en=1;
						R1_en=0;
						R0_sel=2'b00; //alu
						R1_rst=1;
						alu_srcA=1;
						alu_srcB=2'b11;
						alu_control=3'b101;
						next_state=s_idle;
					end
				
				s_xor:
					begin
						R0_en=1;
						R1_en=0;
						R0_sel=2'b00; //alu
						R1_rst=1;
						alu_srcA=1;
						alu_srcB=2'b11;
						alu_control=3'b110;
						next_state=s_idle;
					end
				
				s_bitclr:
					begin
						R0_en=1;
						R1_en=0;
						R0_sel=2'b00; //alu
						R1_rst=1;
						alu_srcA=1;
						alu_srcB=2'b11;
						alu_control=3'b011;
						next_state=s_idle;
					end
					
				s_clr:
					begin
						R0_rst=1;
						R1_rst=1;
						next_state=s_idle;
					end
					
				s_load:
					begin
						R0_en=1;
						R1_en=1;
						R0_sel=2'b11; //data in
						R1_sel=2'b00; //alu
						alu_srcA=1;
						alu_srcB=2'b00;
						alu_control=3'b000;  //r0+0
						next_state=s_idle;
					end
				
				default:
					begin
						next_state=s_idle;
					end
					
			endcase
		end
	
endmodule
