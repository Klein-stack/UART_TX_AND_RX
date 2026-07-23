`timescale 1ns / 1ps


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
        
        
  reg [3:0] bit_counter = 3'b0000;
  reg [1:0] present_state;
  reg [1:0] next_state;
  reg [7:0] tx_in;
  
  always @(posedge clk or posedge rst) begin
    if (rst) begin
        present_state <= idle;
        bit_counter <= 0;
        tx <= 1'b1;
        busy <= 0;
    end else begin
        if (present_state == idle && wr_enable) begin
              tx_in <= data_in;
        end
        present_state <= next_state;
    if (present_state == start) begin
            tx <= 1'b0;
        end 
        if (present_state == stop) begin
            tx <= 1'b1;
        end
        if (present_state == data) begin
            if (bit_counter < 8) begin
                bit_counter <= bit_counter + 1;
                tx <= tx_in[bit_counter];
            end else begin
                bit_counter <= 0;
                tx <= 0;
            end
        end
     end
   end
    
  //writing the next state logic  
   always @(*) begin
    next_state = present_state;
    case (present_state)
        idle : //waits for wr_enable to become 1 to start the process
            begin
                if (wr_enable == 1'b1) begin
                    next_state = start;
                end else begin 
                    next_state = idle;
                end
            end
            
        start : 
            begin
                next_state = data;
            end
         
        data : 
            begin
                if (bit_counter < 3'b1000) begin
                    next_state = present_state;
                end else begin
                    next_state = stop;
                end
            end
         
         stop:
            begin
                next_state = idle;
         end
         
         default : next_state = idle;
            
       endcase
      
    end
    
    
endmodule
    
      
      
         
                    
                    
            
         
                
        
        
    
    
    
        
        
                            
                        
                        
                                
                        
                    
           
            
        
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

