module driver_ir(
    input logic clk,
    input logic ir_write,
    input logic [31:0] rd,
    input logic [31:0] PC,
    output logic [31:0] instr,
    output logic [31:0] PCOld
    );
    
always_ff @( posedge clk ) begin
    if(ir_write) begin
        instr <= rd;
        PCOld <= PC;
    end
        
end

endmodule;