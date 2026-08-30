module datapath(
    input logic clk,
    input logic reset,
    input logic RegWrite,
    input logic [4:0] rs1, rs2, rd,
    input logic [31:0] dmem_rdata,
    input logic [1:0] ResultSrc,
    input logic [2:0] ALUControl,
    input logic ALUSrc,
    input logic [1:0] ImmSrc,
    input logic [31:7] instr,
    input logic PCsrc,
    output logic [31:0] PC,
    output logic Zero,
    output logic [31:0] dmem_wdata,
    output logic [31:0] alu_result
);

logic [31:0] PcPlus4, PCtarget, PCNext;
logic [31:0] ImmExt;

adder pc_base_iter(
    .a(PC),
    .b(32'd4),
    .sum(PcPlus4)
);

adder pc_imm_iter(
    .a(PC),
    .b(ImmExt),
    .sum(PCtarget)
);

pc_mux pc_mux_inst(
    .PCsrc(PCsrc),
    .PCtarget(PCtarget),
    .PcPlus4(PcPlus4),
    .PCNext(PCNext)
);

pc_driver pc_driver_inst(
    .clk(clk),
    .reset(reset),
    .PCNext(PCNext),
    .PC(PC)
);

logic [31:0] Result;

logic [31:0] rf_rdata1, rf_rdata2;
logic [31:0] SrcA, SrcB;

extend extend_inst(
    .ImmSrc(ImmSrc),
    .instr(instr),
    .ImmExt(ImmExt)
);

alu_src_mux alu_src_mux_inst(
    .ALUSrc(ALUSrc),
    .rf_rdata2(rf_rdata2),
    .ImmExt(ImmExt),
    .SrcB(SrcB)
);

assign SrcA = rf_rdata1;
assign dmem_wdata = rf_rdata2;

alu alu_inst(
    .alu_src_a(SrcA),
    .alu_src_b(SrcB),
    .ALUControl(ALUControl),
    .alu_result(alu_result),
    .Zero(Zero)
);

result_src_mux result_src_mux_inst(
    .ResultSrc(ResultSrc),
    .alu_result(alu_result),
    .dmem_rdata(dmem_rdata),
    .PcPlus4(PcPlus4),
    .Result(Result)
);

regfile_unit regfile_unit_inst(
    .clk(clk),
    .we_rf(RegWrite),
    .a1(rs1),
    .a2(rs2),
    .a3(rd),
    .rf_wdata(Result),
    .rf_rdata1(rf_rdata1),
    .rf_rdata2(rf_rdata2)
);

endmodule