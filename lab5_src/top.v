`timescale 1ns / 1ps

module top(clk, rst, direction, sseg, anode, mode, select_1, select_2, select_3);

input clk, rst, direction, mode, select;
output [7:0] sseg;
output [3:0] anode;

wire enable;
reg [4:0] addr_1,addr_2,addr_3,addr_4;
wire [7:0] sseg_4,sseg_3,sseg_2,sseg_1;

reg [3:0] state_current, state_next;

addr_1 = 0;
addr_2 = 0;
addr_3 = 0;
addr_4 = 0;

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
                addr_1 = 16; // g
                addr_2 = 27; // u
                addr_3 = 29; // z
                addr_4 = 22; // o
                if (enable == 1 && direction == 1) begin
                  state_next = 2;
                end else if (enable == 1 && direction == 0) begin
                  state_next = 0;
                end
            end
            2:begin
                addr_1 = 27; // u
                addr_2 = 29; // z
                addr_3 = 22; // o
                addr_4 = 16; // g
                if (enable == 1 && direction == 1) begin
                  state_next = 3;
                end else if (enable == 1 && direction == 0) begin
                  state_next = 1;
                end
            end
            3:begin
                addr_1 = 29; // z
                addr_2 = 22; // o
                addr_3 = 16; // g
                addr_4 = 27; // u
                if (enable == 1 && direction == 1) begin
                  state_next = 0;
                end else if (enable == 1 && direction == 0) begin
                  state_next = 2;
                end
            end
      endcase
    end else if (mode == 0) begin
        case (state_current)


          0:begin
              addr_1 = 0;
              if (select == 0) begin
                  state_next = 1;
              end else if (select == 1) begin
                  state_next = 11;
              end
            end
          1:begin
            addr_1 = 1;
              if (select == 0) begin
                  state_next = 2;
              end else if (select == 1) begin
                  state_next = 11;
              end
            end
          2:begin
            addr_1 = 2;
              if (select == 0) begin
                  state_next = 3;
              end else if (select == 1) begin
                  state_next = 11;
              end
            end
          3:begin
            addr_1 = 3;
              if (select == 0) begin
                  state_next = 4;
              end else if (select == 1) begin
                  state_next = 11;
              end
            end
          4:begin
            addr_1 = 4;
              if (select == 0) begin
                  state_next = 5;
              end else if (select == 1) begin
                  state_next = 11;
              end
            end
          5:begin
            addr_1 = 5;
              if (select == 0) begin
                  state_next = 6;
              end else if (select == 1) begin
                  state_next = 11;
              end
            end
          6:begin
            addr_1 = 6;
              if (select == 0) begin
                  state_next = 7;
              end else if (select == 1) begin
                  state_next = 11;
              end
            end
          7:begin
            addr_1 = 7;
              if (select == 0) begin
                  state_next = 8;
              end else if (select == 1) begin
                  state_next = 11;
              end
            end
          8:begin
            addr_1 = 8;
              if (select == 0) begin
                  state_next = 9;
              end else if (select == 1) begin
                  state_next = 11;
              end
            end
          9:begin
            addr_1 = 9;
              if (select == 0) begin
                  state_next = 0;
              end else if (select == 1) begin
                  state_next = 11;
              end
            end


          11:begin
              addr_2 = 10;
              if (select == 0) begin
                
                state_next = 12;
              end
            end
          12:begin
              if (select == 0) begin
                addr_2 = 25;
                state_next = 13;
              end
            end
          13:begin
              if (select == 0) begin
                addr_2 = 13;
                state_next = 14;
              end
            end
          14:begin
              if (select == 0) begin
                addr_2 = 21;
                state_next = 11;
              end
            end


          20:begin
              addr_3 = 0;
              if (select == 0) begin
                  state_next = 21;
              end else if (select == 1) begin
                  state_next = 11;
              end
            end
          21:begin
            addr_3 = 1;
              if (select == 0) begin
                  state_next = 22;
              end else if (select == 1) begin
                  state_next = 11;
              end
            end
          22:begin
            addr_3 = 2;
              if (select == 0) begin
                  state_next = 23;
              end else if (select == 1) begin
                  state_next = 11;
              end
            end
          23:begin
            addr_3 = 3;
              if (select == 0) begin
                  state_next = 24;
              end else if (select == 1) begin
                  state_next = 11;
              end
            end
          24:begin
            addr_3 = 4;
              if (select == 0) begin
                  state_next = 25;
              end else if (select == 1) begin
                  state_next = 11;
              end
            end
          25:begin
            addr_3 = 5;
              if (select == 0) begin
                  state_next = 26;
              end else if (select == 1) begin
                  state_next = 11;
              end
            end
          26:begin
            addr_3 = 6;
              if (select == 0) begin
                  state_next = 27;
              end else if (select == 1) begin
                  state_next = 11;
              end
            end
          27:begin
            addr_3 = 7;
              if (select == 0) begin
                  state_next = 28;
              end else if (select == 1) begin
                  state_next = 11;
              end
            end
          28:begin
            addr_3 = 8;
              if (select == 0) begin
                  state_next = 29;
              end else if (select == 1) begin
                  state_next = 11;
              end
            end
          29:begin
            addr_3 = 9;
              if (select == 0) begin
                  state_next = 20;
              end else if (select == 1) begin
                  state_next = 11;
              end
            end
          30:begin
            if (addr_2 == 10) begin
              addr_4 = addr_1 + addr_3;
            end else if(addr_2 == 25) begin
              addr_4 = addr_1 - addr_3;
            end else if(addr_2 == 13) begin
              addr_4 = addr_1 / addr_3;
            end else if(addr_2 == 21) begin
              addr_4 = addr_1 * addr_3;
            end
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
