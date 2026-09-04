module top(
    input logic clk, reset,
    output logic [31:0] dmem_wdata, dmem_addr,
    output logic MemWrite
    );

    logic [31:0] instr;
    logic [31:0] pc;
    logic [31:0] dmem_rdata;

    riscv riscv_inst(
        .clk(clk),
        .reset(reset),
        .instr(instr),
        .dmem_rdata(dmem_rdata),
        .dmem_wdata(dmem_wdata),
        .MemWrite(MemWrite),
        .PC(pc),
        .dmem_addr(dmem_addr)
    );

    ram_unit ram_unit_inst(
        .clk(clk),
        .we(MemWrite),
        .addr(dmem_addr),
        .dmem_rdata(dmem_rdata),
        .dmem_wdata(dmem_wdata)
    );

    rom_unit rom_unit_inst(
        .pc(pc),
        .instruction(instr)
    );

endmodule