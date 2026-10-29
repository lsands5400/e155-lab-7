// Lindsey Sands
// lsands@g.hmc.edu
// 10-23-2026
// This is the shiftRows module.
module shiftRows (input logic [127:0] stateIn,
                    output logic [127:0] stateOut);

    logic[31:0] r0, r1, r2, r3, 
      rOut0, rOut1, rOut2, rOut3;

    assign r0 = {stateIn[127:120], stateIn[95:88], stateIn[63:56], 
        stateIn[31:24]};
    assign r1 = {stateIn[127-8*1:120-8*1], stateIn[95-8*1:88-8*1], 
        stateIn[63-8*1:56-8*1], stateIn[31-8*1:24-8*1]};

    assign r2 = {stateIn[127-8*2:120-8*2], stateIn[95-8*2:88-8*2], 
        stateIn[63-8*2:56-8*2], stateIn[31-8*2:24-8*2]};

    assign r3 = {stateIn[127-8*3:120-8*3], stateIn[95-8*3:88-8*3], 
        stateIn[63-8*3:56-8*3], stateIn[31-8*3:24-8*3]};
 
    shiftRow sr0(r0, 0, rOut0);
    shiftRow sr1(r1, 1,  rOut1);
    shiftRow sr2(r2, 2, rOut2);
    shiftRow sr3(r3, 3,  rOut3);


    assign stateOut = {sr0[31:24], sr1[31:24], sr2[31:24], sr3[31:24],
                sr0[23:16], sr1[23:16], sr2[23:16], sr3[23:16],
                sr0[15:8], sr1[15:8], sr2[15:8], sr3[15:8],
                sr0[7:0], sr1[7:0], sr2[7:0], sr3[7:0]};


endmodule

module shiftRow(input logic [31:0] row,
                input logic [1:0] rowNum,
                output logic [31:0] newRow);
    
    always_comb begin
        case(rowNum)
            2'b00: newRow = row;
            2'b01: newRow = {row[23:0], row[31:24]};
            2'b10: newRow = {row[15:0], row[31:16]};
            2'b11: newRow = {row[7:0], row[31:8]};
        endcase
    end

endmodule