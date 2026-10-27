// Lindsey Sands
// lsands@g.hmc.edu
// 10-23-2026
// This is the mux module for the addRoundKey input.
module arkMux (input logic[127:0] shift,
                input logic[127:0] mix,
                input logic arkSelect,
                output logic[127:0] path);

    assign path = arkSelect ? shift : mix;

endmodule