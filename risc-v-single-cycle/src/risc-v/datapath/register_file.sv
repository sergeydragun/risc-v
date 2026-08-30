module regfile_unit(
    input logic clk,
    input logic we_rf,
    input logic [4:0] a1, a2, a3,
    input logic [31:0] rf_wdata,
    output logic [31:0] rf_rdata1, rf_rdata2
);

logic [31:0] regfile [31:0];

initial begin
    integer i;
    for (i = 0; i < 32; i = i + 1) begin
        regfile[i] = 32'd0;
    end
end

assign rf_rdata1 = (a1 != 0) ? regfile[a1] : 32'd0;
assign rf_rdata2 = (a2 != 0) ? regfile[a2] : 32'd0;

always_ff @(posedge clk) begin
    if(we_rf) begin
        regfile[a3] <= rf_wdata;
    end
end

endmodule