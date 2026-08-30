module maindec(
    input logic [6:0] op,
    output logic RegWrite,
    output logic [1:0] ImmSrc,
    output logic ALUSrc,
    output logic MemWrite,
    output logic [1:0] ResultSrc,
    output logic Branch,
    output logic [1:0] ALUop,
    output logic Jump
);

logic [10:0] controller;
assign {RegWrite, ImmSrc, ALUSrc, MemWrite, ResultSrc, Branch, ALUop, Jump} = controller;

always_comb begin
    case(op)
    7'b0110011: begin // R-type
        controller = 11'b1_xx_0_0_00_0_10_0;
    end
    7'b0000011: begin // Load
        controller = 11'b1_00_1_0_01_0_00_0;
    end
    7'b0100011: begin // Store
        controller = 11'b0_01_1_1_xx_0_00_0;
    end
    7'b1100011: begin // Branch
        controller = 11'b0_10_0_0_xx_1_01_0;
    end
    7'b1101111: begin // Jump
        controller = 11'b1_11_x_0_10_0_xx_1;
    end
    7'b0010011: begin //addi
        controller = 11'b1_00_1_0_00_0_10_0; 
    end
    default: controller = 11'b0;
endcase
end


endmodule