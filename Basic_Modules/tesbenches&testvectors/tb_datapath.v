module tb_datapath();
	reg clk, reset;
	reg [3:0] in;
	wire[3:0] out;
	reg [3:0] out_expected;
	reg mux_2x1_R1_sel,mux_2x1_alu_a_sel,mux_2x1_acc_sel;
	reg acc_load_sel,q_dir_sel;
	reg [2:0] alu_control;
	reg [5:0] vectornum, errors; 
	reg [16:0] testvectors[11:0]; 
	
	datapath dut(
					clk,
					reset,
					mux_2x1_R1_sel,
					mux_2x1_alu_a_sel,
					mux_2x1_acc_sel,
					acc_load_sel,
					q_dir_sel,
					alu_control,
					in,
					out);
	
	
	always 
	begin
		clk = 0; #20; clk = 1; #20;
	end
	
	initial
		begin
		$readmemb("testvector_datapath.tv", testvectors);
		vectornum = 0; errors = 0;
		//reset = 1; #30; 
		reset = 0;
	end
	
	always @(negedge clk)
		begin
	   {reset,mux_2x1_R1_sel,mux_2x1_alu_a_sel,mux_2x1_acc_sel,acc_load_sel,q_dir_sel,alu_control,in,out_expected} = testvectors[vectornum];
		end
	
	always @(posedge clk)
		begin
		#1;if (out !== out_expected) 			
		begin		
			$display("Error: mux_2x1_R1_sel=%b,mux_2x1_alu_a_sel=%b,mux_2x1_acc_sel=%b", mux_2x1_R1_sel,mux_2x1_alu_a_sel,mux_2x1_acc_sel);
			$display("Error: acc_load_sel=%b,q_dir_sel=%b,alu_control=%b,input=%b", acc_load_sel,q_dir_sel,alu_control,in);
			$display(" outputs = %b (%b expected)",out,out_expected);
			errors = errors + 1;	
		end
	
	vectornum = vectornum + 1;
	if (vectornum == 5'b01100) begin 
		$display("%d tests completed with %d errors",vectornum, errors);
		$stop;
	end
	end
endmodule 