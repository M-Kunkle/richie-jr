`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date:    21:30:10 03/01/2022 
//////////////////////////////////////////////////////////////////////////////////
module reg4bit(data_Out, data_In, clk, res, en);
    output [3:0] data_Out;
    input [3:0] data_In;
    input clk, res, en;
	 
	 reg [3:0] data;
	 assign data_Out = data;
	 
	 always@(posedge clk)
	 begin
		if (en & !res)
			data = data_In;
		else if (!en & !res)
			data = data;
		else
			data = 0;
	 end
endmodule
