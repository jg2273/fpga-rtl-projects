`timescale 1ns / 1ps

module MAF (
    input logic clk,
    input logic reset,
    input logic sampvalid,
    input logic [7:0] sampin,
    output logic [7:0] avgout,
    output logic avgvalid 
);
  logic [7:0] sample0;
  logic [7:0] sample1;
  logic [7:0] sample2;
  logic [7:0] sample3;
  
  
  always_ff @(posedge clk) begin
    if (reset) begin
        avgout <= '0;
        avgvalid <= '0;
        sample0 <= '0;
        sample1 <= '0;
        sample2 <= '0;
        sample3 <= '0;
    end else begin
        if (sampvalid) begin
            sample3 <= sample2;
            sample2 <= sample1;
            sample1 <= sample0;
            sample0 <= sampin;
            avgout <= (sampin + sample0 + sample1 + sample2) >> 2;
            avgvalid <= 1'b1;
        end else begin 
            avgvalid <= 1'b0;
        end
        end     
    end     
    
endmodule
