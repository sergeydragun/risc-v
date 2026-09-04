module alu(
    input logic [31:0] alu_src_a, alu_src_b,
    input logic [2:0] ALUControl,
    output logic [31:0] alu_result,
    output logic Zero
);
    assign Zero = ~|alu_result;

    always_comb begin
        case (ALUControl)
            3'b000: alu_result = alu_src_a + alu_src_b;
            3'b001: alu_result = alu_src_a - alu_src_b;
            3'b010: alu_result = alu_src_a & alu_src_b;
            3'b011: alu_result = alu_src_a | alu_src_b;
            3'b101: alu_result = ($signed(alu_src_a) < $signed(alu_src_b)) ? 32'd1 : 32'd0;
            default: alu_result = 32'b0;
        endcase
    end

endmodule