module mux_src_alu_a(
    input logic [1:0] ALUSrcA,
    input logic [31:0] PC,
    input logic [31:0] A,
    input logic [31:0] PCOld,
    output logic [31:0] alu_src_a
);

always_comb begin
    case (ALUSrcA)
        2'b00: alu_src_a = PC;
        2'b01: alu_src_a = PCOld;
        2'b10: alu_src_a = A;
    endcase
end

endmodule