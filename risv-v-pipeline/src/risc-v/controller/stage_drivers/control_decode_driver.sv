module control_decode_driver(
    input  logic        clk,
    input  logic        RegWriteD,
    input  logic [1:0]  ResultSrcD,
    input  logic        MemWriteD,
    input  logic        JumpD,
    input  logic        BranchD,
    input  logic [2:0]  ALUControlD,
    input  logic        ALUSrcD,

    output logic        RegWriteE,
    output logic [1:0]  ResultSrcE,
    output logic        MemWriteE,
    output logic        JumpE,
    output logic        BranchE,
    output logic [2:0]  ALUControlE,
    output logic        ALUSrcE
);

always_ff @( posedge clk ) begin
    RegWriteE   <= RegWriteD;
    ResultSrcE  <= ResultSrcD;
    MemWriteE   <= MemWriteD;
    JumpE       <= JumpD;
    BranchE     <= BranchD;
    ALUControlE <= ALUControlD;
    ALUSrcE     <= ALUSrcD;
end

endmodule