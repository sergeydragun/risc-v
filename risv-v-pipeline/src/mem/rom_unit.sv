module rom_unit #(
    parameter int DEPTH = 1024
)(
    input logic [31:0] pc,
    output logic [31:0] instruction
);

    localparam int AW = $clog2(DEPTH);

    logic [31:0] mem [0:DEPTH-1];

    initial begin
        $readmemh("src/test/prog.hex", mem);
    end 

    logic pc_aligned;
    logic pc_in_bounds;

    logic [AW-1:0] mem_addr; 

    assign pc_aligned = (pc[1:0] == 2'b00);
    assign pc_in_bounds = (pc < (DEPTH * 4));
    assign mem_addr = pc[AW+1:2];

    assign instruction = (pc_aligned && pc_in_bounds) ? mem[mem_addr] : 32'h00000013; 


endmodule