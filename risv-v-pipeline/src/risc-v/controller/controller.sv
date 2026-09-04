module controller(
    input  logic        clk,
    input  logic [6:0]  op,
    input  logic [6:0]  funct7,
    input  logic [2:0]  funct3,
    input  logic        ZeroE,

    output logic        RegWriteW,
    output logic [1:0]  ImmSrcD,
    output logic        ALUSrcE,
    output logic        MemWriteM,
    output logic [1:0]  ResultSrcW,
    output logic        PCsrcE,
    output logic [2:0]  AluControlE
);

    logic [1:0] ALUop;
    logic BranchD;
    logic JumpD;

    logic        RegWriteD;
    logic        ALUSrcD;
    logic        MemWriteD;
    logic [1:0]  ResultSrcD;
    logic [2:0]  AluControlD;

    logic        RegWriteE;
    logic [1:0]  ResultSrcE;
    logic        MemWriteE;
    logic        BranchE;
    logic        JumpE;

    logic        RegWriteM;
    logic [1:0]  ResultSrcM;

    maindec maindec_inst(
        .op(op),
        .RegWrite(RegWriteD),
        .ImmSrc(ImmSrcD),
        .ALUSrc(ALUSrcD),
        .MemWrite(MemWriteD),
        .ResultSrc(ResultSrcD),
        .Branch(BranchD),
        .ALUop(ALUop),
        .Jump(JumpD)
    );

    aludec aludec_inst(
        .op_5(op[5]),
        .funct7_5(funct7[5]),
        .ALUop(ALUop),
        .funct3(funct3),
        .AluControl(AluControlD)
    );

    control_decode_driver control_decode_driver_inst(
        .clk(clk),
        .RegWriteD(RegWriteD),
        .ResultSrcD(ResultSrcD),
        .MemWriteD(MemWriteD),
        .JumpD(JumpD),
        .BranchD(BranchD),
        .ALUControlD(AluControlD),
        .ALUSrcD(ALUSrcD),
        .RegWriteE(RegWriteE),
        .ResultSrcE(ResultSrcE),
        .MemWriteE(MemWriteE),
        .JumpE(JumpE),
        .BranchE(BranchE),
        .ALUControlE(AluControlE),
        .ALUSrcE(ALUSrcE)
    );

    control_execute_driver control_execute_driver_inst(
        .clk(clk),
        .RegWriteE(RegWriteE),
        .ResultSrcE(ResultSrcE),
        .MemWriteE(MemWriteE),
        .RegWriteM(RegWriteM),
        .ResultSrcM(ResultSrcM),
        .MemWriteM(MemWriteM)
    );

    control_mem_driver control_mem_driver_inst(
        .clk(clk),
        .RegWriteM(RegWriteM),
        .ResultSrcM(ResultSrcM),
        .RegWriteW(RegWriteW),
        .ResultSrcW(ResultSrcW)
    );

    assign PCsrcE = (BranchE & ZeroE) | JumpE;

endmodule