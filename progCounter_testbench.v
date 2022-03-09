`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   01:05:50 02/26/2022
// Design Name:   progCounter
// Module Name:   /home/ise/RichieJr/progCounter_testbench.v
// Project Name:  RichieJr
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: progCounter
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module progCounter_testbench;

	// Inputs
	reg en;
	reg res;
	reg clk;

	// Outputs
	wire [3:0] out;

	// Instantiate the Unit Under Test (UUT)
	progCounter uut (
		.out(out), 
		.clk(clk),
		.res(res), 
		.en(en)
	);

	initial begin
		// Initialize Inputs
		en = 1'b1;
		res = 1'b1;
		clk = 0;
		
		#20 clk = 1'b1;
		#5 res = 0;
		
		forever begin
			#20 clk = ~clk;
		end
	end
      
endmodule

