`timescale 1ns / 1ps

module MAF_tb;

logic clk;
logic reset;
logic sampvalid;
logic [7:0] sampin;
logic [7:0] avgout;
logic avgvalid;

MAF uut(
    .clk(clk),
    .reset(reset),
    .sampvalid(sampvalid),
    .sampin(sampin),
    .avgout(avgout),
    .avgvalid(avgvalid)
);

    always #41.66 clk = ~clk;
    
    initial begin
        clk = 0;
        sampvalid = 0;
        sampin = 8'd0;
        reset = 1;
        
        #200;
        reset = 0;
        @(posedge clk);
        sampvalid = 1;
        sampin = 8'd10;
        
        @(posedge clk);
        sampin = 8'd20;
        
        @(posedge clk);
        sampin = 8'd30;
        
        @(posedge clk);
        sampin = 8'd40;
        
        @(posedge clk);
        sampvalid = 0;
        
        #200;
        
        #200;
        sampvalid = 1;
        
        @(posedge clk);
        sampin = 8'd90;
        
        @(posedge clk);
        sampvalid = 0;
        
        #400;
        
        $finish;
        end
endmodule
