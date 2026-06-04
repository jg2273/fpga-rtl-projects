`timescale 1ns / 1ps

module baud_gen_tb;

    logic clk;
    logic reset;
    logic tick;
    
    baud_gen inst1(
        .clk(clk),
        .reset(reset),
        .tick(tick)
    );
    
    always #41.667 clk = ~clk;
    
    initial begin
        clk = 0;
        reset = 1;
        
        #500
        reset = 0;
        
        #20000;
        
        $finish;
        
        end        
    
endmodule
