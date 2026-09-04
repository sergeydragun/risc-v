module alu_src_mux(
    input logic  ALUSrc,
    input logic [31:0] rf_rdata2,
    input logic [31:0] ImmExt,
    output logic [31:0] SrcB
);

assign SrcB = ALUSrc == 1 ? ImmExt : rf_rdata2;

endmodule