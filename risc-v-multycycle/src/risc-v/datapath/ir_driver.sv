module ir_driver(
    input logic clk,
    input logic ir_write,
    input logic [31:0] rd,
    output logic [31:0] instr
    );
    
always_ff @( posedge clk ) begin
    instr <= rd;
end

endmodule;