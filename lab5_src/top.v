`timescale 1ns / 1ps

module top(clk, rst, direction, sseg, anode, mode, btn);

input clk, rst, direction, mode, btn;
output [7:0] sseg;
output [3:0] anode;

wire enable;
reg [4:0] addr_1,addr_2,addr_3,addr_4;
wire [7:0] sseg_4,sseg_3,sseg_2,sseg_1;

reg [3:0] state_current, state_next;
reg [4:0] addr_1_current, addr_1_next, addr_2_current, addr_2_next, addr_3_current, addr_3_next;



always@(posedge clk) begin
    if(rst) begin
        state_current <= 0;
        addr_1_current <= 0;
        addr_2_current <= 10;
        addr_3_current <= 0;
    end
    else begin
        state_current <= state_next;
        addr_1_current <= addr_1_next;
        addr_2_current <= addr_2_next;
        addr_3_current <= addr_3_next;
    end
end

always@(*) begin
    state_next = state_current;
    addr_1_next = addr_1_current;
    addr_2_next = addr_2_current;
    addr_3_next = addr_3_current;
    
    if (mode == 1) begin
      case(state_current)
            0: begin
                addr_1 = 22; // o
                addr_2 = 16; // g
                addr_3 = 27; // u
                addr_4 = 29; // z

                if (enable == 1 && direction == 1) begin
                  state_next = 1;
                end else if (enable == 1 && direction == 0) begin
                  state_next = 3;
                end
            end
            1:begin
                addr_1 = 0;  // 0
                addr_2 = 22; // o
                addr_3 = 16; // g
                addr_4 = 27; // u
                
                if (enable == 1 && direction == 1) begin
                  state_next = 2;
                end else if (enable == 1 && direction == 0) begin
                  state_next = 0;
                end
            end
            2:begin
                addr_1 = 29; // z
                addr_2 = 0;  // 0
                addr_3 = 22; // o
                addr_4 = 16; // g
                
                if (enable == 1 && direction == 1) begin
                  state_next = 3;
                end else if (enable == 1 && direction == 0) begin
                  state_next = 1;
                end
            end
            3:begin
                addr_1 = 27; // u
                addr_2 = 29; // z
                addr_3 = 0;  // 0
                addr_4 = 22; // o
                
                if (enable == 1 && direction == 1) begin
                  state_next = 4;
                end else if (enable == 1 && direction == 0) begin
                  state_next = 2;
                end
            end
            4:begin
                addr_1 = 16; // g
                addr_2 = 27; // u
                addr_3 = 29; // z
                addr_4 = 0;  // 0
                
                if (enable == 1 && direction == 1) begin
                  state_next = 0;
                end else if (enable == 1 && direction == 0) begin
                  state_next = 3;
                end
            end
      endcase
    end else if (mode == 0) begin
          case (state_current)

            0:begin
                addr_1_next = (addr_1_current + 1) % 10;
                addr_1 = addr_1_next;
                if (btn == 1) begin
                  state_next = 1;
                end               
              end

            1:begin
                addr_2_next = ((addr_2_current + 1) % 14) + 10;
                addr_2 = addr_2_next;
                if (btn == 1) begin
                  state_next = 2;
                end               
              end
            
            2:begin
                addr_3_next = (addr_3_current + 1) % 10;
                addr_3 = addr_3_next;
                if (btn == 1) begin
                  state_next = 3;
                end               
              end

            3:begin
                  
              end

          endcase
    end
    
end

slowdown_unit inst_1(.clk(clk), .rst(rst), .enable(enable));

character_rom inst_2(
  .clka(clk), // input clka
  .addra(addr_1), // input [4 : 0] addra
  .douta(sseg_1) // output [7 : 0] douta
);

character_rom inst_3(
  .clka(clk), // input clka
  .addra(addr_2), // input [4 : 0] addra
  .douta(sseg_2) // output [7 : 0] douta
);

character_rom inst_4(
  .clka(clk), // input clka
  .addra(addr_3), // input [4 : 0] addra
  .douta(sseg_3) // output [7 : 0] douta
);

character_rom inst_5(
  .clka(clk), // input clka
  .addra(addr_4), // input [4 : 0] addra
  .douta(sseg_4) // output [7 : 0] douta
);

scan_unit inst_6(.clk_s(clk), .rst_s(rst), .sseg_s({sseg_1,sseg_2,sseg_3,sseg_4}), .anode_s(anode), .sout_s(sseg));

endmodule
