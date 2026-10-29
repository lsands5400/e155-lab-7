// Lindsey Sands
// lsands@g.hmc.edu
// 10-23-2026
// This is the addRoundKey module.
module addRoundKey (input logic clk,
					input logic[31:0] key, // TODO: Is this the right size?
					input logic[3:0] Nr,
					input logic[2:0] Nk,
					input logic[127:0] stateIn,
                    output logic[127:0] stateOut);
	
	logic[127:0] word;

    keyExpansion ke(clk, key, Nr, Nk, word);
    assign stateOut = stateIn ^ word;
endmodule

module cipher (input logic clk, 
                input logic[127:0] in, 
                input logic[3:0] Nr, 
				input logic[2:0] Nk,
                input logic[31:0] word, 
                output logic done, 
                output logic[127:0] out);

  logic[3:0] roundNum = 4'b0000;
	logic arkselect;
  logic[127:0] stateIn, stateOut, stateOutMC, stateOutMux, 
    stateOutSB, stateOutSR;

    addRoundKey ark0(clk, word, Nr, Nk, in, stateIn);
	
    always_ff @ (posedge clk) begin
        if (roundNum <= Nr - 1) begin
          arkselect <= 0;
          roundNum <= roundNum + 1;
          done <= 0;
        end
        else if (roundNum == Nr) begin
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
	addRoundKey ark(clk, word, Nr, Nk, stateOutMux, stateIn);
	
	if (done == 1) begin
		assign out = stateIn;
	end 
endmodule

module keyExpansion(input logic clk,
                    input logic[31:0] key,
                    input logic[3:0] Nr,
                    input logic[2:0] Nk,
                    output logic[127:0] word);

  logic[31:0] temp, newNew, newTemp, rOut; 
	logic[4:0] i = 1'd0;
  logic[127:0] w;

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
    assign w[i] = key[4 * i:4 * i+3];
  end 

  if (i <= 4*Nr + 3) begin
    assign temp = w[i - 1];

    if (i % Nk == 0) begin
      rotWord rw(temp, newTemp);
      subWord sw(newTemp, newNew);
      rcon r(i/Nk, rOut);
      assign temp = newNew ^ rOut;
    end

    assign w[i] = w[i-Nk]^temp;
	end
	
	if (i == 4 * Nr +3) begin
		assign word = w;
	end
endmodule

module rcon(input logic[3:0] index, 
            output logic[31:0] value);

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
    
    sbox s3(word[7:0]);
    sbox s2(word[15:8]);
    sbox s1(word[23:16]);
    sbox s0(word[31:24]);

    assign newWord = {s0, s1, s2, s3};

endmodule

