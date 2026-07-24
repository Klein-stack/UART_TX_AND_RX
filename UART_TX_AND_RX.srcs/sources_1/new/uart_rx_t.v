module uart_rx_t (
    input clk, 
    input rst,
    input rx_enable,
    input rx,
    output data_out,  //the data that is received by the rx
    output data_valid //signal to verify if the data is received or not
    );
    
localparam [3:0] 
    idle =  2'b00,
    start = 2'b01,
    data = 2'b10,
    stop = 2'b11;
    
reg [1:0] present_state;
reg [1:0] next_state;

reg [3:0] bit_counter;
reg [7:0] rx_data;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        present_state <= idle;
        bit_counter <= 0;
        rx_data <= 0;
        data_out <= 0;
        data_valid <= 0;
    end
    
    else if (rx_enable) begin
       present_state <= next_state;
       data_valid <= 0;
    end
       
       case (present_state)
        idle : begin
            bit_counter <= 0;
        end
        
        start : begin
            bit_counter <= 0;
        end
        
        data : begin
            if (bit_counter == 7) begin
                bit_counter <= 0;
            end else begin
                bit_counter <= bit_counter + 1;
                rx_data[bit_counter] <= rx;
            
            end
        end
        
        stop : begin
            if(rx <= 1'b1) begin
                data_out <= rx_data;
                data_valid <= 1'b1;
            end
        end
        
       endcase
  end
       
   //the next state logic    
  always @(*) begin 
    next_state = present_state;
    
    case (present_state) 
        
        idle : begin
            if (rx == 1'b0) begin
                next_state = start;
            end
        end
        
        start : begin
            next_state = data;
        end
        
        data : begin
            if (bit_counter == 8) begin
                next_state = stop;
            end else begin
                next_state = present_state;
            end
        end
        
        stop : begin
            next_state = idle;
        end
        
     endcase
      
        
        
            
            
        
    
    
            
            
        
        
