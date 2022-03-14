`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:04:21 03/13/2022 
// Design Name: 
// Module Name:    ram 
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
module ram(data_out, address, clk, res, en);
	output [7:0]data_out;
	input clk, res, en;
	input [3:0]address;
	
	reg [7:0]data_out;
	wire [7:0]ram_contents[15:0];
	
	// Hard coding ram contents for now
	assign ram_contents[0]  = 8'b01001011;
	assign ram_contents[1]  = 8'b00011111;
	assign ram_contents[2]  = 8'b00101110;
	assign ram_contents[3]  = 8'b11110000;
	assign ram_contents[4]  = 8'b00000000;
	assign ram_contents[5]  = 8'b00000000;
	assign ram_contents[6]  = 8'b00000000;
	assign ram_contents[7]  = 8'b00000000;
	assign ram_contents[8]  = 8'b00000000;
	assign ram_contents[9]  = 8'b00000000;
	assign ram_contents[10] = 8'b00000000;
	assign ram_contents[11] = 8'b00000000;
	assign ram_contents[12] = 8'b00000000;
	assign ram_contents[13] = 8'b00000000;
	assign ram_contents[14] = 8'b00101010;
	assign ram_contents[15] = 8'b00101111;
	
	always@(posedge clk)
	begin
		if (en & !res)
			data_out = ram_contents[address];
		else
			data_out = data_out;
	end

endmodule
