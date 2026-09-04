module execute_driver(
    input  logic        clk,
    input  logic [31:0] ALUResultE,
    input  logic [31:0] WriteDataE,
    input  logic [4:0]  RdE,
    input  logic [31:0] PCPlus4E,
    
    output logic [31:0] ALUResultM,
    output logic [31:0] WriteDataM,
    output logic [4:0]  RdM,
    output logic [31:0] PCPlus4M
);

always_ff @( posedge clk ) begin
    ALUResultM <= ALUResultE;
    WriteDataM <= WriteDataE;
    RdM        <= RdE;
    PCPlus4M   <= PCPlus4E;
end

endmodule