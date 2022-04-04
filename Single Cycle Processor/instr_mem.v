module instr_mem (in,out);


input [31:0] in;
output wire [31:0] out; 

reg [31:0] registers[10:0];

initial
	begin
		registers[0]=32'b00000101100100010010000000000000; //ldr r1+0 to r2 (r2=6)
		registers[1]=32'b00000101100100000011000000000011; //ldr r0+3 to r3 (r3=4)
 		registers[2]=32'b00000000100000100100000000000011; //add r2+r3 to r4 (r4=10) 
		registers[3]=32'b00000000010001000101000000000011; //sub r4-r3 to r5 (r5=6)
		registers[4]=32'b00000000000001010110000000000100; //and r5&r4 to r6 (r6=2)
		registers[5]=32'b00000001100001010111000000000100; //orr r5&r4 to r7 (r7=14)
		registers[6]=32'b00000011111001111000000000000010; //lsr r7 with 2 to r8 (r8=3)
		registers[7]=32'b00000011110001111001000000000010; //lsl r7 with 2 to r9 (r9=111000)
		registers[8]=32'b00000001010110000000000000001001; //cmp r8,r9 (N=1)
		registers[9]=32'b00000101100000111001000000001000; //str r9 to r3+8 
		registers[10]=32'b00000101100000101001000000010000; //str r9 to r3+16
	end

assign out = registers[in];

endmodule 