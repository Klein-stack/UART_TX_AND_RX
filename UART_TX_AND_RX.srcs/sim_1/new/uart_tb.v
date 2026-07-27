`timescale 1ns/1ps

module uart_tb;

//declaring inputs as reg
    reg clk;
    reg rst;
    reg [7:0] tx_data_in;
    reg wr_enable;
    reg rx;
    
//declaring outputs as wires
    wire tx;
    wire [7:0] rx_data_out;
    wire rx_data_valid;
    
    top_module dut (
    .clk(clk),
    .rst(rst),
    .tx_data_in(tx_data_in),
    .wr_enable(wr_enable),
    .rx(rx),
    .tx(tx),
    .rx_data_out(rx_data_out),
    .rx_data_valid(rx_data_valid)
    
    );
    
    initial begin
        clk = 0;
        forever #5 clk = !clk; //time period = 10ns
    end
    
    //test vectors
    initial begin
        rst = 0;
        tx_data_in = 0;
        wr_enable = 0;
        
        #20;
        rst = 0;
        
        #10 rst = 1;
        #10 tx_data_in = 8'hAF;
        #10 wr_enable = 1;
        
        #20;
        
        $finish;
      
     end
     
     initial begin
     
        
        
        
    
    
    