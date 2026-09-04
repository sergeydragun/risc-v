module extend(
    input logic [1:0] ImmSrc,
    input logic [31:7] instr,
    output logic [31:0] ImmExt
    );

    logic sign_bit;
    assign sign_bit = instr[31];

    logic [31:0] imm_i, imm_s, imm_b, imm_j;

    assign imm_i = {{20{sign_bit}}, instr[31:20]};
    assign imm_s = {{20{sign_bit}}, instr[31:25], instr[11:7]};
    assign imm_b = {{20{sign_bit}}, instr[7], instr[30:25], instr[11:8], 1'b0};
    assign imm_j = {{12{sign_bit}}, instr[19:12], instr[20], instr[30:21], 1'b0};


    always_comb begin
        case (ImmSrc)
            2'b00: ImmExt = imm_i;
            2'b01: ImmExt = imm_s;
            2'b10: ImmExt = imm_b;
            2'b11: ImmExt = imm_j;
            default: ImmExt = 32'b0;
        endcase
    end

endmodule