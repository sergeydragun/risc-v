module uart_hw (
    input wire clk,
    input wire rx,
    output wire tx,
    output wire led_busy_tx,
    output wire led_busy_rx
);

wire [7:0] rx_byte;
wire rx_done;

uart_rx uart_rx_inst (
    .clk(clk),
    .rx(rx),
    .rx_data(rx_byte),
    .rx_ready(rx_done),
    .busy(led_busy_rx)
);

uart_tx uart_tx_inst (
    .clk(clk),
    .data(rx_byte),
    .tx_start(rx_done),
    .tx(tx),
    .busy(led_busy_tx)
);
    
endmodule