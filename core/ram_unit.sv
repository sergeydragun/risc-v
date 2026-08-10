module ram_unit 
    #(parameter N = 6, M = 32)
    (input logic clk,
    input logic sw,
    input logic [N-1:0] addr,
    input logic [M-1:0] din,
    output logic [M-1:0] dout);

logic [M-1:0] mem [2**N-1:0];

always_ff @(posedge clk) begin
    if(sw) begin
        mem[addr] <= din;
    end
end

assign dout = mem[addr];

endmodule