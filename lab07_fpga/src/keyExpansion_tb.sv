// Lindsey Sands
// lsands@g.hmc.edu
// 10-24-2026
// This is the testbench module for the keyExpansion module.
`timescale 1 ns/1 ns

module keyExpansion_tb();
	
	logic[127:0] stateIn, stateOut;
	logic clk;

	keyExpansion dut1 (
		.stateIn(stateIn),
		.stateOut(stateOut)
    );

	// generate clock
	always begin
		clk = 0; #5;
		clk = 1; #5;
	end
		
    initial begin
	
	stateIn = 127'h2b7e151628aed2a6abf7158809cf4f3c;
	#10;                        // wait required time
	assert (stateOut == 127'h0001001001001000)       // check outputs
	else 
		$error("shiftRows test failed."); 

    end
endmodule