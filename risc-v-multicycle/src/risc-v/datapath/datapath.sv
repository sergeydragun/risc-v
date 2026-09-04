module datapath(
    input logic clk,
    input logic [31:0] mem_rdata,
    input logic RegWrite,
    input logic [1:0] ImmSrc,
    input logic [1:0] ALUSrcA,
    input logic [1:0] ALUSrcB,
    input logic [1:0] ResultSrc,
    input logic PCWrite,
    input logic [2:0] AluControl,
    input logic IRWrite,
    input logic AdrSrc,
    output logic [31:0] mem_addr,
    output logic Zero
);

logic [31:0] PC;
logic [31:0] result;
logic [31:0] instr, PCOld;
logic [31:0] data;

logic [31:0] rf_rdata1, rf_rdata2;
logic [31:0] A, B;

logic [31:0] ImmExt;

logic [31:0] alu_src_a, alu_src_b;

logic [31:0] alu_out;
logic [31:0] alu_result;

driver_pc driver_pc_inst(
    .clk(clk),
    .PCNext(result),
    .PCWrite(PCWrite),
    .PC(PC)
);

mux_mem_addr mux_mem_addr_inst(
    .adr_src(AdrSrc),
    .PC(PC),
    .result(result),
    .mem_addr(mem_addr)
);


driver_ir driver_ir_inst(
    .clk(clk),
    .ir_write(IRWrite),
    .rd(mem_rdata),
    .PC(PC),
    .instr(instr),
    .PCOld(PCOld)
    );

driver_mem_rdata driver_mem_rdata_inst(
    .clk(clk),
    .mem_rdata(mem_rdata),
    .data(data)
);

regfile_unit regfile_unit_inst(
    .clk(clk),
    .we_rf(RegWrite),
    .a1(instr[19:15]),
    .a2(instr[24:20]),
    .a3(instr[11:7]),
    .rf_wdata(result),
    .rf_rdata1(rf_rdata1),
    .rf_rdata2(rf_rdata2)
);

driver_rf_rdata driver_rf_rdata_inst(
    .clk(clk),
    .rd1(rf_rdata1),
    .rd2(rf_rdata2),
    .A(A),
    .B(B)
);

extend extend_inst(
    .ImmSrc(ImmSrc),
    .instr(instr[31:7]),
    .ImmExt(ImmExt)
);

mux_src_alu_a mux_src_alu_a_inst(
    .ALUSrcA(ALUSrcA),
    .PC(PC),
    .A(A),
    .PCOld(PCOld),
    .alu_src_a(alu_src_a)
);

mux_src_alu_b mux_src_alu_b_inst(
    .ALUSrcB(ALUSrcB),
    .ImmExt(ImmExt),
    .B(B),
    .alu_src_b(alu_src_b)
);

alu alu_inst(
    .alu_src_a(alu_src_a),
    .alu_src_b(alu_src_b),
    .ALUControl(AluControl),
    .alu_result(alu_result),
    .Zero(Zero)
);

driver_alu_result driver_alu_result_inst(
    .clk(clk),
    .alu_result(alu_result),
    .alu_out(alu_out)
);

mux_result mux_result_inst(
    .result_src(ResultSrc),
    .alu_out(alu_out),
    .data(data),
    .alu_result(alu_result),
    .result(result)
);

endmodule