`timescale 1ns / 1ns

module tb;
parameter SIZE = 14, DEPTH = 1024;

reg clk;
initial begin
  clk = 1;
  forever
	  #5 clk = ~clk;
end

reg rst;
initial begin
  rst = 1;
  repeat (10) @(posedge clk);
  rst <= #1 0;
  repeat (600) @(posedge clk);
  //uncomment the following line to display the content at address 50 in console
  $display("Content of address 50 is %d.", inst_blram.memory[50]);
  $finish;
end

wire wrEn;
wire [SIZE-1:0] addr_toRAM;
wire [31:0] data_toRAM, data_fromRAM;

VerySimpleCPU inst_VerySimpleCPU(
  .clk(clk),
  .rst(rst),
  .wrEn(wrEn),
  .data_fromRAM(data_fromRAM),
  .addr_toRAM(addr_toRAM),
  .data_toRAM(data_toRAM)
);

blram #(SIZE, DEPTH) inst_blram(
  .clk(clk),
  .rst(rst),
  .i_we(wrEn),
  .i_addr(addr_toRAM),
  .i_ram_data_in(data_toRAM),
  .o_ram_data_out(data_fromRAM)
);

endmodule

module blram(clk, rst, i_we, i_addr, i_ram_data_in, o_ram_data_out);

parameter SIZE = 10, DEPTH = 1024;

input clk;
input rst;
input i_we;
input [SIZE-1:0] i_addr;
input [31:0] i_ram_data_in;
output reg [31:0] o_ram_data_out;

reg [31:0] memory[0:DEPTH-1];

always @(posedge clk) begin
  o_ram_data_out <= #1 memory[i_addr[SIZE-1:0]];
  if (i_we)
		memory[i_addr[SIZE-1:0]] <= #1 i_ram_data_in;
end 

initial begin
//////////////////////////
// write BRAM content here
memory[0] = 32'hd000c011;
memory[1] = 32'h32;
memory[2] = 32'h32;
memory[3] = 32'h0;
memory[4] = 32'hffffffff;
memory[5] = 32'h0;
memory[6] = 32'h0;
memory[7] = 32'h0;
memory[8] = 32'h0;
memory[9] = 32'h0;
memory[10] = 32'h0;
memory[11] = 32'h0;
memory[12] = 32'h0;
memory[13] = 32'h0;
memory[14] = 32'h0;
memory[15] = 32'h0;
memory[16] = 32'h0;
memory[17] = 32'h9002c018;
memory[18] = 32'hb000400b;
memory[19] = 32'h10004001;
memory[20] = 32'hb0004002;
memory[21] = 32'h10004001;
memory[22] = 32'h80008001;
memory[23] = 32'hd000c01b;
memory[24] = 32'h4004;
memory[25] = 32'ha002c001;
memory[26] = 32'hd000c01a;
memory[27] = 32'h9002c01e;
memory[28] = 32'hb000400b;
memory[29] = 32'h10004001;
memory[30] = 32'h9002c00c;
memory[31] = 32'hb000400b;
memory[32] = 32'h10004001;
memory[33] = 32'h4004;
memory[34] = 32'ha0030001;
memory[35] = 32'h4004;
memory[36] = 32'ha002c001;
memory[37] = 32'h2c00c;
memory[38] = 32'hb000400b;
memory[39] = 32'h10004001;
memory[40] = 32'h4004;
memory[41] = 32'ha002c001;
memory[42] = 32'h80004002;
memory[43] = 32'h4004;
memory[44] = 32'ha0008001;
memory[45] = 32'h4004;
memory[46] = 32'ha0030001;
memory[47] = 32'hb000400b;
memory[48] = 32'h10004001;
memory[49] = 32'hd0030000;


//////////////////////////
end

endmodule
