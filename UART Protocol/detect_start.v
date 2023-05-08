`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:29:58 04/18/2023 
// Design Name: 
// Module Name:    detect_start 
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
/////////////////////////////////////////////////////////////////////////////////
module detect_start(de_strtbit,RX_in,clk );
output reg de_strtbit;
input RX_in,clk;
reg [3:0]count=0;
always @(posedge clk)
begin
if(RX_in==0)
begin
if(count==4'd12)
begin
count=0;
de_strtbit=1;
end
else
begin
count=count+1;
de_strtbit=0;
end
end
else
begin
count=0;
de_strtbit=0;
end
end
endmodule 
