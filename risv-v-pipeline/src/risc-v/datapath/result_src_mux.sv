module result_src_mux(
    input logic [1:0] ResultSrc,
    input logic [31:0] alu_result,
    input logic [31:0] dmem_rdata,
    input logic [31:0] PcPlus4,
    output logic [31:0] Result
);

always_comb begin
    case (ResultSrc)
        2'b00: Result = alu_result;
        2'b01: Result = dmem_rdata;
        2'b10: Result = PcPlus4;
        default: Result = 32'b0; 
    endcase
end

endmodule