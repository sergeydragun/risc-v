module mem_driver(
    input  logic        clk,
    input  logic [31:0] ALUResultM,
    input  logic [31:0] ReadDataM,
    input  logic [4:0]  RdM,
    input  logic [31:0] PCPlus4M,
    
    output logic [31:0] ALUResultW,
    output logic [31:0] ReadDataW,
    output logic [4:0]  RdW,
    output logic [31:0] PCPlus4W
);

always_ff @( posedge clk ) begin
    ALUResultW <= ALUResultM;
    ReadDataW  <= ReadDataM;
    RdW        <= RdM;
    PCPlus4W   <= PCPlus4M;
end

endmodule