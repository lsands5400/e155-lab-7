// Lindsey Sands
// lsands@g.hmc.edu
// 10-24-2026
// This is the testbench module for the shiftRows module.
`timescale 1 ns/1 ns

module shiftRow_tb();
	
	logic[127:0] stateIn, stateOut;
	logic clk;

	shiftRows dut1 (
		.stateIn(stateIn),
		.stateOut(stateOut)
    );

	// generate clock
	always begin
		clk = 0; #5;
		clk = 1; #5;
	end
		
    initial begin
	
	stateIn = 32'h00000001_00000001_00000001_00000001;
	#10;                        // wait required time
	assert (stateOut == 32'h00000001_00000002_00000004_00000008)       // check outputs
	else 
		$error("shiftRows test failed."); 

    end
endmodule