// Code your design here
module VerySimpleCPU(clk, rst, data_fromRAM, wrEn, addr_toRAM, data_toRAM);
  input clk, rst;
  output reg wrEn;
  input [31:0] data_fromRAM;
  output reg [31:0] data_toRAM;
  output reg [13:0] addr_toRAM;
  reg [2:0] st, stN; 
  reg [13:0] PC,PCN;
  reg [31:0] IW, IWN;
  reg [31:0] A, AN, B, BN;
  
  always @ (posedge clk) begin
    st <= stN;
    PC <= PCN;
    IW <= IWN;
    A <= AN;
    B <= BN;   
  end
  
  always @* begin
    stN = 3'hX;
    PCN = PC;
    IWN = IW;
    AN= 32'dX;
    BN= 32'dX;
    wrEn = 1'b0;
    
    if (rst) begin
      PCN = 14'd0;
      stN = 3'h0;
    end
    else begin
      case (st)
        3'h0: begin
          addr_toRAM = PC; // fetch the instruction
          stN = 3'h1;
        end
        3'h1: begin // decode the instruction
          IWN = data_fromRAM;
          if ((data_fromRAM[31:28] == 4'b0010) || (data_fromRAM[31:28] == 4'b0001) || (data_fromRAM[31:28] == 4'b0000) || (data_fromRAM[31:28] == 4'b1101) || (data_fromRAM[31:28] == 4'b1100)) begin// NAND and ADDi and ADD and BZJi and BZJ
            addr_toRAM = data_fromRAM[27:14]; // read *A
            stN = 3'h2;
          end
        end
        
      	3'h2: begin
          if ((IW[31:28] == 4'b0010) || (IW[31:28] == 4'b0000)) begin // NAND and ADD
            AN = data_fromRAM; // store the content *A in A
            addr_toRAM = IW[13:0]; // read *B
          	stN = 3'h3;
          end
          else if (IW[31:28] == 4'b0001) begin // ADDi
            wrEn = 1'b1;
            addr_toRAM = IW[27:14]; //write back to address A
            data_toRAM = data_fromRAM + IW[13:0]; // add *A +B
            PCN = PC + 14'd1;
            stN = 3'h0;  
          end
          else if (IW[31:28] == 4'b1101) begin
            PCN = data_fromRAM + IW[13:0];
            stN = 3'h0;
          end
        end
      	3'h3: begin
          if (IW[31:28] == 4'b0010) begin // NAND 
          	data_toRAM= ~(A & data_fromRAM); // execute nand and write back
           	addr_toRAM = IW[27:14]; // write back to A
           	wrEn = 1'b1;
           	PCN = PC + 14'd1;
          	stN = 3'h0;
          end
          else if (IW[31:28] == 4'b0000) begin // ADD 
            data_toRAM= A + data_fromRAM; // execute add and write back
           	addr_toRAM = IW[27:14]; // write back to A
           	wrEn = 1'b1;
           	PCN = PC + 14'd1;
          	stN = 3'h0;
          end
        end
      endcase
    end
    
  end
  
endmodule

module blram(clk, rst, i_we, i_addr, i_ram_data_in, o_ram_data_out);

parameter SIZE = 14, DEPTH = 2**14;

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

endmodule