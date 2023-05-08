`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Ummidi Chandrika
// 
// Create Date:    09:57:23 04/18/2023 
// Module Name:    Baud_rate_generator 
// Project Name: Design of UART Protocol 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Baud_rate_generator(clock_out,sel,clk,reset);
input [1:0]sel;
input clk,reset;
output reg clock_out=0;
reg temp=0;
reg count=0;

always@(sel)
begin
case(sel)
2'b00: temp<=12'h517;
2'b01: temp<=12'h145;
2'b10: temp<=12'hA2;
2'b11: temp<=12'h145;
endcase
end

always@(posedge clk or negedge reset)
begin

if (!reset)
begin
clock_out<=0;
end
else if(count==temp)
begin
count=0;
clock_out<=~clock_out;
end
else
begin
count=count+1;
clock_out<=clock_out;
end
end

endmodule


