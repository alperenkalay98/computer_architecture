module register_file(clk,reset,A1,A2,A3,WE3,WD3,R7,RD1,RD2,tbout1,tbout2,tbout6);
input clk,reset,WE3;
input [2:0] A1, A2, A3;
input [7:0]  WD3, R7;
output [7:0] RD1, RD2,tbout1,tbout2,tbout6;
wire [7:0] r0,r1,r2,r3,r4,r5,r6,r7,o10,o11,o20,o21; 
wire [7:0] we;

assign we[0] = ~A3[2] & ~A3[1] & ~A3[0] & WE3; 
assign we[1] = ~A3[2] & ~A3[1] &  A3[0] & WE3; 
assign we[2] = ~A3[2] &  A3[1] & ~A3[0] & WE3; 
assign we[3] = ~A3[2] &  A3[1] &  A3[0] & WE3; 
assign we[4] =  A3[2] & ~A3[1] & ~A3[0] & WE3; 
assign we[5] =  A3[2] & ~A3[1] &  A3[0] & WE3; 
assign we[6] =  A3[2] &  A3[1] & ~A3[0] & WE3; 
assign we[7] =  A3[2] &  A3[1] &  A3[0] & WE3; 

assign r7=R7;		//pc reading

register_we #8 R0(.clk(clk), .reset(reset), .en(we[0]), .in(WD3), .out(r0));
register_we #8 R1(.clk(clk), .reset(reset), .en(we[1]), .in(WD3), .out(r1));
register_we #8 R2(.clk(clk), .reset(reset), .en(we[2]), .in(WD3), .out(r2));
register_we #8 R3(.clk(clk), .reset(reset), .en(we[3]), .in(WD3), .out(r3));
register_we #8 R4(.clk(clk), .reset(reset), .en(we[4]), .in(WD3), .out(r4));
register_we #8 R5(.clk(clk), .reset(reset), .en(we[5]), .in(WD3), .out(r5));
register_we #8 R6(.clk(clk), .reset(reset), .en(we[6]), .in(WD3), .out(r6)); //link register

mux_4x1 #8 m10(.in0(r0),.in1(r1),.in2(r2),.in3(r3),.sel(A1[1:0]),.out(o10));
mux_4x1 #8 m11(.in0(r4),.in1(r5),.in2(r6),.in3(r7),.sel(A1[1:0]),.out(o11));
mux_2x1 #8 m1(.in0(o10),.in1(o11),.sel(A1[2]),.out(RD1));

mux_4x1 #8 m20(.in0(r0),.in1(r1),.in2(r2),.in3(r3),.sel(A2[1:0]),.out(o20));
mux_4x1 #8 m21(.in0(r4),.in1(r5),.in2(r6),.in3(r7),.sel(A2[1:0]),.out(o21));
mux_2x1 #8 m2(.in0(o20),.in1(o21),.sel(A2[2]),.out(RD2));

assign tbout1=r1;
assign tbout2=r2;
assign tbout6=r6;

endmodule
