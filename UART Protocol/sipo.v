`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:30:57 04/18/2023 
// Design Name: 
// Module Name:    sipo 
// Project Name: 
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
module sipo(RX_DATA,RX_in,shift,clk, reset);
output [7:0]RX_DATA;
input clk, reset,shift, RX_in;
reg [7:0]temp;
always@(posedge clk, negedge reset)
begin
if(reset==0)
begin
temp=0;
end
else if(shift)
begin
temp=temp>>1;
temp[7]=RX_in;
end
else
temp=temp;
end
assign RX_DATA=temp;
endmodule 
