// Lindsey Sands
// lsands@g.hmc.edu
// 10-24-2026
// This is the testbench module for the shiftRow module.
`timescale 1 ns/1 ns

module shiftRow_tb();
	
	logic[31:0]	row, newRow;
	logic[1:0]	rowNum;

    shiftRow dut (
		.row(row),
        .rowNum(rowNum),

        .newRow(newRow)
    );
	
    initial begin
	
	row = 4'h0001;
    rowNum = 2'b00;
	#10;                        // wait required time
	assert (newRow == 4'h0001)       // check outputs
	else 
		$error("Row 0 test failed."); 

    row = 4'h0001;
    rowNum = 2'b01;
	#10;                        // wait required time
	assert (newRow == 4'h0010)       // check outputs
	else 
		$error("Row 1 test failed."); 

    row = 4'h0001;
    rowNum = 2'b10;
	#10;                        // wait required time
	assert (newRow == 4'h0100)       // check outputs
	else 
		$error("Row 2 test failed."); 

    row = 4'h0001;
    rowNum = 2'b11;
	#10;                        // wait required time
	assert (newRow == 4'h1000)       // check outputs
	else 
		$error("Row 0 test failed."); 
	
    end
endmodule