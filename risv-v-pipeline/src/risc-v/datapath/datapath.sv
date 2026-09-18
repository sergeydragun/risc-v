module datapath(
    input logic clk,
    input logic reset,
    input logic [31:0] RD,
    input logic [31:0] dmem_rdata,
    input logic RegWriteW,
    input logic [1:0] ImmSrcD,
    input logic ALUSrcE,
    input logic MemWriteM,
    input logic [1:0] ResultSrcW,
    input logic PCsrcE,
    input logic [2:0] AluControlE,
    
    output logic [31:0] PC,
    output logic Zero,
    output logic [31:0] dmem_wdata,
    output logic [31:0] memory_addr
);

logic [31:0] PCF, PCPlus4F, PCNext;
logic [31:0] InstrD, PCD, PCPlus4D;
logic [4:0] rs1, rs2, rd;
logic [6:0] op, funct7;
logic [2:0] funct3;
logic [31:0] RD1D, RD2D, ImmExtD;
logic [31:0] RD1E, RD2E, PCE, RdE, ImmExtE, PCPlus4E;
logic [31:0] SrcA, SrcB, ALUResultE, PCtargetE;
logic ZeroE;
logic [31:0] ALUResultM, WriteDataM, RdM, PCPlus4M;
logic [31:0] ALUResultW, ReadDataW, RdW, PCPlus4W, ResultW;

adder pc_base_iter(
    .a(PCF),
    .b(32'd4),
    .sum(PCPlus4F)
);

fetch_driver fetch_driver_inst(
    .clk(clk),
    .RD(RD),
    .PCF(PCF),
    .PCPlus4F(PCPlus4F),
    .InstrD(InstrD),
    .PCD(PCD),
    .PCPlus4D(PCPlus4D)
);

assign rs1 = InstrD[19:15];
assign rs2 = InstrD[24:20];
assign rd = InstrD[11:7];
assign op = InstrD[6:0];
assign funct3 = InstrD[14:12];
assign funct7 = InstrD[31:25];

regfile_unit regfile_unit_inst(
    .clk(clk),
    .we_rf(RegWriteW),
    .a1(rs1),
    .a2(rs2),
    .a3(RdW),
    .rf_wdata(ResultW),
    .rf_rdata1(RD1D),
    .rf_rdata2(RD2D)
);

extend extend_inst(
    .ImmSrc(ImmSrcD),
    .instr(InstrD),
    .ImmExt(ImmExtD)
);

decode_driver decode_driver_inst(
    .clk(clk),
    .RD1(RD1D),
    .RD2(RD2D),
    .PCD(PCD),
    .RdD({27'b0, rd}),
    .ImmExtD(ImmExtD),
    .PCPlus4D(PCPlus4D),
    .RD1E(RD1E),
    .RD2E(RD2E),
    .PCE(PCE),
    .RdE(RdE),
    .ImmExtE(ImmExtE),
    .PCPlus4E(PCPlus4E)
);

assign SrcA = RD1E;

alu_src_mux alu_src_mux_inst(
    .ALUSrc(ALUSrcE),
    .rf_rdata2(RD2E),
    .ImmExt(ImmExtE),
    .SrcB(SrcB)
);

alu alu_inst(
    .alu_src_a(SrcA),
    .alu_src_b(SrcB),
    .ALUControl(AluControlE),
    .alu_result(ALUResultE),
    .Zero(ZeroE)
);

adder pc_imm_iter(
    .a(PCE),
    .b(ImmExtE),
    .sum(PCtargetE)
);

execute_driver execute_driver_inst(
    .clk(clk),
    .ALUResultE(ALUResultE),
    .WriteDataE(RD2E),
    .RdE(RdE),
    .PCPlus4E(PCPlus4E),
    .ALUResultM(ALUResultM),
    .WriteDataM(WriteDataM),
    .RdM(RdM),
    .PCPlus4M(PCPlus4M)
);

assign memory_addr = ALUResultM;
assign dmem_wdata = WriteDataM;

mem_driver mem_driver_inst(
    .clk(clk),
    .ALUResultM(ALUResultM),
    .ReadDataM(dmem_rdata),
    .RdM(RdM),
    .PCPlus4M(PCPlus4M),
    .ALUResultW(ALUResultW),
    .ReadDataW(ReadDataW),
    .RdW(RdW),
    .PCPlus4W(PCPlus4W)
);

result_src_mux result_src_mux_inst(
    .ResultSrc(ResultSrcW),
    .alu_result(ALUResultW),
    .dmem_rdata(ReadDataW),
    .PcPlus4(PCPlus4W),
    .Result(ResultW)
);

controller controller_inst(
    .clk(clk),
    .op(op),
    .funct7(funct7),
    .funct3(funct3),
    .ZeroE(ZeroE),
    .RegWriteW(RegWriteW),
    .ImmSrcD(ImmSrcD),
    .ALUSrcE(ALUSrcE),
    .MemWriteM(MemWriteM),
    .ResultSrcW(ResultSrcW),
    .PCsrcE(PCsrcE),
    .AluControlE(AluControlE)
);

pc_mux pc_mux_inst(
    .PCsrc(PCsrcE),
    .PCtarget(PCtargetE),
    .PcPlus4(PCPlus4F),
    .PCNext(PCNext)
);

pc_driver pc_driver_inst(
    .clk(clk),
    .reset(reset),
    .PCNext(PCNext),
    .PC(PCF)
);

assign PC = PCF;
assign Zero = ZeroE;

endmodule