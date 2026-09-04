module control_mem_driver(
    input  logic        clk,
    input  logic        RegWriteM,
    input  logic [1:0]  ResultSrcM,

    output logic        RegWriteW,
    output logic [1:0]  ResultSrcW
);

always_ff @( posedge clk ) begin
    RegWriteW  <= RegWriteM;
    ResultSrcW <= ResultSrcM;
end

endmodule