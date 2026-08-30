module rf_rdata_driver_sv(
        input logic clk,
        input logic [31:0] rd1, rd2,
        output logic [31:0] A, B
    );

    always_ff @( posedge clk ) begin
        A <= rd1;
        B <= rd2;
    end
endmodule