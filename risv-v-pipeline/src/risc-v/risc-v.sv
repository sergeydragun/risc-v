module riscv(
    input logic clk,
    input logic reset,
    input logic [31:0] instr,
    input logic [31:0] dmem_rdata,
    output logic [31:0] dmem_wdata,
    output logic MemWrite,
    output logic [31:0] PC,
    output logic [31:0] dmem_addr
);

logic Zero;
logic RegWrite;
logic [1:0] ImmSrc;
logic ALUSrc;
logic [1:0] ResultSrc;
logic PCsrc;
logic [2:0] AluControl;

controller controller_inst(
    .op(instr[6:0]),
    .funct7(instr[31:25]),
    .funct3(instr[14:12]),
    .Zero(Zero),
    .RegWrite(RegWrite),
    .ImmSrc(ImmSrc),
    .ALUSrc(ALUSrc),
    .MemWrite(MemWrite),
    .ResultSrc(ResultSrc),
    .PCsrc(PCsrc),
    .AluControl(AluControl)
);

datapath datapath_inst(
    .clk(clk),
    .reset(reset),
    .RegWrite(RegWrite),
    .rs1(instr[19:15]), 
    .rs2(instr[24:20]), 
    .rd(instr[11:7]),
    .dmem_rdata(dmem_rdata),
    .ResultSrc(ResultSrc),
    .ALUControl(AluControl),
    .ALUSrc(ALUSrc),
    .ImmSrc(ImmSrc),
    .instr(instr[31:7]),
    .PCsrc(PCsrc),
    .PC(PC),
    .Zero(Zero),
    .dmem_wdata(dmem_wdata),
    .alu_result(dmem_addr)
);


endmodule