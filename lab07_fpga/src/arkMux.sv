// Lindsey Sands
// lsands@g.hmc.edu
// 10-23-2026
// This is the mux module for the addRoundKey input.
module arkMux (input logic shift,
                input logic mix,
                input logic arkSelect,
                output logic state);

    assign state = arkSelect ? mix : shift;

endmodule