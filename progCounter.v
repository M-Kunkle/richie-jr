`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date:    01:03:19 02/26/2022 
// Module Name:    progCounter 

// Description: Program Counter for Richie Jr
//
// Dependencies: 
//////////////////////////////////////////////////////////////////////////////////

module progCounter(out, clk, res, en);
    output [3:0] out;
    input en, res, clk;
	 
	 reg [3:0] out;
	 
	 always@(posedge clk)
		if (en & !res)
			out <= out + 1;
		else
			out <= 0;

endmodule
