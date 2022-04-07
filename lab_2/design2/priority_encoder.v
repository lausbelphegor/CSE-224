`timescale 1ns / 1ps

module priority_encoder(encoder_in, encoder_out);

	input [7:0] encoder_in;
	output reg [7:0] encoder_out;
	
	always@(*)begin
		casex(encoder_in)
			8'b1xxxxxxx: encoder_out = 8'b10000000;
			8'b01xxxxxx: encoder_out = 8'b01000000;
			8'b001xxxxx: encoder_out = 8'b00100000;
			8'b0001xxxx: encoder_out = 8'b00010000;
			8'b00001xxx: encoder_out = 8'b00001000;
			8'b000001xx: encoder_out = 8'b00000100;
			8'b0000001x: encoder_out = 8'b00000010;
			8'b00000001: encoder_out = 8'b00000001;	
			8'b00000000: encoder_out = 8'b00000000;	
		endcase
	end

endmodule
