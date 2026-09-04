module mux_src_alu_b(
    input logic [1:0] ALUSrcB,
    input logic [31:0] B,
    input logic [31:0] ImmExt
);

always_comb begin
    case (ALUSrcB)
        2'b00: alu_src_b = B;
        2'b01: alu_src_b = ImmExt;
        2'b10: alu_src_b = 32'd4;
    endcase
end

endmodule