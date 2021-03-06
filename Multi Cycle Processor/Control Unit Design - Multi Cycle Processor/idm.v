module idm(clk,memWrite,adr,WD,out,mem32);
	input clk;
	input memWrite;
	input [7:0] adr;
	input [7:0] WD;
	output reg [13:0] out;
	output reg [7:0] mem32;
	
	reg [13:0] mem [63:0];
	
	
	initial begin
		/*		//COMPLEMENT
		mem[0]=14'b110_1_1_010_000111;	//LDRIM R2,8
		mem[1]=14'b110_1_0_001_010_000;  //LDR R1,[R2]
		mem[2]=14'b110_1_1_010_000000;	//LDRIM R2,0
		mem[3]=14'b000_00_010_010_001;	//SUB R2,R2,R1			
		mem[4]=14'b111_00000000000;		
		mem[5]=14'b111_00000000000;		
		mem[6]=14'b111_00000000000;	
		mem[7]=14'b000000_01101110;		//data
		mem[8]=14'b111_00000000000;
		mem[9]=14'b111_00000000000;
		mem[10]=14'b111_00000000000;
		mem[11]=14'b111_00000000000;
		*/
		/*
		// ARRAY SUM
		mem[0]=14'b110_1_1_001_000101;	//LDRIM R1,5
		mem[1]=14'b110_1_1_011_000001;   //LDRIM R3,1
		mem[2]=14'b110_1_1_000_010111;	//LDRIM R0,23
		mem[3]=14'b110_1_0_100_000_000;	//LDR R4,[R0]		
		mem[4]=14'b000_10_010_010_100;	//ADD R2,R2,R4
		mem[5]=14'b000_10_000_000_011;	//ADD R0,R0,R3
		mem[6]=14'b000_00_001_001_011;	//SUB R1,R1,R3
		mem[7]=14'b101_01_0_11111010;		//BNZ -6
		mem[8]=14'b110_1_1_001_010000;	//LDRIM R1,16
		mem[9]=14'b010_00_001_000_010;	//SHL R1
		mem[10]=14'b110_0_0_010_001_000;	//STR R2,[R1]
		mem[11]=14'b111_00000000000;
		*/
		//  EVENNESS/ODDITY
		mem[0]=14'b110_1_1_101_010010;	//LDRIM R5,18
		mem[1]=14'b110_1_0_001_101_000;  //LDR R1,[R5]
		mem[2]=14'b110_1_1_000_000001;	//LDRIM R0,1
		mem[3]=14'b000_10_101_101_000;	//ADD R5,R5,R0
		mem[4]=14'b110_1_0_011_101_000;  //LDR R3,[R5]
		mem[5]=14'b000_10_101_101_000;	//ADD R5,R5,R0
		mem[6]=14'b110_1_0_100_101_000;  //LDR R4,[R5]
		mem[7]=14'b001_00_010_001_000;	//AND R2,R1,R0		
		mem[8]=14'b101_01_0_00000011;		//BNZ 3
		mem[9]=14'b001_00_001_001_100;	//AND R1,R1,R4
		mem[10]=14'b010_00_001_000_010;	//SHL R1
		mem[11]=14'b010_00_001_000_010;	//SHL R1
		mem[12]=14'b111_00000000000;
		mem[13]=14'b001_00_001_001_011;	//AND R1,R1,R3
		mem[14]=14'b010_00_001_000_000;	//RTL R1
		mem[15]=14'b010_00_001_000_000;	//RTL R1
		mem[16]=14'b010_00_001_000_000;	//RTL R1
		mem[17]=14'b111_00000000000;
		mem[18]=14'b110110_01010111;	//8bit number
		mem[19]=14'b010000_11111110;	//FOR ODD CHECK
		mem[20]=14'b110000_00011110;	//FOR EVEN CHECK
		mem[21]=14'b111_00000000000;
		
		/*
		mem[0]=14'b110_1_0_001_000_011;	//LDR 5 cycle
		mem[1]=14'b000_1_0_010_001_000;  //ADDI 5 cycle
		mem[2]=14'b101_01_0_00000010;		//BNZ 3 cycle
		mem[3]=14'b00000001100011;			//data
		mem[4]=14'b00000001100011;			//data
		mem[5]=14'b00000001100011;			//data
		mem[6]=14'b010_00_001_000_1_00;	//RTR 4 cycle
		mem[7]=14'b001_11_010_000_000;	//CLR 4 cycle
		mem[8]=14'b111_00000000000;
		mem[9]=14'b111_00000000000;
		mem[10]=14'b111_00000000000;
		mem[11]=14'b111_00000000000;
		*/
		/*
		mem[0]=14'b110_1_1_001_010000;	//LDR_imm 4 cycle
		mem[1]=14'b010_00_001_000_0_10;  //SHL 4 cycle
		mem[2]=14'b100_01_0_00010000;		//BL 3 cycle
		mem[3]=14'b111_00000000000;			
		mem[4]=14'b111_00000000000;			
		mem[5]=14'b111_00000000000;			
		mem[6]=14'b111_00000000000;
		mem[7]=14'b111_00000000000;
		mem[8]=14'b111_00000000000;
		mem[9]=14'b111_00000000000;
		mem[10]=14'b111_00000000000;
		mem[11]=14'b111_00000000000;
		*/
		/*
		mem[0]=14'b110_1_1_001_001011;	//LDRIM 4 cycle	reg1 11
		mem[1]=14'b110_1_1_010_001000;   //LDRIM 4 cycle	reg2 8
		mem[2]=14'b100_1_0_000000_001;	//BI 3 cycle
		mem[3]=14'b111_00000000000;			
		mem[4]=14'b111_00000000000;			
		mem[5]=14'b111_00000000000;			
		mem[6]=14'b111_00000000000;
		mem[7]=14'b111_00000000000;
		mem[8]=14'b111_00000000000;
		mem[9]=14'b111_00000000000;
		mem[10]=14'b111_00000000000;
		mem[11]=14'b111_00000000000;
		*/
		
		
		/*
		mem[12]=14'b111_00000000000;
		mem[13]=14'b111_00000000000;
		mem[14]=14'b111_00000000000;
		mem[15]=14'b000_0_0_001_001_010;		//sub r1-r2->r1  reg1 3
		mem[16]=14'b010_00_001_000_110;			//ASR r1		  reg1 1
		mem[17]=14'b001_10_010_001_010;		//xor r1 ^ r2 -> r2  reg2 9
		mem[18]=14'b001_01_001_001_010;		//or r1 | r2 -> r1  reg1 9
		mem[19]=14'b111_00000000000;
		mem[20]=14'b110_0_0_001_001_000;		//STR4 cycle 
		mem[21]=14'b111_00000000000;
		*/
		mem[22]=14'b111_00000000000;
		mem[23]=14'b111_00000000001;			//array start
		mem[24]=14'b111_00000000010;
		mem[25]=14'b111_00000000100;
		mem[26]=14'b111_00000001000;
		mem[27]=14'b111_00000010000;
		mem[28]=14'b111_00000000000;
		mem[29]=14'b111_00000000000;
		mem[30]=14'b111_00000000000;
		mem[31]=14'b111_00000000000;
		mem[32]=14'b00000000101110;			//data
		mem[33]=14'b111_00000000000;
		mem[34]=14'b111_00000000000;
		mem[35]=14'b111_00000000000;
		mem[36]=14'b111_00000000000;
		mem[37]=14'b111_00000000000;
		mem[38]=14'b111_00000000000;
		mem[39]=14'b111_00000000000;
		mem[40]=14'b111_00000000000;
		mem[41]=14'b111_00000000000;
		mem[42]=14'b111_00000000000;
		mem[43]=14'b111_00000000000;
		mem[44]=14'b111_00000000000;
		mem[45]=14'b111_00000000000;
		mem[46]=14'b111_00000000000;
		mem[47]=14'b111_00000000000;
		mem[48]=14'b111_00000000000;
		mem[49]=14'b111_00000000000;
		mem[50]=14'b111_00000000000;
		mem[51]=14'b111_00000000000;
		mem[52]=14'b111_00000000000;
		mem[53]=14'b111_00000000000;
		mem[54]=14'b111_00000000000;
		mem[55]=14'b111_00000000000;
		mem[56]=14'b111_00000000000;
		mem[57]=14'b111_00000000000;
		mem[58]=14'b111_00000000000;
		mem[59]=14'b111_00000000000;
		mem[60]=14'b111_00000000000;
		mem[61]=14'b111_00000000000;
		mem[62]=14'b111_00000000000;
		mem[63]=14'b111_00000000000;
	
	end
	
	always @(*)begin
		out=mem[adr];
		mem32=mem[32][7:0];
	end
	
	always @(posedge clk)begin
		if(memWrite)
			mem[adr][7:0]<=WD;
	end
	
endmodule
