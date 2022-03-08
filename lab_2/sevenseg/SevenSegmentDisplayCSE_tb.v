`timescale 1ns / 1ps

module SevenSegmentDisplayCSE_tb;

	// Inputs
	reg [3:0] switch_tb;

	// Outputs
	wire [7:0] sseg_tb;
	wire [3:0] anode_tb;

	// Instantiate the Unit Under Test (UUT)
	SevenSegmentDisplayCSE uut (
		.switch(switch_tb), 
		.sseg(sseg_tb), 
		.anode(anode_tb)
	);

	initial begin
		// Initialize Inputs
		switch_tb = 0;

		// Wait 100 ns for global reset to finish
		#15;
      switch_tb = 4'b1111;
		#15;
      switch_tb = 4'b0111;
		#15;
      switch_tb = 4'b0011;
		#15;
      switch_tb = 4'b0001;
		// Add stimulus here

	end
      
endmodule

