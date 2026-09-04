module mux_result(
    input logic [1:0] result_src,
    input logic [31:0] alu_out,
    input logic [31:0] data,
    input logic [31:0] alu_result,
    output logic [31:0] result
);

always_comb begin
    case (result_src)
        2'b00: result = alu_out;
        2'b01: result = data;
        2'b10: result = alu_result;
    endcase
end

endmodule