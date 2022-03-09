`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    03:24:06 02/26/2022 
// Design Name: 
// Module Name:    alu 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module alu(result, carryFlag, zeroFlag, A, B, sub);
    output [7:0] result; 
    output carryFlag, zeroFlag;
    input [7:0] A, B;
    input sub;
	 
	 wire [8:0] fullSum;
	 
	 assign fullSum = A + (sub ? ~B + 1: B);
	 assign result = fullSum[7:0];
	 assign carryFlag = fullSum[8];
	 assign zeroFlag = fullSum == 0;
endmodule
