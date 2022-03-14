`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   06:44:59 03/13/2022
// Design Name:   ram
// Module Name:   /home/ise/my_desk/RichieJr/ram_testbench.v
// Project Name:  RichieJr
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ram
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module ram_testbench;

	// Inputs
	reg [3:0] address;
	reg clk;
	reg res;
	reg en;

	// Outputs
	wire [7:0] data_out;

	// Instantiate the Unit Under Test (UUT)
	ram uut (
		.data_out(data_out), 
		.address(address), 
		.clk(clk), 
		.res(res), 
		.en(en)
	);

	initial begin
		// Initialize Inputs
		address = 0;
		clk = 0;
		res = 0;
		en = 0;

		// Wait 100 ns for global reset to finish
		#100;
		en=1; address = 4'b0001;
        
		forever begin
			#20 clk = ~clk;
		end

	end
      
endmodule

