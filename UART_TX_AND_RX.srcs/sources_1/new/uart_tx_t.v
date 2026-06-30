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
    
    //state declaration
    localparam [1:0] 
        idle = 2'b00,
        start = 2'b01,
        data = 2'b11,
        stop = 2'b10;
        
     //states
     reg [1:0] present_state, next_state;
     
     //counter
     reg [3:0] counter; //for counting the number of bits transffered
     
     wire tx_value = 1;
     
     //writing the present_state to next state transition logic
     always @(posedge clk or posedge rst) begin
        if (rst) begin
            present_state <= idle;
        end else begin
            present_state <=  next_state; 
        end
     end
     
     //writing the next state logic
     always @(posedge clk) begin
        tx <= tx_value;
            case (present_state) 
                idle : 
                    begin
                        busy  <= 1;
                        if (tx == 1) begin
                            next_state <= start;
                        end else begin
                            next_state <= present_state;
                        end
                    end
                    
                 start : 
                    begin
                        if(wr_enable == 1) begin
                            tx <= 0;
                            next_state <= data;
                        end
                     end
                  
                  data : 
                    begin
                        if (counter < 4'b1000) begin
                                
                            tx <= data_in[7 - counter];
                            counter <= counter + 1;
                            end else begin
                                counter <= 0;
                                next_state <= stop;
                            end
                         end
                     
                   stop : 
                    begin
                        tx <= 1;
                        next_state <= idle;
                    end
                    
                    default:
                        begin
                            next_state <= idle;
                        end
                        
              endcase
         end
         
 endmodule
         
    
         
                  
                            
                        
                        
                                
                        
                    
           
            
        
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

