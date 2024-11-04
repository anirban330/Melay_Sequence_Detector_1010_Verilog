`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:Apsis Solution 
// Engineer: Anirban Nath
// Create Date: 03.11.2024 18:24:29
// Design Name: Melay Non-Overlapping Sequence Detector(1010)
// Module Name: melay_detector
//////////////////////////////////////////////////////////////////////////////////


module melay_detector(input clk, rst, btn,output reg out);

parameter s0=3'b000;
parameter s1=3'b001;
parameter s2=3'b010;
parameter s3=3'b011;
parameter s4=3'b100;

reg [2:0] state, n_state;

// State transition logic
always @(posedge clk) begin
    if (rst)
        state <= s0;          // Use non-blocking assignment
 end

// Next state logic
always @(posedge clk) begin
    n_state <= state;
    if (state == s0) begin
    if (btn)
        state <= s1;
    else
        state <= s0;
end
else if (state == s1) begin
    if (btn)
        state <= s1;
    else
        state <= s2;
end
else if (state == s2) begin
    if (btn)
        state <= s3;
    else
        state <= s0;
end
else if (state == s3) begin
    if (btn)
        state <= s1;
    else
        state <= s2;
end

end

// Output logic
always@(posedge clk )
   if(rst)
    out<='bx;
   else begin
     if((state==s3) && (~btn))
       out<=1'b1;
     else
      out<=1'b0;
  end
        
endmodule
