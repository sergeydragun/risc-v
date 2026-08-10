module alu_unit(
    input logic [2:0] func3,
    input logic [5:0] funct7,
    input logic [31:0] a, b,
    output logic [31:0] result
);

always_comb begin
    case(func3)
        3'b000: result = (funct7 != 6'b000000) ? a - b : a + b; 
        3'b001: result = a << b[4:0]; // SLL
        3'b010: result = ($signed(a) < $signed(b)) ? 32'd1 : 32'd0; // SLT
        3'b011: result = (a < b) ? 32'd1 : 32'd0; // SLTU
        3'b100: result = a ^ b;
        3'b101: result = (funct7 == 6'b000000) ? a >> b[4:0] : $signed(a) >>> b[4:0]; // SRL or SRA
        3'b110: result = a | b; 
        3'b111: result = a & b; 
        default: result = 32'd0;
    endcase
end

endmodule