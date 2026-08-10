`include "rom_unit.sv"

module control_unit (
    input logic clk
);

reg [31:0] pc;
wire [31:0] instruction;

rom_unit rom_unit_inst(
    .pc(pc),
    .instruction(instruction)
);

wire [1:0] op     = instruction[1:0];
wire [2:0] funct3 = instruction[15:13];
wire [3:0] funct4 = instruction[15:12];
wire [5:0] funct6 = instruction[15:10];

always_comb begin : decoder_block
    

    case (op):
        2'b10
    endcase
end

always @(posedge clk) begin
    pc <= pc + 1;

    
end

endmodule