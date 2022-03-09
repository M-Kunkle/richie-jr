`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   05:50:19 02/27/2022
// Design Name:   alu
// Module Name:   /home/ise/RichieJr/alu_testbench.v
// Project Name:  RichieJr
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: alu
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module alu_testbench;

	// Inputs
	reg [7:0] A;
	reg [7:0] B;
	reg sub;

	// Outputs
	wire [7:0] result;
	wire carryFlag;
	wire zeroFlag;

	// Instantiate the Unit Under Test (UUT)
	alu uut (
		.result(result), 
		.carryFlag(carryFlag), 
		.zeroFlag(zeroFlag), 
		.A(A), 
		.B(B), 
		.sub(sub)
	);

	initial begin
		// Initialize Inputs
		A = 0;
		B = 0;
		sub = 0;

		// Wait 100 ns for global reset to finish
		#100 A = 8'b01101001; B = 8'b00000010; 
		#100 sub = 1'b1;

	end
      
endmodule

