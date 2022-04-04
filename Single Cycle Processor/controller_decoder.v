module controller_decoder(op,funct,flagW,pcs,reg_A2src,regW,immsrc,alu_srcB,alu_op,shift_dir,memW,aluorshft,memtoreg);
	input [1:0] op;
	input [5:0] funct;
	output reg pcs,reg_A2src,regW,immsrc,alu_srcB,shift_dir,flagW,memW,aluorshft,memtoreg;
	output reg [2:0] alu_op;
	
	parameter add=6'b001000,sub=6'b000100,and_op=6'b000000,orr=6'b011000,lsr=6'b111110,lsl=6'b111100,cmp=6'b010101;
	parameter str=6'b011000,ldr=6'b011001;
	
	always @(*)begin
		pcs=1;
		case(op)
			2'b00:begin
						reg_A2src=0;
						immsrc=0;
						alu_srcB=0;
						memW=0;
						memtoreg=1;
						
						if(funct==cmp)begin
							regW=0;
							flagW=1;
						end else begin
							regW=1;
							flagW=0;
						end
						
						if(funct==lsr)begin
							shift_dir=1;
							aluorshft=1;
						end else if(funct==lsl)begin
							shift_dir=0;
							aluorshft=1;
						end else begin
							shift_dir=0;
							aluorshft=0;
						end
					
						case(funct)
							add: alu_op=3'b000;
							sub: alu_op=3'b001;
							and_op: alu_op=3'b100;
							orr: alu_op=3'b101;
							lsr: alu_op=3'b000;
							lsl: alu_op=3'b000;
							cmp: alu_op=3'b001;
						endcase
					end
			
			2'b01:begin
						reg_A2src=1;
						immsrc=1;
						alu_srcB=1;
						alu_op=3'b000;
						shift_dir=0;
						aluorshft=0;
						memtoreg=0;
						flagW=0;
						
						if(funct==str)begin
							regW=0;
							memW=1;
						end else if(funct==ldr)begin
							regW=1;
							memW=0;
						end
						
					end				
				
		endcase
	end
	
endmodule
