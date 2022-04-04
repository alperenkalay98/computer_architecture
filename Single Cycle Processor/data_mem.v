module data_mem(clk,WE,WD,A,RD);
	input clk,WE;
	input [31:0] WD;
	input [31:0] A;
	output reg [31:0] RD;
	reg [31:0] data[31:0];

initial
	begin
		data[0]=32'b00000000000000000000000000000110;
		data[1]=32'b00000000000000000000000000000111;
		data[2]=32'b00000000000000000000000000000100;
		data[3]=32'b00000000000000000000000000000100;
		data[4]=32'b00000000000000000000000000110000;
		data[5]=32'b00000000000000000000000000001100;
		data[6]=32'b00000000000000000000000000000010;
		data[7]=32'b00000000000000000000000000000000;
		data[8]=32'b00000000000000000000000000000000;
		data[9]=32'b00000000000000000000000000000000;
		data[10]=32'b00000000000000000000000000000000;
		data[11]=32'b00000000000000000000000000000000;
		data[12]=32'b00000000000000000000000000000000;
		data[13]=32'b00000000000000000000000000000000;
		data[14]=32'b00000000000000000000000000000000;
		data[15]=32'b00000000000000000000000000000000;
		data[16]=32'b00000000000000000000000000000000;
		data[17]=32'b00000000000000000000000000000000;
		data[18]=32'b00000000000000000000000000000000;
		data[19]=32'b00000000000000000000000000000000;
		data[20]=32'b00000000000000000000000000000000;
		data[21]=32'b00000000000000000000000000000000;
		data[22]=32'b00000000000000000000000000000000;
		data[23]=32'b00000000000000000000000000000000;
		data[24]=32'b00000000000000000000000000000000;
		data[25]=32'b00000000000000000000000000000000;
		data[26]=32'b00000000000000000000000000000000;
		data[27]=32'b00000000000000000000000000000000;
		data[28]=32'b00000000000000000000000000000000;
		data[29]=32'b00000000000000000000000000000000;
		data[30]=32'b00000000000000000000000000000000;
		data[31]=32'b00000000000000000000000000000000;
	end
	

	
	always @(posedge clk)
		begin
			if(WE)
				begin
					data[A] = WD;
				end
		end

	always @(*)begin
		RD=data[A];
	end
	
endmodule