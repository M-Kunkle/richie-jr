`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//
// Create Date:    21:36:29 03/01/2022 
//
//
// Bus Select List:
// Ram                   0 (000)
// Program Counter       1 (001)
// Instruction Register  2 (010)
// Register A            3 (011)
// Register B            4 (100)
// Arithmetic Logic Unit 5 (101)
// Program Counter       6 (110)
// Null                  7 (111)
//
//////////////////////////////////////////////////////////////////////////////////
module computer(out, clk, res);
	 output [7:0] out;
    input clk, res;
	 
	// generate 4 Hz from 1 MHz Clock On Board
	reg [25:0] count_reg = 0;
	reg c_clock = 0;

	always @(posedge clk or posedge res) begin
		 if (res || control_halt) 
			 begin
				  count_reg <= 0;
				  c_clock <= 0;
			 end 
		 else 
		 begin
			  if (count_reg < 24999999) 
				  begin
						count_reg <= count_reg + 1;
				  end 
			  else 
				  begin
						count_reg <= 0;
						c_clock <= ~c_clock;
				  end
		 end
	end
	
	// Make buses
	wire [7:0] bus;
	wire [7:0] bus_in[7:0];
	 
////////////////////////////////////////
// CONTROL LOGIC
	wire control_halt;
	wire control_mem;
	wire control_ram;
	wire control_instIn;
	wire control_regA;
	wire control_regB;
	wire control_sub;
	wire control_disp;
	wire control_inc;
	wire control_progC;
	wire control_flag;
	wire [2:0] bus_sel;
	
	// Flags
	reg carryFlag;
	reg zeroFlag;
	
	control control(
		.inst(inst_reg_val),
		.clk(c_clock),
		.carryFlag(carryFlag),
		.zeroFlag(zeroFlag),
		// Control lines
		.halt(control_halt),
		.mem(control_mem),
		.ram(control_ram),
		.instIn(control_instIn),
		.regA(control_regA),
		.regB(control_regB),
		.sub(control_sub),
		.disp(control_disp),
		.inc(control_inc),
		.progC(control_progC),
		.flag(control_flag),
		.bus_sel(bus_sel)
	);
//////////////////////////////////	 
// REGISTERS
	 
	 // Memory Address Register
	wire [3:0] mem_add_val;
	reg4bit mem_add_reg(
		.data_out(mem_add_val),
		.data_in(bus),
		.clk(c_clock),
		.res(res),
		.en(control_mem)
	);
	assign bus_in[2] = {4'b0000, mem_add_val};
	 
	// Program Counter Register
	wire [3:0] progC_val;
	reg4bit program_counter(
		.data_out(progC_val),
		.data_in(progC_val+1),
		.clk(c_clock),
		.res(res),
		.en(control_progC)
	);
	assign bus_in[1] = {4'b0000, progC_val};
	 
	// Register A
	reg8bit regA(
	   .data_out(bus_in[3]),
		.data_in(bus),
		.clk(c_clock),
		.res(res),
		.en(control_regA)
	);
	 
	// Register B
	reg8bit regB(
		.data_out(bus_in[4]),
		.data_in(bus),
		.clk(c_clock),
		.res(res),
		.en(control_regB)
	);
	 
/////////////////////////////////
// Arithmetic Logic Unit
	
	wire carryFlag_val, zeroFlag_val;
	alu alu(
		.result(bus_in[5]),
		.carryFlag(carryFlag_val),
		.zeroFlag(zeroFlag_val),
		.A(bus_in[3]),
		.B(bus_in[4]),
		.sub(control_sub)
	);
endmodule
