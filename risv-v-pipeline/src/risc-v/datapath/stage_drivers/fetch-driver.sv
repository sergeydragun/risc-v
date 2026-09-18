module fetch_driver(
    input logic clk,
    input logic [31:0] RD,
    input logic [31:0] PCF
    input logic [31:0] PCPlus4F

    output logic [31:0] InstrD
    output logic [31:0] PCD
    output logic [31:0] PCPlus4D
);

always_ff @( posedge clk ) begin
    InstrD <= RD;
    PCD <= PCF;
    PCPlus4D <= PCPlus4F;
end

endmodule