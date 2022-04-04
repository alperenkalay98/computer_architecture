module control_unit(clk,instr,inst3,alu_flags,adr_source,mem_Write,ir_Write,reg_Write,alu_srcA,pc_Write,RESET,RUN,alu_control,alu_srcB,imm_src,RegSrc,result_src,shft_op,ALU_flags); 
input clk,RESET,RUN;
input [4:0] instr;
input [2:0] inst3;
input [3:0] alu_flags;
output reg adr_source,mem_Write,ir_Write,reg_Write,alu_srcA,pc_Write;
output reg [1:0] alu_srcB,imm_src,result_src;
output reg [2:0] alu_control,shft_op;
output reg [3:0] RegSrc;
output reg [3:0] ALU_flags;

reg [4:0] state,next_state;

parameter fetch=5'b00000,decode=5'b00001,execute=5'b00010,indirect_arith=5'b00011,indirect_execute=5'b10001,alu_WB=5'b00100,shift=5'b00101,shift_WB=5'b00110,
			 mem_adr=5'b00111,mem_read=5'b01000,mem_write=5'b01001,mem_WB=5'b01010,imm_load_value=5'b01011,imm_load_WB=5'b01100,
			 bun=5'b01101,b_link=5'b01110,b_ind=5'b01111,b_conds=5'b10000,s_end=5'b10010;


always @(posedge clk)begin
	if(RESET)
		state<=fetch;
	else
		state<=next_state;
end


