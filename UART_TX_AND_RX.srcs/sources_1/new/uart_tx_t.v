`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/19/2026 07:43:40 AM
// Design Name: 
// Module Name: uart_tx_t
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


module uart_tx_t(
    input clk,
    input wr_enable , //write enable pin. Writing to uart only occurs when this is 1
    input tx_enable,
    input rst,
    input [7:0] data_in,
    output reg tx,
    output reg busy
    );
    
  localparam [1:0] 
        idle = 2'b00,
        start = 2'b01,
        data = 2'b10,
        stop = 2'b11;
        
        
  reg [2:0] bit_counter = 3'b000;
  reg present_state;
  reg next_state;
  
  always @(posedge clk or posedge rst) begin
    if (rst) begin
        present_state <= idle;
        bit_counter <= 0;
        tx_enable <= 0;
    end else begin
        present_state <= next_state;
        if (present_state == data) begin
            if (bit_counter < 8) begin
                bit_counter <= bit_counter + 1;
            end else begin
                bit_counter <= 0;
            end
        end
     end
   end
    
  //writing the next state logic  
   always @(*) begin
    case (present_state)
        idle : //
            begin
                if (wr_enable == 1'b1) begin
                
        
        
    
    
    
        
        
                            
                        
                        
                                
                        
                    
           
            
        
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

