module aludec(
    input logic op_5,
    input logic funct7_5,
    input logic [1:0] ALUop,
    input logic [2:0] funct3,
    output logic [2:0] AluControl
);

always_comb begin
    case (ALUop)
    2'b00: begin
        AluControl = 3'b000;
    end
    2'b01: begin
        AluControl = 3'b001;
    end
    2'b10: begin
        case (funct3)
            3'b000: begin
                case ({op_5, funct7_5})
                    2'b01, 2'b00, 2'b10: AluControl = 3'b000;
                    2'b11: AluControl = 3'b001;
                    default: AluControl = 3'bxxx;
                endcase
            end
            3'b010: begin
                AluControl = 3'b101;
            end
            3'b110: begin
                AluControl = 3'b011;
            end
            3'b111: begin
                AluControl = 3'b010;
            end
            default: AluControl = 3'bxxx;
        endcase
    end
    default: AluControl = 3'bxxx;
endcase
end

endmodule