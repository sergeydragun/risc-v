module controller(
    input logic [6:0] op,
    input logic [6:0] funct7,
    input logic [2:0] funct3,
    input logic Zero,
    output logic RegWrite,
    output logic [1:0] ImmSrc,
    output logic ALUSrc,
    output logic MemWrite,
    output logic [1:0] ResultSrc,
    output logic PCsrc,
    output logic [2:0] AluControl
);

logic [1:0] ALUop;
logic Branch;
logic Jump;

maindec maindec_inst(
    .op(op),
    .RegWrite(RegWrite),
    .ImmSrc(ImmSrc),
    .ALUSrc(ALUSrc),
    .MemWrite(MemWrite),
    .ResultSrc(ResultSrc),
    .Branch(Branch),
    .ALUop(ALUop),
    .Jump(Jump)
);

aludec aludec_inst(
    .op_5(op[5]),
    .funct7_5(funct7[5]),
    .ALUop(ALUop),
    .funct3(funct3),
    .AluControl(AluControl)
);

assign PCsrc = (Branch & Zero) | Jump;

endmodule