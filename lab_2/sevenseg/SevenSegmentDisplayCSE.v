`timescale 1ns / 1ps

module SevenSegmentDisplayCSE(switch, sseg, anode);

	input [3:0] switch;
	output reg [7:0] sseg;
	output reg [3:0] anode;
		
										
	always@(*)begin
		casex(switch)
			
			
			4'b1xxx :	begin
							
							sseg = 8'b01001110;
							anode = 4'b0111;
							
							end
			
			4'b01xx :	begin
							
							sseg = 8'b01011011;
							anode = 4'b0011;
							
							end
							
			4'b001x :	begin
							
							sseg = 8'b01001111;
							anode = 4'b0001;
							
							end
			
			4'b0001 :	begin
							
							sseg = 8'b00000001;
							anode = 4'b0000;
							
							end		
		
		endcase
	end
	

endmodule
