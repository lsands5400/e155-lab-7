// Lindsey Sands
// lsands@g.hmc.edu
// 10-23-2026
// This is the addRoundKey module.
module addRoundKey (input logic stateIn,
                    output logic stateOut);

    keyExpansion(stateIn);
    assign stateIn ^ key;
endmodule

module cipher (input logic clk, 
                input logic in, 
                input logic Nr, 
                input logic word, 
                output logic done, 
                output logic out);

    logic[3:0] roundNum = 4'b0000;
	logic arkselect;

    addRoundKey ark0(in, word, stateIn);
	
    always_ff @ (posedge clk) begin
        if (roundNum <= Nr - 1) begin
			arkselect <= 0;
			roundNum <= roundNum + 1;
			done <= 0;
        end
        else if (roundNum = Nr) begin
			arkselect <= 1;
			done <= 0;
        end
		else begin
			done <= 1;
		end
    end
	
	sbox sb(stateIn, stateOutSB);
	shiftRows sr(stateOutSB, stateOutSR);
	mixcolumns mc(stateOutSR, stateOutMC);
	arkMux mux(stateOutSR, stateOutMC, arkselect, stateOutMux);
	addRoundKey ark(stateOutMux, stateIn);
	
	if (done == 1) begin
		assign out = stateIn;
	end 
endmodule

module keyExpansion(input logic clk,
                    input logic key,
                    input logic Nr,
                    input logic Nk,
                    output logic word);

    logic[31:0] temp; 
	logic[4:0] i = 1'd0;

    always_ff @ (posedge clk) begin
        if (i <= Nk - 1) begin
            i <= i + 1;
			wordSelect <= 0;
        end 

        if (i <= 4*Nr + 3) begin
			wordSelect <= 1;
            i = i + 1;
        end
    end
	
	if (i <= Nk - 1) begin
            w[i] <= key[4 * i:4 * i+3];
        end 

    if (i <= 4*Nr + 3) begin
		temp <= w[i - 1];

		if (i % Nk == 0) begin
			rotWord rw(temp);
			subWord sw(rw);
			rcon r(i/Nk);
			temp = sw ^ r;
		end

		w[i] = w[i-Nk]^temp;
	end
	
	if (i == 4 * Nr +3) begin
		assign word = w;
	end
endmodule

module rcon(input logic index, 
            output logic value);

    logic [31:0] Rcon[0:9];

    initial   $readmemh("Rcon.txt", Rcon);
    assign value = Rcon[index];

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

