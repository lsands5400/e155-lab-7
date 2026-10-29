// Lindsey Sands
// lsands@g.hmc.edu
// 10-24-2026
// This is the testbench module for the shiftRows module.
`timescale 1 ns/1 ns

module shiftRows_tb();
	
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
    stateIn = 127'h0a0b0c0d_01020304_0d0c0b0a_04030201;
    #10;                        // wait required time
    assert (stateOut == 127'h0a020b01_010c020d_0d030c04_040b030a)       // check outputs
    else 
      $error("shiftRows test failed."); 
    $stop;
  end
endmodule