// Lindsey Sands
// lsands@g.hmc.edu
// 10-23-2026
// This is the addRoundKey module.
module addRoundKey (input logic stateIn,
                    output logic stateOut);

    keyExpansion(stateIn);
    assign stateIn ^ key;
endmodule


module keyExpansion(key);
    initial   $readmemh("Rcon.txt", Rcon);
    i = 0;
    Nk = 3;
    while (i <=  Nk) begin
        w[i] = key[4 * i:4 * i+3]
        i += 1;
    end 

    while (i <= 4*Nr + 3) begin
        temp = w[i - 1];

        if (i % Nk == 0) begin
            temp = subWord(rotWord(temp))^Rcon[i/Nk];
    
        else if ((Nk) > 6) && (i % Nk == 4) 
            temp = subWord(temp);
        end

        w[i] = w[i-Nk]^temp;
        i = i + 1;
    end
endmodule

module rotWord(input logic [31:0] word,
                output logic [31:0] newWord);

    assign newWord = {word[23:0], word[31:24]};

endmodule

module subWord(input logic [31:0] word,
                output logic [31:0] newWord);

    logic [7:0] s0, s1, s2, s3;
    
    sbox s3(word[7:0]);
    sbox s2(word[15:8]);
    sbox s1(word[23:16]);
    sbox s0(word[31:24]);

    assign newWord = {s0, s1, s2, s3};

endmodule

