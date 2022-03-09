`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   02:50:02 02/26/2022
// Design Name:   reg8bit
// Module Name:   /home/ise/RichieJr/reg8bit_testbench.v
// Project Name:  RichieJr
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: reg8bit
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module reg8bit_testbench;

	// Inputs
	reg [7:0] data_In;
	reg clk;
	reg res;
	reg en;

	// Outputs
	wire [7:0] data_Out;

	// Instantiate the Unit Under Test (UUT)
	reg8bit uut (
		.data_Out(data_Out), 
		.data_In(data_In), 
		.clk(clk), 
		.res(res), 
		.en(en)
	);
	
	initial begin
		forever begin
			#10 clk = ~clk;
		end
	end
	

	initial begin
		// Initialize Inputs
		data_In = 8'b01101001;
		clk = 0;
		res = 1'b1;
		en = 0;

		#50 res = 0;
		#50 en = 1'b1;
		#50 
		en = 1'b0;
		data_In = 8'b11111000;
		#50 
		res = 1'b1;
		#20 res= 0;
		#20 en = 1'b1;
		#20 en = 0;
		
        

	end
      
endmodule

