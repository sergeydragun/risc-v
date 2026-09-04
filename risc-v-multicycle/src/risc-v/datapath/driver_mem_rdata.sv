module driver_mem_rdata(
    input logic clk,
    input logic [31:0] mem_rdata,
    output logic [31:0] data
);

always_ff @( posedge clk ) begin
    data <= mem_rdata
end

endmodule;