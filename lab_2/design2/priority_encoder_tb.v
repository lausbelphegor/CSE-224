`timescale 1ns / 1ps

module priority_encoder_tb;

	// Outputs
	wire tb_encoder_out;
	reg tb_encoder_in;

	// Instantiate the Unit Under Test (UUT)
	priority_encoder uut (
		.encoder_out(tb_encoder_out)
		.encoder_in(tb_encoder_in)
	);

	initial begin
		// Initialize Inputs

		// Wait 100 ns for global reset to finish
		#15;
		tb_encoder_in =$random;
		#15;
		tb_encoder_in =$random;
		#15;
		tb_encoder_in =$random;
		#15;
		tb_encoder_in =$random;
		#15;
		tb_encoder_in =$random;
		#15;
		tb_encoder_in =$random;
		#15;
		tb_encoder_in =$random;
		#15;
		tb_encoder_in =$random;
		#15;
		tb_encoder_in =$random;
		 
		end

      
endmodule

