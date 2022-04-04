module register_file(CLK,A1,A2,A3,WE3,WD3,R15,RD1,RD2);
input CLK, WE3;
input [3:0] A1, A2, A3;
input [31:0]  WD3, R15;
output [31:0] RD1, RD2;
wire [31:0] r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,r13,r14,r15, o10,o11,o12,o13,o20,o21,o22,o23; 
wire [15:0] we;
reg reset;

assign we[0] = ~A3[3] & ~A3[2] & ~A3[1] & ~A3[0] & WE3; 
assign we[1] = ~A3[3] & ~A3[2] & ~A3[1] &  A3[0] & WE3; 
assign we[2] = ~A3[3] & ~A3[2] &  A3[1] & ~A3[0] & WE3; 
assign we[3] = ~A3[3] & ~A3[2] &  A3[1] &  A3[0] & WE3; 
assign we[4] = ~A3[3] &  A3[2] & ~A3[1] & ~A3[0] & WE3; 
assign we[5] = ~A3[3] &  A3[2] & ~A3[1] &  A3[0] & WE3; 
assign we[6] = ~A3[3] &  A3[2] &  A3[1] & ~A3[0] & WE3; 
assign we[7] = ~A3[3] &  A3[2] &  A3[1] &  A3[0] & WE3; 
assign we[8] =  A3[3] & ~A3[2] & ~A3[1] & ~A3[0] & WE3; 
assign we[9] =  A3[3] & ~A3[2] & ~A3[1] &  A3[0] & WE3; 
assign we[10] = A3[3] & ~A3[2] &  A3[1] & ~A3[0] & WE3; 
assign we[11] = A3[3] & ~A3[2] &  A3[1] &  A3[0] & WE3; 
assign we[12] = A3[3] &  A3[2] & ~A3[1] & ~A3[0] & WE3; 
assign we[13] = A3[3] &  A3[2] & ~A3[1] &  A3[0] & WE3; 
assign we[14] = A3[3] &  A3[2] &  A3[1] & ~A3[0] & WE3; 
assign we[15] = A3[3] &  A3[2] &  A3[1] &  A3[0] & WE3;

initial 
	begin
		reset = 1;
		#30;
		reset = 0;
	end	

register_we #32 R0(.clk(CLK), .reset(reset), .en(we[0]), .in(WD3), .out(r0));
register_we #32 R1(.clk(CLK), .reset(reset), .en(we[1]), .in(WD3), .out(r1));
register_we #32 R2(.clk(CLK), .reset(reset), .en(we[2]), .in(WD3), .out(r2));
register_we #32 R3(.clk(CLK), .reset(reset), .en(we[3]), .in(WD3), .out(r3));
register_we #32 R4(.clk(CLK), .reset(reset), .en(we[4]), .in(WD3), .out(r4));
register_we #32 R5(.clk(CLK), .reset(reset), .en(we[5]), .in(WD3), .out(r5));
register_we #32 R6(.clk(CLK), .reset(reset), .en(we[6]), .in(WD3), .out(r6));
register_we #32 R7(.clk(CLK), .reset(reset), .en(we[7]), .in(WD3), .out(r7));
register_we #32 R8(.clk(CLK), .reset(reset), .en(we[8]), .in(WD3), .out(r8));
register_we #32 R9(.clk(CLK), .reset(reset), .en(we[9]), .in(WD3), .out(r9));
register_we #32 R10(.clk(CLK), .reset(reset), .en(we[10]), .in(WD3), .out(r10));
register_we #32 R11(.clk(CLK), .reset(reset), .en(we[11]), .in(WD3), .out(r11));
register_we #32 R12(.clk(CLK), .reset(reset), .en(we[12]), .in(WD3), .out(r12));
register_we #32 R13(.clk(CLK), .reset(reset), .en(we[13]), .in(WD3), .out(r13));
register_we #32 R14(.clk(CLK), .reset(reset), .en(we[14]), .in(WD3), .out(r14));
register_we #32 R15_reg(.clk(CLK), .reset(reset), .en(1), .in(R15), .out(r15));
mux_4x1 #32 m10(.in0(r0),.in1(r1),.in2(r2),.in3(r3),.sel(A1[1:0]),.out(o10));
mux_4x1 #32 m11(.in0(r4),.in1(r5),.in2(r6),.in3(r7),.sel(A1[1:0]),.out(o11));
mux_4x1 #32 m12(.in0(r8),.in1(r9),.in2(r10),.in3(r11),.sel(A1[1:0]),.out(o12));
mux_4x1 #32 m13(.in0(r12),.in1(r13),.in2(r14),.in3(r15),.sel(A1[1:0]),.out(o13));
mux_4x1 #32 m14(.in0(o10),.in1(o11),.in2(o12),.in3(o13),.sel(A1[3:2]),.out(RD1));
mux_4x1 #32 m20(.in0(r0),.in1(r1),.in2(r2),.in3(r3),.sel(A2[1:0]),.out(o20));
mux_4x1 #32 m21(.in0(r4),.in1(r5),.in2(r6),.in3(r7),.sel(A2[1:0]),.out(o21));
mux_4x1 #32 m22(.in0(r8),.in1(r9),.in2(r10),.in3(r11),.sel(A2[1:0]),.out(o22));
mux_4x1 #32 m23(.in0(r12),.in1(r13),.in2(r14),.in3(r15),.sel(A2[1:0]),.out(o23));
mux_4x1 #32 m24(.in0(o20),.in1(o21),.in2(o22),.in3(o23),.sel(A2[3:2]),.out(RD2));

endmodule
