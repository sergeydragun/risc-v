module instrdec(
    input logic [6:0] op,
    output logic [1:0] imm_src
);

always_comb begin
    case(op)
        7'b0110011: begin // R-type
        imm_src = 2'bxx;
    end
    7'b0000011: begin // Load
        imm_src = 2'b00;
    end
    7'b0100011: begin // Store
        imm_src = 2'b01;
    end
    7'b1100011: begin // Branch
        imm_src = 2'b10;
    end
    7'b1101111: begin // Jump
        imm_src = 2'b11;
    end
    7'b0010011: begin //addi
        imm_src = 2'b00; 
    end
    default: imm_src = 2'b0;
    endcase
end
endmodule