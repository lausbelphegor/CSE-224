`timescale 1ns / 1ps

module top(clk, rst, sseg, anode);

input clk, rst;
output [7:0] sseg;
output [3:0] anode;

wire enable;
reg [2:0] addr;
reg we;
reg [7:0] din;
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
	addr = 0;
	we = 0;
	din = 0;
	case(state_current)

		// Write
		0: begin
			addr = 0;
			we = 1;
			din = 8'b11000101;
			state_next = state_current + 1;
		end
		
		1: begin
			addr = 10;
			we = 1;
			din = 8'b00001001;
			state_next = state_current + 1;
		end

		2: begin
			addr = 20;
			we = 1;
			din = 8'b10000011;
			state_next = state_current + 1;
		end

		3: begin
			addr = 30;
			we = 1;
			din = 8'b00100101;
			state_next = state_current + 1;
		end
		// Read
		4: begin
			addr = 0;
			if (enable == 1'b1) begin
				state_next = state_current + 1;
			end
		end

		5: begin
			addr = 10;
			if (enable == 1'b1) begin
				state_next = state_current + 1;
			end
		end

		6: begin
			addr = 20;
			if (enable == 1'b1) begin
				state_next = state_current + 1;
			end
		end

		7: begin
			addr = 30;
			if (enable == 1'b1) begin
				state_next = 4;
			end
		end
	endcase
end

assign sseg = dout;
assign anode = 4'b0000;

slowdown_unit inst_1(.clk(clk), .rst(rst), .enable(enable));

character_ram inst_character_ram (
  .clka(clk), // input clka
  .wea(we), // input [0 : 0] wea
  .addra(addr), // input [2 : 0] addra
  .dina(din), // input [7 : 0] dina
  .douta(dout) // output [7 : 0] douta
);

endmodule
