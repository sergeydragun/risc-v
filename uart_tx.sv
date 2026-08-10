module uart_tx (
    input wire clk,
    input [7:0] data,
    input wire tx_start,
    output reg tx = 1'b1,
    output reg busy = 1'b1
);

typedef enum logic {
    IDLE = 1'b0,
    TX_ACTIVE = 1'b1
} state;

reg [7:0] bit_timer = 0;
reg [4:0] bit_counter = 0;

state current_state = IDLE;

reg [7:0] shift_reg;

always @(posedge clk) begin
    case (current_state)
        IDLE: begin
            tx <= 1'b1;
            busy <= 1'b1;

            if (tx_start == 1'b1) begin 
                bit_timer   <= 0;
                bit_counter <= 0;             
                shift_reg   <= data;
                current_state <= TX_ACTIVE;
                busy        <= 1'b0;
                tx          <= 1'b0;
            end      
        end
        TX_ACTIVE: begin
            if (bit_timer == 103) begin
                bit_timer <= 0;

                if (bit_counter < 8) begin
                    tx <= shift_reg[0];
                    shift_reg >>= 1;
                    bit_counter <= bit_counter + 1'b1;
                end else if (bit_counter == 8) begin
                    tx <= 1;
                    bit_counter <= bit_counter + 1'b1;
                end else begin
                    busy <= 1'b1;
                    current_state <= IDLE;
                end
            end else begin
                bit_timer <= bit_timer + 1;
            end
        end
    endcase
end

endmodule
