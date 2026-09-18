module decode_driver(
    input logic clk,
    input logic [31:0] RD1,
    input logic [31:0] RD2,
    input logic [31:0] PCD,
    input logic [31:0] RdD,
    input logic [31:0] ImmExtD,
    input logic [31:0] PCPlus4D,

    output logic [31:0] RD1E,
    output logic [31:0] RD2E,
    output logic [31:0] PCE,
    output logic [31:0] RdE,
    output logic [31:0] ImmExtE,
    output logic [31:0] PCPlus4E
);

always_ff @( posedge clk ) begin
    RD1E     <= RD1;
    RD2E     <= RD2;
    RCE      <= RCD;
    RdE      <= RdD;
    ImmExtE  <= ImmExtD;
    PCPlus4E <= PCPlus4D;
end

endmodule