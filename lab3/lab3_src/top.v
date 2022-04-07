`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:19:11 11/21/2020 
// Design Name: 
// Module Name:    top 
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
module top(clk,rst,up_down,sseg,anode
    );
input up_down,clk,rst;
output [7:0]sseg;
output [3:0]anode;

wire [3:0] digit_1;
wire [3:0] digit_2;
wire [3:0] digit_3;
wire [3:0] digit_4;
wire [7:0] sseg_1;
wire [7:0] sseg_2;
wire [7:0] sseg_3;
wire [7:0] sseg_4;
wire enable;

slowdown_unit uut(
	.clk(clk),
	.rst(rst),
	.enable(enable)
);

scan_unit uut1(
	.clk_s(clk),
	.rst_s(rst),
	.sseg_s({sseg_4,sseg_3,sseg_2, sseg_1}),
	.anode_s(anode),
	.sout_s(sseg)
);

ssd_decoder_unit uut2(
	.bcd(digit_1),
	.ssd(sseg_1)
);
ssd_decoder_unit uut20(
	.bcd(digit_2),
	.ssd(sseg_2)
);
ssd_decoder_unit uut200(
	.bcd(digit_3),
	.ssd(sseg_3)
);
ssd_decoder_unit uut2000(
	.bcd(digit_4),
	.ssd(sseg_4)
);

up_down_counter uut30000(
	.clk(clk),
	.rst(rst),
	.up_down(up_down),
	.enable(enable),
	.digit_1(digit_1),
	.digit_2(digit_2),
	.digit_3(digit_3),
	.digit_4(digit_4)
);

endmodule
