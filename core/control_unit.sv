`include "rom_unit.sv"

module control_unit (
    input logic clk
);

/*
IF - загрузили из IMEM
ID - Декодировали  загрузили из regfile
EX - Выполнили (отправили в ALU)
MEM - Загрузили в DMEM или выгрузили в него
WB -  загрузили результат в regfile
*/

reg [31:0] pc;
wire [31:0] instruction;

rom_unit rom_unit_inst(
    .pc(pc),
    .instruction(instruction)
);

wire [6:0] op     = instruction[6:0];
wire [1:0] funct2 = instruction[26:25];
wire [2:0] funct3 = instruction[14:12];
wire [5:0] funct7 = instruction[31:25];
wire [4:0] rs2  = instruction[24:20];
wire [4:0] rs1  = instruction[19:15];
wire [4:0] rd  = instruction[11:7];

logic [31:0] imm;
logic [4:0] uimm;

logic sw_regfile = 1'b0;
logic sw_dmem = 1'b0;

logic [31:0] rint, rout1, rout2;

logic [31:0] alu_result, a, b;

logic [5:0] addr;
logic [31:0] din, dout;

always_comb begin : decoder_block
    case (op)
        7'd3: begin
            imm = {{20{instruction[31]}}, instruction[31:20]};

            case (funct3)
                3'd0: begin
                    //lb
                end
                3'd1: begin
                    //lh
                end
                3'd2: begin
                    //lw
                    a = rs1;
                    b = imm;

                    addr = alu_result[5:0];

                    rint = dout;
                    sw_regfile = 1'b1;
                end
                3'd4: begin
                    //lbu
                end
                3'd5: begin
                    //lhu
                end
            endcase
        end
        7'd19: begin
            imm = {{20{instruction[31]}}, instruction[31:20]};
            uimm = imm[4:0];
        end
        7'd23: begin
            imm = {instruction[31:12], 12'b0};
        end
        7'd35: begin
            imm = {{20{instruction[31]}}, instruction[31:25], instruction[11:7]};
        end
        7'd51: begin
            //ура, тут нет imm
        end
        7'd55: begin
            imm = {instruction[31:12], 12'b0};
        end
        7'd99: begin
            imm = {{20{instruction[31]}}, instruction[7], instruction[30:25], instruction[11:8], 1'b0};
        end
        7'd103: begin
            imm = {{20{instruction[31]}}, instruction[31:20]};
        end
        7'd111: begin
            imm = {{12{instruction[31]}}, instruction[19:12], instruction[20], instruction[30:21], 1'b0};
        end
    endcase
end

regfile_unit regfile_unit_inst(
    .clk(clk),
    .sw(sw_regfile),
    .a1(rs1),
    .a2(rs2),
    .a3(rd),
    .rint(rint),
    .rout1(rout1),
    .rout2(rout2)
);

alu_module alu_module_inst(
    .func3(funct3),
    .funct7(funct7),
    .a(a),
    .b(b),
    .result(alu_result)
);

ram_unit ram_unit_inst(
    .clk(clk),
    .sw(sw_dmem),
    .addr(addr),
    .din(din),
    .dout(dout)
);

always @(posedge clk) begin
    pc <= pc + 4;
    sw_regfile <= 1'b0;
    sw_dmem <= 1'b0;
    
end

endmodule