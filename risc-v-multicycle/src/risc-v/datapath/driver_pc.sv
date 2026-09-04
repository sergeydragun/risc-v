module driver_pc(
    input logic clk,
    input logic [31:0] PCNext,
    input logic PCWrite,
    output logic [31:0] PC
);

always_ff @( clock ) begin : blockName
    if(PCWrite)
      PC <= PCNext;  
end

endmodule