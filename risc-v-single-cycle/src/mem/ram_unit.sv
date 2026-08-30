module ram_unit 
    (input logic clk,
    input logic we,
    input logic [31:0] addr,
    input logic [31:0] dmem_wdata,
    output logic [31:0] dmem_rdata);

logic [31:0] mem [63:0];

always_ff @(posedge clk) begin
    if(we) begin
        mem[addr[31:2]] <= dmem_wdata;
    end
end

assign dmem_rdata = mem[addr[31:2]];

endmodule