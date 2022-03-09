`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date:    06:09:08 02/27/2022 
// Design Name: 
// Module Name:    control 
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
module control(halt, mem, ram, instIn, regA, regB, sub, disp, inc, progC, flag, bus_sel, inst, clk, res, carryFlag, zeroFlag);
	output reg halt, mem, ram, instIn, regA, regB, sub, disp, inc, progC, flag;
	output reg [2:0] bus_sel;
	input [3:0] inst;
	input clk, res, carryFlag, zeroFlag;
	
	reg [2:0] step;
	
	always@(negedge clk)
	begin
		if (res == 1'b1)
			fullReset();
		else
			begin
			cycleFlush();
			step <= step + 1;
			
			if(step < 3'b010)
				fetch();
			else
				begin
				case(inst) // Checks OPCODE and executes task
					4'b0000: nop();
					4'b0001:	add();
					4'b0010: sub();
					4'b0011: jump();
					4'b0100: loadA();
					4'b0101: nop(); // UNUSED
					4'b0110: jumpCarry();
					4'b0111: nop(); // UNUSED
					4'b1000: storeA();
					4'b1001: nop(); // UNUSED
					4'b1010: nop(); // UNUSED
					4'b1011: nop(); // UNUSED
					4'b1100: jumpZero();
					4'b1101: loadI();
					4'b1110: nop(); // UNUSED
					4'b1111: halt();
					default: nop();
				endcase
				end
			end
	end

	
	// Resets all control signals
	task cycleFlush();
	begin
		halt <= 0;
		mem <= 0;
		ram <= 0;
		instIn <= 0;
		regA <= 0;
		regB <= 0;
		sub <= 0;
		disp <= 0;
		inc <= 0;
		jump <= 0;
		flag <= 0;
		bus_sel <= 0;
	end
	endtask
	
	// Fully resets computer including step	
	task fullReset();
	begin
		step <= 0;
		halt <= 0;
		mem <= 0;
		ram <= 0;
		instIn <= 0;
		regA <= 0;
		regB <= 0;
		sub <= 0;
		disp <= 0;
		inc <= 0;
		jump <= 0;
		flag <= 0;
		bus_sel <= 0;
	end
	endtask
	
	// First two steps fetch cycle
	task fetch();
		case(step)
			3'b000:
				begin
				mem <= 1'b1;
				bus_sel <= 1'd6;
				end
		   3'b001:
				begin
				instIn <= 1'b1;
				inc <= 1'b1;
				bus_sel <= 1'd0;
				end
			default: nop();
		endcase
	endtask
	
	// Halts the clock progression
	task halt();
		step <= 0;
		halt <= 1;
	endtask
	
	// No operation 
	task nop();
		step <= 0;
	endtask
	
	// Loads a value from ram to register A
	task loadA();
		case(step)
			3'b010:
				begin
				mem <= 1'b1;
				bus_sel <= 1'd2;
				end
			3'b011:
				begin
				regA <= 1'b1;
				bus_sel <= 1'd0;
				end
			default: nop();
		endcase
	endtask
	
	// Adds value to reg A value
	task add();
		case(step)
			3'b010:
				begin
				mem <= 1'b1;
				bus_sel <= 1'd2;
				end
			3'b011:
				begin
				regB <= 1'b1;
				bus_sel <= 1'd0;
				end
			3'b100:
				begin
				regA <= 1'b1;
				bus_sel <= 1'd5;
				flag <= 1'b1;
				end
			default: nop();
		endcase
	endtask
	
	// Subtracts value from reg A value
	task sub();
		case(step)
			3'b010:
				begin
				mem <= 1'b1;
				bus_sel <= 1'd2;
				end
			3'b011:
				begin
				regB <= 1'b1;
				bus_sel <= 1'd0;
				end
			3'b100:
				begin
				regA <= 1'b1;
				bus_sel <= 1'd5;
				flag <= 1'b1;
				sub <= 1'b1;
				end
			default: nop();
		endcase
	endtask
	
	// Stores value from A register into RAM
	task storeA();
		case(step)
			3'b010:
				begin
				mem <= 1'b1;
				bus_sel <= 1'd2;
				end
			3'b011:
				begin
				ram <= 1'b1;
				bus_sel <= 1'd3;
				end
			default: nop();
		endcase
	endtask
	
	// Loads value of instruction register into A reg
	task loadI();
		case(step)
			3'b010:
				begin
				regA <= 1'b1;
				bus_sel <= 1'd2;
				end
			default: nop();
		endcase
	endtask
	
	// Jumps to different RAM instruction
	task jump();
		case(step)
			3'b010:
				begin
				jump = 1'b1;
				bus_sel = 1'd2;
				end
			default: nop();
		endcase
	endtask
	
	// Conditional Jump if Carry Flag is set
	task jumpCarry();
		if (step == 3'b010 && carryFlag == 1'b1)
			begin
		   jump <= 1'b1;
			bus_sel = 1'd2;
			end
		else
			nop();
	endtask
	
	// Conditional Jump if Zero Flag is set
	task jumpZero();
		if (step == 3'b010 && zeroFlag == 1'b1)
			begin
		   jump <= 1'b1;
			bus_sel = 1'd2;
			end
		else
			nop();
	endtask
	
endmodule
