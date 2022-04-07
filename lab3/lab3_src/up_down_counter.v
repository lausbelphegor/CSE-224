`timescale 1ns / 1ps

module up_down_counter(clk, rst, enable, up_down, digit_1, digit_2, digit_3, digit_4);

	input clk, rst, up_down, enable;
	output reg [3:0] digit_1, digit_2, digit_3, digit_4;
	
	reg [3:0] digit_1_next, digit_2_next, digit_3_next, digit_4_next;
	
	always@(posedge clk)begin

		if(rst == 1'b1)begin
			digit_1 <= 4'b0000;
			digit_2 <= 4'b0000;
			digit_3 <= 4'b0000;
			digit_4 <= 4'b0000;
		end

		else begin
			digit_1 <= digit_1_next;
			digit_2 <= digit_2_next;
			digit_3 <= digit_3_next;
			digit_4 <= digit_4_next;
		end

	end
	
	always@(*)begin
		if(up_down == 1'b1 && enable == 1'b1)begin // count up

			if(digit_1 == 4'b1001)begin
				digit_1_next = 4'b0000;

				if(digit_2 == 4'b1001)begin
					digit_2_next = 4'b0000;

					if(digit_3 == 4'b1001)begin
						digit_3_next = 4'b0000;

						if(digit_4 == 4'b1001)begin
							digit_4_next = 4'b0000;

						end else begin
							digit_4_next = digit_4 + 1'b1;
						end

					end else begin
						digit_3_next = digit_3 + 1'b1;
						digit_4_next = digit_4;
					end

				end else begin
					digit_2_next = digit_2 + 1'b1;
					digit_3_next = digit_3;
					digit_4_next = digit_4;
				end

			end	else begin
				digit_1_next = digit_1 + 1'b1;
				digit_2_next = digit_2;
				digit_3_next = digit_3;
				digit_4_next = digit_4;
			end
		end


		else if(up_down == 1'b0 && enable == 1'b1)begin // count down

			if(digit_1 == 4'b0000)begin
				digit_1_next = 4'b1001;

				if(digit_2 == 4'b0000)begin
					digit_2_next = 4'b1001;

					if(digit_3 == 4'b0000)begin
						digit_3_next = 4'b1001;

						if(digit_4 == 4'b0000)begin
							digit_4_next = 4'b1001;
							
						end else begin
							digit_4_next = digit_4 - 1'b1;
						end

					end else begin
						digit_3_next = digit_3 - 1'b1;
						digit_3_next = digit_3;
					end

				end else begin
					digit_2_next = digit_2 - 1'b1;
					digit_3_next = digit_3;
					digit_4_next = digit_4;
				end

			end	else begin
				digit_1_next = digit_1 - 1'b1;
				digit_2_next = digit_2;
				digit_3_next = digit_3;
				digit_4_next = digit_4;
			end
			
		end



		else begin
			digit_1_next = digit_1;
			digit_2_next = digit_2;
			digit_3_next = digit_3;
			digit_4_next = digit_4;
		end
	
	end

endmodule
