`timescale 1ns / 1ps

module top(clk, rst);

input clk, rst;

wire enable;
reg addr;
reg we;
reg[7:0] l_1, l_2, din, count_current, count_next;
wire[7:0] dout;
reg [3:0] state_current, state_next;


always@(posedge clk) begin
    if(rst) begin
        state_current <= 0;
        count_current <= 0;
    end
    else begin
        state_current <= state_next;
        count_current <= count_next;
    end
end

always@(*) begin
    state_next = state_current;
    we = 0;
    
    begin
      case(state_current)

            // Write
            0: begin

              addr = 0;
              we = 1;
              din = 2;
              state_next = state_current + 1;

            end

            1:begin
              
              addr = 1;
              we = 1;
              din = 1;
              state_next = state_current + 1;

            end

            // Read
            2:begin
              if (enable == 1) begin
                addr = 0;
                state_next = state_current + 1;
              end
            end

            3:begin
              if (enable == 1) begin
                addr = 1;
                state_next = state_current + 1;
              end
            end

            // Calculate & Write
            4:begin
              if (enable == 1) begin
                din = l_1 + l_2;
                addr = count_current%2;
                we = 1;
                state_next = 2 + addr;
                count_next = count_current + 1;
              end
            end

          endcase
    end
    
end

if (addr && !we) begin
  assign l_1 <= dout;
end else if (!we) begin
  assign l_2 <= dout;
end

slowdown_unit inst_1(.clk(clk), .rst(rst), .enable(enable));

character_ram inst_character_ram (
  .clka(clk), // input clka
  .wea(we), // input [0 : 0] wea
  .addra(addr), // input [2 : 0] addra
  .dina(din), // input [7 : 0] dina
  .douta(dout) // output [7 : 0] douta
);

endmodule
