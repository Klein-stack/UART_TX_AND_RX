`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/19/2026 07:43:40 AM
// Design Name: 
// Module Name: uart_rx_t
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


module uart_rx_t(
    input clk,
    input tx_en,
    input rst,
    input [7:0] tx_data,
    output reg tx_line
    );

localparam [1:0] 
    idle = 2'b00, //here we check if the tx_en is enabled then we can make tx line high
    start = 2'b01, // here we transmit the start bit by making the tx line low
    data = 2'b10, // we transmit the data bits which are 8 in number
    stop = 2'b11; // we finally transmit the stop bit by making the tx line high again
    
reg [1:0] present_state, next_state;
reg [2:0] counter;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        present_state <= idle;
        counter <= 3'b000;
     end else begin
        present_state <= next_state;
        
        case (present_state) //we will now write the logic of each state. what each state does
            idle : begin
                if (tx_en == 1'b1) begin
                    tx_line <= 1'b1;
                end
             end
             
            start: begin
                   tx_line <= 1'b0;
             end
             
            data: begin
                    if (counter <= 3'b100) begin
                        tx_line <= tx_data[counter];
                        counter <= counter + 1;
                    end
            end
            stop: begin
                    tx_line <= 1'b1;
              end
         endcase
 end   
 end
 
 //now we will write the logic for next state
always @(*) begin
    next_state <= present_state
    case (present_state) 
        
        
 end

          
              
              
                        
                    
                    
     
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
endmodule
