// Lindsey Sands
// lsands@g.hmc.edu
// 10-23-2026
// This is the addRoundKey module.
module addRoundKey (input logic stateIn,
                    input logic word,
                    output logic stateOut);


endmodule


module keyExpansion()

endmodule

module rotWord(input logic [31:0] word,
                output logic [31:0] newWord);

    assign newWord = {word[23:0], word[31:24]};

endmodule

module subWord(input logic [31:0] word,
                output logic [31:0] newWord);

    logic [7:0] s0, s1, s2, s3;
    
    sbox s0(word[7:0]);
    sbox s1(word[15:8]);
    sbox s2(word[23:16]);
    sbox s3(word[31:24]);

    assign newWord = {s0, s1, s2, s3};

endmodule

initial   $readmemh("Rcon.txt", Rcon);