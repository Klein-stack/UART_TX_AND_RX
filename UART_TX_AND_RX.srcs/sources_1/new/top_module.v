

module top_module (
    input clk,
    input rst,
    input [7:0] tx_data_in,
    input wr_enable,
    input rx,
    output tx,
    output [7:0] rx_data_out,
    output rx_data_valid
    
    );
    
wire tx_enable;
wire rx_enable;
wire busy;

//baud rate generator

baud_rate_generator brg (
    .clk(clk),
    .rst(rst),
    
    .tx_enable(tx_enable),
    .rx_enable(rx_enable)
    );
    
//transmitter

uart_tx_t TX (
    .clk(clk),
    .wr_enable(wr_enable),
    .tx_enable(tx_enable),
    .rst(rst),
    .data_in(tx_data_in),
    
    .tx(tx),
    .busy(busy)
    );
    
//receiver

uart_rx_t RX (
    .clk(clk),
    .rst(rst),
    .rx_enable(rx_enable),
    .rx(rx),
    .data_out(rx_data_out),
    .data_valid(rx_data_valid)
    
    );
    
endmodule

    

    
    