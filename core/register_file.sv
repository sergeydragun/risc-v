module regfile_unit(
    input logic clk,
    input logic sw,
    input logic [5:0] a1, a2, a3,
    input logic [31:0] rint3,
    output logic [31:0] rout1, rout2
);

logic [31:0] regfile [31:0];

assign rout1 = (a1 != 0) ? regfile[a1]; 
assign rout2 = (a2 != 0) ? regfile[a2];

always_ff @(posedge clk) begin
    if(sw) begin
        regfile[a3] <= rint3;
    end
end

endmodule