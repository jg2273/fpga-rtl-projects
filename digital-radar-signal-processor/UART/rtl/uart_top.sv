`timescale 1ns / 1ps

module uart_top(
    input logic clk,
    input logic reset,
    input logic [7:0] tx_data,
    input logic tx_start,
    output logic [7:0] rx_data,
    output logic complete,
    output logic tx,
    output logic busy 

    );
    
    logic baud_tick;
    
    baud_gen inst1 (
        .clk(clk),
        .reset(reset),
        .tick(baud_tick)
    );
    
    tx inst2 (
        .clk(clk),
        .reset(reset),
        .tx_data(tx_data),
        .start(tx_start),
        .tick(baud_tick),
        .tx(tx),
        .busy(busy)
    );
    
    rx inst3 (
        .clk(clk),
        .reset(reset),
        .rx(tx),
        .rx_data(rx_data),
        .complete(complete)
    );
endmodule
