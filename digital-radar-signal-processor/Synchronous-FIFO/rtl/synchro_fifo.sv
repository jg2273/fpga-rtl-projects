`timescale 1ns / 1ps

module synchro_fifo #(
        parameter int datawidth = 8,
        parameter int depth = 16
    )(
        input logic clk,
        input logic reset,
        input logic read_en,
        input logic write_en,
        input logic [datawidth-1:0 ]data_in,
        output logic [datawidth-1:0] data_out,
        output logic full,
        output logic empty
    );
        localparam int addresswidth = $clog2(depth);
        logic [datawidth-1:0] mem [0:depth-1];
        logic [addresswidth-1:0] write_ptr;
        logic [addresswidth-1:0] read_ptr;
        logic [addresswidth:0] count;
        
        assign empty = (count == 0);
        assign full = (count == depth);
            
        always_ff @(posedge clk) begin
            if(reset) begin
                read_ptr <= '0;
                write_ptr <= '0;
                count <= '0;
                data_out <= '0;
            end else begin
            
            if(write_en && !full) begin
                mem[write_ptr] <= data_in;
                write_ptr <= write_ptr + 1;
            end
            if (read_en && !empty) begin
                data_out <= mem[read_ptr];
                read_ptr <= read_ptr + 1;
            end
            
            if (write_en && !full && !(read_en && !empty)) begin
                count <= count + 1;
            end
            else if (read_en && !empty && !(write_en && !full)) begin
                count <= count - 1;
            end
        end
    end         
endmodule