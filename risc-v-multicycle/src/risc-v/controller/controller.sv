module controller(
    input logic [6:0] op,
    input logic [6:0] funct7,
    input logic [2:0] funct3,
    input logic Zero,
    output logic RegWrite,
    output logic [1:0] ImmSrc,
    output logic [1:0] ALUSrcA,
    output logic [1:0] ALUSrcB,
    output logic MemWrite,
    output logic [1:0] ResultSrc,
    output logic PCWrite,
    output logic [2:0] AluControl,
    output logic IRWrite,
    output logic AdrSrc
);

logic [1:0] ALUop;
logic Branch;
logic PCUpdate;

aludec aludec_inst(
    .op_5(op[5]),
    .funct7_5(funct7[5]),
    .ALUop(ALUop),
    .funct3(funct3),
    .AluControl(AluControl)
);

mainFsm mainFsm_inst(
    .op(op),
    .RegWrite(RegWrite),
    .ALUSrcA(ALUSrcA),
    .ALUSrcB(ALUSrcB),
    .MemWrite(MemWrite),
    .ResultSrc(ResultSrc),
    .IRWrite(IRWrite),
    .AdrSrc(AdrSrc),
    .Branch(Branch),
    .PCUpdate(PCUpdate),
    .Aluop(ALUop)
);

assign PCWrite = (Branch & Zero) | PCUpdate;

endmodule