always @(state or instr or RUN)begin
	case(state)
		fetch:begin
			if(RUN==1)begin
				next_state=decode;
				adr_source=0;
				mem_Write=0;
				ir_Write=1;
				reg_Write=0;
				alu_srcA=0;
				pc_Write=1;
				alu_srcB=2'b11;
				imm_src=2'b00;
				result_src=2'b10;
				alu_control=3'b000;
				shft_op=3'b000;
				RegSrc=4'b0000;
			end
		end
		
		decode:begin
			adr_source=0;
			mem_Write=0;
			ir_Write=0;
			reg_Write=0;
			alu_srcA=0;
			pc_Write=0;
			alu_srcB=2'b11;
			imm_src=2'b00;
			result_src=2'b10;
			alu_control=3'b000;
			shft_op=3'b000;
			
			case(instr)
				5'b00000,5'b00010,5'b00100,5'b00101,5'b00110,5'b00111:begin
					RegSrc=4'b0001;
					next_state=execute;
				end
				5'b00001,5'b00011:begin
					RegSrc=4'b0001;
					next_state=indirect_arith;
				end
				5'b01000,5'b01001,5'b01010,5'b01011:begin
					RegSrc=4'b0101;
					next_state=shift;
				end
				5'b10010:begin
					RegSrc=4'b1010;
					next_state=b_ind;
				end
				5'b10000:begin
					RegSrc=4'b1010;
					next_state=bun;
				end
				5'b10001:begin
					RegSrc=4'b1010;
					next_state=b_link;
				end
				5'b10100,5'b10101,5'b10110,5'b10111:begin
					RegSrc=4'b1010;
					next_state=b_conds;
				end
				5'b11000,5'b11010:begin
					RegSrc=4'b0101;
					next_state=mem_adr;
				end
				5'b11011:begin
					RegSrc=4'b0101;
					next_state=imm_load_value;
				end
			endcase
		end
		
		
		execute:begin
			next_state=alu_WB;
			adr_source=0;
			mem_Write=0;
			ir_Write=0;
			reg_Write=0;
			alu_srcA=1;
			pc_Write=0;
			alu_srcB=2'b00;
			imm_src=2'b00;
			result_src=2'b00;
			shft_op=3'b000;
			case(instr)
				5'b00000:alu_control=3'b001;	
				5'b00010:alu_control=3'b000;				
				5'b00100:alu_control=3'b100;			
				5'b00101:alu_control=3'b101;
				5'b00110:alu_control=3'b110;			
				5'b00111:alu_control=3'b111;
			endcase
		end
		
		alu_WB:begin
			next_state=fetch;
			ALU_flags=alu_flags;
			adr_source=0;
			mem_Write=0;
			ir_Write=0;
			reg_Write=1;
			alu_srcA=1;
			pc_Write=0;
			alu_srcB=2'b00;
			imm_src=2'b00;
			result_src=2'b00;
			shft_op=3'b000;
		end
		
		indirect_arith:begin
			next_state=indirect_execute;
			adr_source=1;
			mem_Write=0;
			ir_Write=0;
			reg_Write=0;
			alu_srcA=1;
			pc_Write=0;
			alu_srcB=2'b00;
			imm_src=2'b00;
			result_src=2'b10;
			alu_control=3'b011;
			shft_op=3'b000;
		end
		
		indirect_execute:begin
			next_state=alu_WB;
			adr_source=0;
			mem_Write=0;
			ir_Write=0;
			reg_Write=0;
			alu_srcA=1;
			pc_Write=0;
			alu_srcB=2'b10;
			imm_src=2'b00;
			result_src=2'b00;
			shft_op=3'b000;
			case(instr[1:0])
				2'b01:alu_control=3'b001;
				2'b11:alu_control=3'b000;
			endcase
			ALU_flags=alu_flags;
		end
		
		shift:begin
			next_state=shift_WB;
			adr_source=0;
			mem_Write=0;
			ir_Write=0;
			reg_Write=0;
			alu_srcA=1;
			pc_Write=0;
			alu_srcB=2'b00;
			imm_src=2'b00;
			result_src=2'b11;
			alu_control=3'b000;
			case(inst3)
				3'b000:shft_op=3'b000;
				3'b100:shft_op=3'b100;
				3'b010:shft_op=3'b010;
				3'b011:shft_op=3'b010;
				3'b110:shft_op=3'b110;
				3'b111:shft_op=3'b111;
			endcase
			
		end
		
		shift_WB:begin
			next_state=fetch;
			adr_source=0;
			mem_Write=0;
			ir_Write=0;
			reg_Write=1;
			alu_srcA=1;
			pc_Write=0;
			alu_srcB=2'b00;
			imm_src=2'b00;
			result_src=2'b11;
			alu_control=3'b000;
		end
		
		mem_adr:begin
			adr_source=0;
			mem_Write=0;
			ir_Write=0;
			reg_Write=0;
			alu_srcA=1;
			pc_Write=0;
			alu_srcB=2'b01;
			imm_src=2'b10;
			result_src=2'b00;
			alu_control=3'b000;
			shft_op=3'b000;
			alu_control=3'b000;
			case(instr[1:0])
				2'b00:next_state=mem_write;
				2'b10:next_state=mem_read;
			endcase
		end
		
		mem_write:begin
			next_state=fetch;
			adr_source=1;
			mem_Write=1;
			ir_Write=0;
			reg_Write=0;
			alu_srcA=1;
			pc_Write=0;
			alu_srcB=2'b01;
			imm_src=2'b10;
			result_src=2'b00;
			alu_control=3'b000;
			shft_op=3'b000;
		end
		
		mem_read:begin
			next_state=mem_WB;
			adr_source=1;
			mem_Write=0;
			ir_Write=0;
			reg_Write=0;
			alu_srcA=1;
			pc_Write=0;
			alu_srcB=2'b01;
			imm_src=2'b10;
			result_src=2'b00;
			alu_control=3'b000;
			shft_op=3'b000;
		end
		
		mem_WB:begin
			next_state=fetch;
			adr_source=0;
			mem_Write=0;
			ir_Write=0;
			reg_Write=1;
			alu_srcA=1;
			pc_Write=0;
			alu_srcB=2'b10;
			imm_src=2'b10;
			result_src=2'b01;
			alu_control=3'b000;
			shft_op=3'b000;
		end
		
		imm_load_value:begin
			next_state=imm_load_WB;
			adr_source=0;
			mem_Write=0;
			ir_Write=0;
			reg_Write=0;
			alu_srcA=1;
			pc_Write=0;
			alu_srcB=2'b01;
			imm_src=2'b11;
			result_src=2'b00;
			alu_control=3'b011;
			shft_op=3'b000;
		end
		
		imm_load_WB:begin
			next_state=fetch;
			adr_source=0;
			mem_Write=0;
			ir_Write=0;
			reg_Write=1;
			alu_srcA=1;
			pc_Write=0;
			alu_srcB=2'b01;
			imm_src=2'b11;
			result_src=2'b00;
			alu_control=3'b011;
			shft_op=3'b000;
		end
		
		bun:begin
			next_state=fetch;
			adr_source=0;
			mem_Write=0;
			ir_Write=0;
			reg_Write=0;
			alu_srcA=1;
			pc_Write=1;
			alu_srcB=2'b01;
			imm_src=2'b00;
			result_src=2'b10;
			alu_control=3'b000;
			shft_op=3'b000;
		end
		
		b_link:begin
			next_state=fetch;
			adr_source=0;
			mem_Write=0;
			ir_Write=0;
			reg_Write=1;
			alu_srcA=1;
			pc_Write=1;
			alu_srcB=2'b01;
			imm_src=2'b00;
			result_src=2'b10;
			alu_control=3'b000;
			shft_op=3'b000;
		end
		
		b_ind:begin
			next_state=fetch;
			adr_source=0;
			mem_Write=0;
			ir_Write=0;
			reg_Write=0;
			alu_srcA=1;
			pc_Write=1;
			alu_srcB=2'b00;
			imm_src=2'b00;
			result_src=2'b10;
			alu_control=3'b000;
			shft_op=3'b000;
		end
		
		b_conds:begin
			next_state=fetch;
			adr_source=0;
			mem_Write=0;
			ir_Write=0;
			reg_Write=0;
			alu_srcA=1;
			alu_srcB=2'b01;
			imm_src=2'b00;
			result_src=2'b10;
			alu_control=3'b000;
			shft_op=3'b000;
			case(instr[1:0])
				2'b00:begin
					if(ALU_flags[2]==1)
						pc_Write=1;
					else
						pc_Write=0;
				end
				2'b01:begin
					if(ALU_flags[2]==0)
						pc_Write=1;
					else
						pc_Write=0;
				end
				2'b10:begin
					if(ALU_flags[1]==1)
						pc_Write=1;
					else
						pc_Write=0;
				end
				2'b11:begin
					if(ALU_flags[1]==0)
						pc_Write=1;
					else
						pc_Write=0;
				end
			endcase
		end
		
	endcase
end

endmodule
