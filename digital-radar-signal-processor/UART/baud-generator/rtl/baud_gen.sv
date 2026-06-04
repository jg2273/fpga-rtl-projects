`timescale 1ns / 1ps

module baud_gen(
    input logic clk,
    input logic reset,
    output logic tick
    );
    
    localparam int clk_per_bit = 104;
    logic [6:0] counter;
    
    always_ff @(posedge clk) begin
        if (reset) begin
            tick <= 1'b0;
            counter <= 7'd0;
        end else begin
         if ( counter == clk_per_bit -1) begin
            counter <= 7'd0;
            tick <= 1'b1;
         end else begin
         counter <= counter + 7'd1;
         tick <= 1'b0;   
    end
end
end
endmodule
