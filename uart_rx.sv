module uart_rx (
    input wire clk,
    input wire rx,
    output reg [7:0] rx_data = 0,
    output reg rx_ready = 0,
    output reg busy = 1'b1
);
    
typedef enum logic {
    IDLE = 1'b0,
    RX_ACTIVE = 1'b1
} state_t;

state_t current_state = IDLE;

reg [3:0] rx_count = 0;
reg [3:0] rx_count_bit;
reg [3:0] rx_comp = 0;
reg [2:0] rx_timer;

reg rx1 = 1'b1, rx2 = 1'b1;

always @(posedge clk) begin
    rx1 <= rx;
    rx2 <= rx1;

    case (current_state)
        IDLE: begin
            busy <= 1'b1;
            rx_ready <= 1'b0;
            if (rx2 == 1'b0) begin
                current_state <= RX_ACTIVE;
                rx_count <= 5;
                rx_timer <= 6;
                rx_count_bit <= 0;
            end
        end
        RX_ACTIVE: begin
            busy <= 1'b0;
            if (rx_timer == 0) begin
                if (rx_count_bit <= 4'd8) begin
                    rx_count <= rx_count + 1;
                    
                    if (rx_count >= 12) begin

                        rx_comp <= {rx_comp[2:0],rx2};
                        if(rx_count == 14) begin
                            rx_data <= { (rx_comp[2] + rx_comp[1] + rx_comp[0] >= 2) ? 1'b1 : 1'b0, rx_data[7:1] };
                            rx_count_bit <= rx_count_bit + 1;
                            rx_count <= 0;
                            rx_comp <= 0;
                        end
                    end

                    rx_timer <= 6;
                end else begin
                    rx_ready <= 1'b1;
                    current_state <= IDLE;
                end
            end else begin
                rx_timer <= rx_timer - 1;
            end
        end
    endcase
end

endmodule
