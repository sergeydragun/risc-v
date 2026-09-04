module fetch_driver(
    input logic clk,
    input logic [31:0] RD,
    output logic [31:0] InstrD
);

always_ff @( posedge clk ) begin
    InstrD <= RD;
end

endmodule