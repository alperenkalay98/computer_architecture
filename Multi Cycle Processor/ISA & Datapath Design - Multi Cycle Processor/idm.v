module idm(clk,memWrite,adr,WD,out,mem32);
	input clk;
	input memWrite;
	input [7:0] adr;
	input [7:0] WD;
	output reg [13:0] out;
	output reg [7:0] mem32;
	
	reg [13:0] mem [63:0];
	
	
	initial begin
		
		mem[0]=14'b110_1_0_001_000_011;	//LDR 5 cycle
		mem[1]=14'b000_1_0_010_001_000;  //ADDI 5 cycle
		mem[2]=14'b101_01_0_00000010;		//BNZ 3 cycle
		mem[3]=14'b00000001100011;			//data
		mem[4]=14'b00000001100011;			//data
		mem[5]=14'b00000001100011;			//data
		mem[6]=14'b010_00_001_000_1_00;	//RTR 4 cycle
		mem[7]=14'b001_11_010_000_000;	//CLR 4 cycle
		
		/*
		mem[0]=14'b110_1_1_001_010000;	//LDR_imm 4 cycle
		mem[1]=14'b010_00_001_000_0_10;  //SHL 4 cycle
		mem[2]=14'b100_01_0_00010000;		//BL 3 cycle
		mem[3]=14'b111_00000000000;			
		mem[4]=14'b111_00000000000;			
		mem[5]=14'b111_00000000000;			
		mem[6]=14'b111_00000000000;
		mem[7]=14'b111_00000000000;
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
		*/
		
		mem[8]=14'b111_00000000000;
		mem[9]=14'b111_00000000000;
		mem[10]=14'b111_00000000000;
		mem[11]=14'b111_00000000000;
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
		mem[22]=14'b111_00000000000;
		mem[23]=14'b111_00000000000;
		mem[24]=14'b111_00000000000;
		mem[25]=14'b111_00000000000;
		mem[26]=14'b111_00000000000;
		mem[27]=14'b111_00000000000;
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
