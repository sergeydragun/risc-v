module mem(
    input logic clk,
    input logic [31:0] addr,
    input logic MemWrite,
    input logic [31:0] mem_wdata,
    output logic [31:0] mem_rdata
);

    logic [31:0] mem_data [128:0];

    always_ff @(posedge clk) begin
        if(MemWrite)
           mem_data[addr[31:2]] <= mem_wdata;
    end

    assign mem_rdata =  mem_data[addr[31:2]];

endmodule