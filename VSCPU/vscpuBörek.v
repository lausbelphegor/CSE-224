`timescale 1ns / 1ps

module VerySimpleCPU(clk,rst,data_fromRAM,wrEn,addr_toRAM,data_toRAM);

parameter SIZE  = 14;

input clk,rst;
input wire [31:0] data_fromRAM;
output reg wrEn;
output reg [SIZE-1:0] addr_toRAM;
output reg [31:0] data_toRAM;

reg [3:0] state_reg, state_next;
reg[SIZE-1:0] pc_reg , pc_next ; 
reg[31:0] iw_reg , iw_next ;
reg[31:0] r1_reg , r1_next ;
reg[31:0] r2_reg , r2_next;

always@(posedge clk)begin 
	if(rst)begin
		state_reg <= 0; 
		pc_reg <= 14'b0 ; 
		iw_reg <= 32'b0 ; 
		r1_reg <= 32'b0 ; 
		r2_reg <= 32'b0 ;
	end else begin
		state_reg <= state_next ; 
		pc_reg  	<= pc_next ;
		iw_reg  	<= iw_next ; 
		r1_reg 		<= r1_next ;
		r2_reg 		<= r2_next ;
end end


always@(*)begin
	state_next = state_reg ; 
	pc_next  =  pc_reg ; 
	iw_next =   iw_reg  ; 
	r1_next =  r1_reg ; 
	r2_next = r2_reg ;
	wrEn = 0;
	addr_toRAM = 0;
	data_toRAM = 0; 
	case(state_reg)
		0:begin
			pc_next = 0;
			iw_next = 0;
			r1_next = 0;
			r2_next = 0;
			state_next = 1; 
		end
		1:begin //fetch 
			addr_toRAM = pc_reg ;
			state_next = 2;
		end
		2:begin//fetch opcode 1
			iw_next = data_fromRAM; 
			case(data_fromRAM[31:28])
			//ARITHMETIC & LOGIC INSTRUCTIONS
				{3'b000,1'b0}:begin //ADD
					addr_toRAM = data_fromRAM[27:14];
					state_next = 3;
				end
				{3'b000,1'b1}:begin //ADDi
					addr_toRAM = data_fromRAM[27:14];
					state_next = 4;
				end
				{3'b001,1'b0}:begin //NAND
					addr_toRAM = data_fromRAM[27:14];
					state_next = 3;
				end
				{3'b001,1'b1}:begin //NANDi
					addr_toRAM = data_fromRAM[27:14];
					state_next = 4;
				end
				{3'b010,1'b0}:begin //SRL
					addr_toRAM = data_fromRAM[27:14];
					state_next = 3;
				end
				{3'b010,1'b1}:begin //SRLi
					addr_toRAM = data_fromRAM[27:14];
					state_next = 4;
				end
				{3'b011,1'b0}:begin //LT
					addr_toRAM = data_fromRAM[27:14];
					state_next = 3;
				end
				{3'b011,1'b1}:begin //LTi
					addr_toRAM = data_fromRAM[27:14];
					state_next = 4;
				end
				{3'b111,1'b0}:begin //MUL
					addr_toRAM = data_fromRAM[27:14];
					state_next = 3;
				end
				{3'b111,1'b1}:begin //MULi
					addr_toRAM = data_fromRAM[27:14];
					state_next = 4;
				end
				//DATA TRANSFER INSTRUCTIONS
				{3'b100,1'b0}:begin //CP
					addr_toRAM = data_fromRAM[13:0];//R2 <- mem[IW[13:0]]
					state_next = 4;
				end
				{3'b100,1'b1}:begin //CPi
					addr_toRAM = iw_reg[13:0];//R2 <- IW[13:0]
					state_next = 4;
				end
				{3'b101,1'b0}:begin //CPI
					addr_toRAM = data_fromRAM[13:0];
					state_next = 3;
				end
				{3'b101,1'b1}:begin //CPIi
					addr_toRAM = data_fromRAM[27:14];
					state_next = 3;
				end
				//PROGRAM CONTROL INSTRUCTIONS
				{3'b110,1'b0}:begin //BJZ
					addr_toRAM = data_fromRAM[13:0];
					state_next = 3;
				end
				{3'b110,1'b1}:begin //BJZi
					addr_toRAM = data_fromRAM[27:14];
					state_next = 4;
				end
			
			default:begin
					pc_next = pc_reg ; 
					state_next = 1;
				end 
			endcase
		end
		
		//***    *
		
		3:begin
			case(iw_reg[31:29])
				{3'b000}:begin //ADD
					r1_next = data_fromRAM; 
					addr_toRAM = iw_reg[13:0]; //read other operand B
					state_next = 4;
				end
				{3'b001}:begin //NAND
					r1_next = data_fromRAM ; 
					addr_toRAM = iw_reg[13:0];
					state_next = 4;
				end
				{3'b010}:begin //SRL
					r1_next = data_fromRAM ; 
					addr_toRAM = iw_reg[13:0];
					state_next = 4;
				end
				{3'b011}:begin //LT
					r1_next = data_fromRAM ; 
					addr_toRAM = iw_reg[13:0];
					state_next = 4;
				end
				{3'b111}:begin //MUL
					r1_next = data_fromRAM ; 
					addr_toRAM = iw_reg[13:0];
					state_next = 4;
				end
				{3'b101}:begin//CPI
					r1_next = data_fromRAM;
					addr_toRAM = r1_reg;
					state_next = 4;
				end
				{3'b110, 1'b0}: begin//BJZ
					if(data_fromRAM != 0) begin
						pc_next = pc_reg + 1;
						state_next = 1;
					end
					else begin
						addr_toRAM = iw_reg[27:14];
						state_next = 4;
						iw_next = iw_reg;
					end
				end
			endcase
			case(iw_reg[31:28])
				{3'b000,1'b1}: begin //CPIi
				r1_next = data_fromRAM;
				addr_toRAM = iw_reg[13:0];
				state_next = 4;
			end
			endcase
		end

		//***    *   
		
		
		4:begin
			case(iw_reg[31:28])
			//ARITHMETIC & LOGIC INSTRUCTIONS
				{3'b000,1'b0}:begin //ADD
					wrEn = 1;
					addr_toRAM = iw_reg[27:14];
					data_toRAM = data_fromRAM + r1_reg ; 
					pc_next = pc_reg + 1'b1 ;
					state_next = 1; 
				end
				{3'b000,1'b1}:begin //ADDi
					wrEn = 1;
					addr_toRAM = iw_reg[27:14];
					data_toRAM = data_fromRAM + iw_reg[13:0]; 
					pc_next = pc_reg + 1'b1 ;
					state_next = 1; 
				end
				{3'b001, 1'b0}:begin//NAND
					wrEn = 1;
					addr_toRAM = iw_reg[27:14];
					data_toRAM = ~(data_fromRAM & r1_reg);
					pc_next = pc_reg + 1'b1 ;
					state_next = 1; 
				end
				{3'b001, 1'b1}:begin//NANDi
					wrEn = 1;
					addr_toRAM = iw_reg[27:14];
					data_toRAM = ~(data_fromRAM & iw_reg[13:0]);
					pc_next = pc_reg + 1'b1 ;
					state_next = 1; 
				end
				{3'b010, 1'b0}:begin//SRL
					wrEn = 1;
					addr_toRAM = iw_reg[27:14];
					data_toRAM = (r1_reg < 32) ? (data_fromRAM >> r1_reg) : (data_fromRAM << (r1_reg - 32));
					pc_next = pc_reg + 1'b1 ;
					state_next = 1; 
				end
				{3'b010, 1'b0}:begin//SRLi
					wrEn = 1;
					addr_toRAM = iw_reg[27:14];
					data_toRAM = (iw_reg[13:0] < 32) ? (data_fromRAM >> iw_reg[13:0]) : (data_fromRAM << (iw_reg[13:0] - 32));
					pc_next = pc_reg + 1'b1 ;
					state_next = 1; 
				end
				{3'b011, 1'b0}:begin//LT
					wrEn = 1;
					addr_toRAM = iw_reg[27:14];
					data_toRAM = (data_fromRAM < r1_reg) ? 1 : 0;
					pc_next = pc_reg + 1'b1 ;
					state_next = 1; 
				end
				{3'b011, 1'b1}:begin//LTi
					wrEn = 1;
					addr_toRAM = iw_reg[27:14];
					data_toRAM = (data_fromRAM < iw_reg[13:0]) ? 1 : 0;
					pc_next = pc_reg + 1'b1 ;
					state_next = 1; 
				end
				{3'b011, 1'b0}:begin//MUL
					wrEn = 1;
					addr_toRAM = iw_reg[27:14];
					data_toRAM = (r1_reg * data_fromRAM);
					pc_next = pc_reg + 1'b1 ;
					state_next = 1; 
				end
				{3'b011, 1'b1}:begin//MULi
					wrEn = 1;
					addr_toRAM = iw_reg[27:14];
					data_toRAM = (iw_reg[13:0] * data_fromRAM);
					pc_next = pc_reg + 1'b1 ;
					state_next = 1; 
				end
				
				//DATA TRANSFER INSTRUCTIONS
				
				{3'b100, 1'b0}:begin//CP
					wrEn = 1;
					addr_toRAM = iw_reg[27:14];
					data_toRAM = r1_reg;//data_fromRAM de olur
					pc_next = pc_reg + 1'b1 ;
					state_next = 1; 
				end
				{3'b100, 1'b1}:begin//CPi
					wrEn = 1;
					addr_toRAM = iw_reg[27:14];
					data_toRAM = iw_reg[13:0]; 
					pc_next = pc_reg + 1'b1 ;
					state_next = 1; 
				end
				{3'b101, 1'b0}:begin//CPI
					wrEn = 1;
					addr_toRAM = iw_reg[27:14];
					data_toRAM = data_fromRAM;
					pc_next = pc_reg + 1'b1 ;
					state_next = 1; 
				end
				{3'b101, 1'b1}:begin//CPIi
					wrEn = 1;
					addr_toRAM = data_fromRAM;
					data_toRAM = iw_reg[13:0];
					pc_next = pc_reg + 1'b1 ;
					state_next = 1; 
				end
				
				
				//PROGRAM CONTROL INSTRUCTIONS
				
				{3'b110, 1'b0}:begin//BJZ
					pc_next = data_fromRAM;
					state_next = 1; 
				end
				{3'b110, 1'b1}:begin//BJZi
					pc_next = (iw_reg[13:0] + data_fromRAM);
					state_next = 1; 
				end
			endcase 
		end
		endcase 
	end
	
endmodule

