module driver_alu_result(
    input logic clk,
    input logic alu_result,
    output logic alu_out
);

always_ff @( posedge clk ) begin
    alu_out <= alu_result;
end
endmodule