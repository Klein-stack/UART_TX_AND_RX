`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/29/2026 10:15:17 PM
// Design Name: 
// Module Name: baud_rate_generator
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module baud_rate_generator(
    input wire clk,
    output reg tx_enable,
    output reg rx_enable
    );
    
    reg [12:0] tx_counter = 0; //5208 cycles
    reg [9:0] rx_counter = 0; //325 cycles for 1 bit ....16x oversampling
    
    //TX logic
    
    always @(posedge clk) begin
        tx_enable <= 1'b0;
        rx_enable <= 1'b0;
        
        if (tx_counter < 5208) begin
            tx_counter <= tx_counter + 1;
        end else begin
            tx_counter <= 0;
            tx_enable <= 1'b1; //tx is enabled for exactly one clock cycle
        end
        
     //RX LOGIC
     
        if (rx_counter < 325) begin
            rx_counter <= rx_counter + 1;
        end else begin
            rx_counter <= 0;
            rx_enable <= 1'b1; //rx also enabled for one clock cylce
            
        end
     end
             
    
    
endmodule
