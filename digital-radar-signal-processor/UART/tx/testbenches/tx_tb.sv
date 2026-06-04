`timescale 1ns / 1ps

module tx_tb;
    logic clk;
    logic reset;
    logic [7:0] tx_data;
    logic start;
    logic tx;
    logic busy;
    
    tx_top inst1 (
        .clk(clk),
        .reset(reset),
        .tx_data(tx_data),
        .start(start),
        .tx(tx),
        .busy(busy)
    );
    
    always #41.667 clk = ~clk;
    
    initial begin
        clk = 0;
        reset = 1;
        tx_data = 8'h00;
        start = 1'b0;
        
        #500;
        reset = 0;
        tx_data = 8'b10010011;
        
        #600
        start = 1'b1;
        
        #700
        start = 1'b0;
        
        #100000;
        
        $finish;
        
        end
        
endmodule
