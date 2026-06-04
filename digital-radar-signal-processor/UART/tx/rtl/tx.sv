`timescale 1ns / 1ps

module tx(
    input logic clk,
    input logic reset,
    input logic [7:0] tx_data,
    input logic start,
    input logic tick,
    output logic tx,
    output logic busy 
    );
    
    logic [7:0] datareg;
    logic [2:0] index;
    
    typedef enum logic [1:0] {
    IDLE,
    START,
    DATA,
    STOP
    } state_t;
    
    state_t state;
    
    always_ff @(posedge clk) begin
        if (reset) begin
            tx <= 1'b1;
            busy <= 1'b0;
            index <= 3'd0;
            state <= IDLE;
            datareg <= 8'd0;
        end
        else begin
            case(state)
            
            IDLE: begin
                tx <= 1'b1;
                busy <= 1'b0;
                    if(start == 1'b1) begin
                        state <= START;
                    end
                end
            START: begin
                tx <= 1'b0;
                busy <= 1'b1;
                datareg <= tx_data;
                index <= 3'd0;
                    if(tick) begin
                        state <= DATA;
                    end
                end
            DATA: begin
                if (tick) begin
                    tx <= datareg[index];
                if (index == 3'd7) begin
                    index <= 3'd0;
                    state <= STOP;
                end
                
                else begin
                    index <= index + 3'd1;
                end
            end
            end
            STOP: begin
                tx <= 1'b1;
                    if (tick) begin
                        state <= IDLE;
                    end
                end
            endcase
        end
    end 
endmodule
