module control_execute_driver(
    input  logic        clk,
    input  logic        RegWriteE,
    input  logic [1:0]  ResultSrcE,
    input  logic        MemWriteE,

    output logic        RegWriteM,
    output logic [1:0]  ResultSrcM,
    output logic        MemWriteM
);

always_ff @( posedge clk ) begin
    RegWriteM  <= RegWriteE;
    ResultSrcM <= ResultSrcE;
    MemWriteM  <= MemWriteE;
end

endmodule