`timescale 1ns / 1ps

module SevenSegmentDisplayCSE(switch, sseg, anode);

	input [3:0] switch;
	output reg [7:0] sseg;
	output reg [3:0] anode;
		
										
	always@(*)begin
		casex(switch)
			
			
			4'b1xxx :	begin
							
							sseg = 8'b10011100;
							anode = 4'b1000;
							
							end
			
			4'b01xx :	begin
							
							sseg = 8'b10110110;
							anode = 4'b0100;
							
							end
							
			4'b001x :	begin
							
							sseg = 8'b10011110;
							anode = 4'b0010;
							
							end
			
			4'b0001 :	begin
							
							sseg = 8'b00000010;
							anode = 4'b0001;
							
							end		
		
		endcase
	end
	

endmodule
