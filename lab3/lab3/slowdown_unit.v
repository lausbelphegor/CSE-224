`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:19:23 11/02/2021 
// Design Name: 
// Module Name:    slowdown_unit 
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
module slowdown_unit(clk, rst, enable);

	input clk, rst;
	output enable;
	reg [25:0] slowdown = 0;
	
	assign enable = (slowdown == 25'd50000000) ? 1'b1: 1'b0;
	
	always@(posedge clk)begin
		if(rst == 1'b1 || enable == 1'b1) begin
			slowdown <= 25'd0;
		end
		else begin
			slowdown <= slowdown + 1;
		end
	
	
	end

endmodule
