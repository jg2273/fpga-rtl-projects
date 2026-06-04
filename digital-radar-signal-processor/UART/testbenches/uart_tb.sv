`timescale 1ns / 1ps

module uart_tb;
    logic clk;
    logic reset;
    logic [7:0] tx_data;
    logic tx_start;
    logic [7:0] rx_data;
    logic complete;
    logic tx;
    logic busy;
    
    
    uart_top inst1 (
        .clk(clk),
        .reset(reset),
        .tx_data(tx_data),
        .tx_start(tx_start),
        .rx_data(rx_data),
        .complete(complete),
        .tx(tx),
        .busy(busy)
    );
    
    always #41.667 clk = ~clk;
    
    initial begin
        clk = 0;
        reset = 1;
        tx_data = 8'd0;
        tx_start = 1'b0;
        
        #200;
        reset = 0;
        tx_data = 8'h41;
        
        #300;
        tx_start = 1'b1;
        
        # 350;
        tx_start = 1'b0;
        
        #100000;
        
        $finish;
        
        end
endmodule
