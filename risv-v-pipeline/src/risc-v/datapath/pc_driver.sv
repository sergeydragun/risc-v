module pc_driver(
    input logic clk,
    input logic reset,
    input logic [31:0] PCNext,
    output logic [31:0] PC = 32'b0
);

always_ff @(posedge clk or posedge reset) begin : blockName
    if(reset)
        PC <= 31'b0;
    else
        PC <= PCNext;
end

endmodule