module pc_mux(
    input logic PCsrc,
    input logic [31:0] PCtarget,
    input logic [31:0] PcPlus4,
    output logic [31:0] PCNext
);

always_comb begin
    case (PCsrc)
        1'b0: PCNext = PcPlus4;
        1'b1: PCNext = PCtarget;
    endcase
end


endmodule