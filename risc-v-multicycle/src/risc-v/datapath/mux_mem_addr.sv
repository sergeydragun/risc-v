module mux_mem_addr(
    input logic adr_src,
    input logic [31:0] PC,
    input logic [31:0] result,
    output logic [31:0] mem_addr
);

always_comb begin
    case (adr_src)
        1'b0: mem_addr = PC;
        1'b1: mem_addr = result;
    endcase
end

endmodule