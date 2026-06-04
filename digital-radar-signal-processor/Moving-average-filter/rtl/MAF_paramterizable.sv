`timescale 1ns / 1ps

module MAF_paramterizable #(
    parameter datawidth = 8,
    parameter samplesize = 4
)(
    input logic clk,
    input logic reset,
    input logic sampvalid,
    input logic [datawidth-1:0] sampin,
    output logic [datawidth-1:0] avgout,
    output logic avgvalid
    );
    
    localparam int shiftamount = $clog2(samplesize);
    localparam int sumwidth = datawidth + $clog2(samplesize);
    
    logic [sumwidth-1:0] sum;
    logic [datawidth-1:0] window [0:samplesize-1];
    logic[sumwidth-1:0] sumnext;
    integer i;
    
    
    always_comb begin
        sumnext = sampin;
        for(i = 0 ; i < samplesize-1 ; i = i+1) begin
            sumnext = sumnext+window[i];
        end
    end    
    always_ff @(posedge clk) begin
        if(reset) begin
            avgout <= '0;
            avgvalid <= 1'b0;
            sum <= '0;
            for(i = 0 ; i < samplesize ; i = i+1) begin
                    window[i] <= '0;
            end
            end else begin
            if(sampvalid) begin
                for(i = samplesize-1 ; i > 0 ; i = i-1) begin
                    window[i] <= window[i-1];
                end
            window[0] <= sampin;
            sum <= sumnext;
            avgout <= sumnext >> shiftamount;
            avgvalid <= 1'b1;
            end else begin
                avgvalid <= 1'b0;
                end
         end                   
        end
    
endmodule
