`timescale 1ns / 1ps

module tx_top(
    input logic clk,
    input logic reset,
    input logic [7:0] tx_data,
    input logic start,
    output logic tx,
    output logic busy
    );
    
    logic baud_tick;
    
    baud_gen inst1(
        .clk(clk),
        .reset(reset),
        .tick(baud_tick)
    );
    
    tx inst2(
        .clk(clk),
        .reset(reset),
        .tx_data(tx_data),
        .start(start),
        .tick(baud_tick),
        .tx(tx),
        .busy(busy)
    );
    
endmodule
