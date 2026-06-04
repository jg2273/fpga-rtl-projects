`timescale 1ns / 1ps

module rx(
    input logic clk,
    input logic reset,
    input logic rx,
    output logic [7:0] rx_data,
    output logic complete
    );
    
    logic [31:0]timer;
    logic [2:0]index;
    logic [7:0] datareg;
    
    typedef enum logic [2:0] {
        IDLE,
        START,
        DATA,
        STOP
    } state_t;
    
    state_t state;
    
    always_ff @(posedge clk) begin
        if(reset) begin
            rx_data <= 8'd0;
            state <= IDLE;
            rx_data = 8'd0;
            complete <= 1'b0;
            datareg <= 8'd0;
            index <= 3'd0;
            timer <= 32'd0;                
        end else begin
            case (state) 
            
            IDLE: begin
                complete <= 1'b0;
                timer <= 32'd0;
                index <= 3'd0;
                if(rx == 1'b0) begin
                    state <= START;
                end
                end
                
            START: begin
                if(timer == 32'd52) begin
                    timer <= 32'd0;
                    if(rx == 1'b0) begin
                        state <= DATA;
                    end else begin
                        state <= IDLE;
                    end
                    end else begin
                        timer <= timer + 32'd1;
                    end
                    end
            DATA: begin
                if (timer == 32'd103) begin
                    timer <= 32'd0;
                    datareg[index] <= rx;
                    
                    if (index == 3'd7) begin
                        index <= 3'd0;
                        state <= STOP;
                    end else begin
                        index <= index + 3'd1;
                    end
                    end else begin
                        timer <= timer + 32'd1;
                    end
                    end
            STOP: begin
                if (timer == 32'd103) begin
                    timer <= 32'd0;
                    rx_data <= datareg;
                    complete <= 1'b1;
                    state <= IDLE;
                end else begin
                    timer <= timer + 32'd1;
                    complete <= 1'b0;
                end
                end
            endcase
        end
        end        
endmodule
