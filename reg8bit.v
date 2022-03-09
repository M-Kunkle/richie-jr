`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date:    02:31:19 02/26/2022 
//////////////////////////////////////////////////////////////////////////////////
module reg8bit(data_Out, data_In, clk, res, en);
    output [7:0] data_Out;
    input [7:0] data_In;
    input clk, res, en;
	 
	 reg [7:0] data;
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
