`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.11.2024 18:28:49
// Design Name: 
// Module Name: melay_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module melay_tb();
    reg clk, rst, btn;
    wire out;
    
    // Instantiate the sequence detector module
    melay_detector uut (
        .clk(clk),
        .rst(rst),
        .btn(btn),
        .out(out)
    );

    // Generate clock signal with a period of 10 time units
    always 
        #10 clk = ~clk;

    // Initial block to initialize signals and apply stimulus
    initial begin
        clk = 0;
        rst = 1;     // Start with reset asserted (high)
        btn = 0;

        // Deassert reset after a few clock cycles
        #20 rst = 0;    // Deassert reset to start normal operation
        
        // Sequence to test the 1010 pattern
        #10 btn = 1;    // 1
        #20 btn = 0;    // 10
        #20 btn = 1;    // 101
        #20 btn = 0;    // 1010 - expected output: out=1
        #20 btn = 1;    // Start of new sequence
        #20 btn = 0;
        #20 btn = 1;
        #20 btn = 0;
        #20 btn = 1;
        #20 btn = 1;    // 1
        #20 btn = 0;    // 10
        #20 btn = 1;    // 101
        #20 btn = 0;    // 1010 - expected output: out=1
        #20 btn = 1;   // Extra 1 to verify no false detection

        // Finish the simulation after a delay
        #45 $finish;
    end

endmodule
