`timescale 1ns / 1ps

module synchro_fifo_tb;

    localparam int datawidth = 8;
    localparam int depth = 16;
    logic clk;
    logic reset;
    logic read_en;
    logic write_en;
    logic [datawidth-1:0] data_in;
    logic [datawidth-1:0] data_out;
    logic full;
    logic empty;
    
        synchro_fifo #(
            .datawidth(datawidth),
            .depth(depth)
        )uut(
           .clk(clk),
           .reset(reset),
           .read_en(read_en),
           .write_en(write_en),
           .data_in(data_in),
           .data_out(data_out),
           .full(full),
           .empty(empty) 
        );
    
    always #41.667 clk = ~clk;
    
    
    initial begin
        clk = 0;
        reset = 1;
        read_en = 0;
        write_en = 0;
        data_in = 8'd0;
        
        #500;
        reset = 0;
        write_en = 1;
        data_in = 8'b1001011;
        
        #700;
        data_in = 8'b1010011;
        
        #800; 
        data_in = 8'b0010010;
        read_en = 1;
        
        #850
        write_en = 0;
        data_in = 8'b01000111;
        
        $finish;
        end
endmodule
