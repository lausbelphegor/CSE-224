`timescale 1ns / 1ps

module top(clk, rst, sseg, anode);

input clk, rst;
output [7:0] sseg;
output [3:0] anode;

wire enable = 1'b1; ///////
reg [4:0] addr;
wire [7:0] dout;

reg [3:0] state_current, state_next;

always@(posedge clk) begin
	if(rst) begin
		state_current <= 0;
	end
	else begin
		state_current <= state_next;
	end
end

always@(*) begin
	state_next = state_current;
	case(state_current)
		0:begin
			addr = 22; // O
			if (enable == 1'b1) begin
				state_next = state_current + 1;
			end
		end

		1:begin
			addr = 16; // G
			if (enable == 1'b1) begin
				state_next = state_current + 1;
			end
		end

		2:begin
			addr = 27; // U
			if (enable == 1'b1) begin
				state_next = state_current + 1;
			end
		end

		3:begin
			addr = 29; // Z
			if (enable == 1'b1) begin
				state_next = 0;
			end
		end
	endcase
end

assign sseg1 = dout;
assign anode = 4'b0000;

//slowdown_unit inst_1(.clk(clk), .rst(rst), .enable(enable));

character_rom inst_2(
  .clka(clk), // input clka
  .addra(addr), // input [4 : 0] addra
  .douta(dout) // output [7 : 0] douta
);


endmodule
