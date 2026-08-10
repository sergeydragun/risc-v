module rom_unit #(
    parameter int DEPTH = 1024;
)(
    input reg [31:0] pc,
    output wire [31:0] instruction
);

    localparam int AW = $clog2(DEPTH);

    logic [31:0] mem [0:DEPTH-1];

    initial begin
        $readmemh("prog.hex", mem);
    end 

    always_comb begin
        instruction = 32'h00500093

        if(pc[1:0] == b'00 && pc[31:AW-1] == '0)
            instruction = mem[pc[AW+1:2]]
    end

endmodule