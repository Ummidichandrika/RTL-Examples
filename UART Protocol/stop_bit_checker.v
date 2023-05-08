`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:32:36 04/18/2023 
// Design Name: 
// Module Name:    stop_bit_checker 
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
module stop_bit_checker(stop_error,RX_dataout,check_stop,RX_in,RX_DATA ,clk);
output reg stop_error;
output reg [7:0] RX_dataout;
input RX_in,check_stop,clk;
input[7:0] RX_DATA;
reg [2:0]count=0;
//reg flag;
always @(posedge clk)
begin
if(check_stop==1)
begin
if(RX_in)
begin
if(count==15)
begin
count<=0;
stop_error<=0;
RX_dataout<=RX_DATA;
end
else
begin
count<=count+1;
stop_error<=0;
RX_dataout<=RX_DATA;
end
end
else
begin
stop_error<=1;
RX_dataout<=8'h00;
end
end
else
begin
stop_error<=0;
RX_dataout<=RX_DATA;
end
end
endmodule 
