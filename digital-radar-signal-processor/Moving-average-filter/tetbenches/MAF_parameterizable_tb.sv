`timescale 1ns / 1ps

module MAF_parameterizable_tb;

    localparam int datawidth = 8;
    localparam int samplesize = 4;
    
    logic clk;
    logic reset;
    logic sampvalid;
    logic [datawidth-1:0] sampin;
    logic [datawidth-1:0] avgout;
    logic avgvalid;
    
    MAF_paramterizable #(
        .datawidth(datawidth),
        .samplesize(samplesize)
    )uut(
        .clk(clk),
        .reset(reset),
        .sampvalid(sampvalid),
        .sampin(sampin),
        .avgout(avgout),
        .avgvalid(avgvalid)
    );
    
    always #41.666 clk = ~clk;
    
    task sendsamp(input logic [datawidth-1:0] value);
    begin
        @(negedge clk);
        sampin = value;
        sampvalid = 1'b1;
        
        @(negedge clk);
        sampvalid = 1'b0;
    end
endtask

initial begin
    clk = 0;
    reset = 1;
    sampvalid = 0;
    sampin = '0;
    
    repeat(3) @(negedge clk);
    reset = 0;
    
    sendsamp(8'd10);
    sendsamp(8'd20);
    sendsamp(8'd30);
    sendsamp(8'd40);
    sendsamp(8'd50);
    
    
    #100;
    $finish;
end  
endmodule
