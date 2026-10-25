// Lindsey Sands
// lsands@g.hmc.edu
// 10-24-2026
// This is the testbench module for the shiftRows module.
`timescale 1 ns/1 ns

module shiftRow_tb();
	
	logic[127:0] stateIn, stateOut;

	shiftRows dut1 (
		.stateIn(stateIn),
		.stateOut(stateOut)
    );
	
    initial begin
	
	stateIn = 16'h0001000100010001;
	#10;                        // wait required time
	assert (stateOut == 16'h0001001001001000)       // check outputs
	else 
		$error("shiftRows test failed."); 

    end
endmodule