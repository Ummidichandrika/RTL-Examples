`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:14:51 04/18/2023 
// Design Name: 
// Module Name:    piso 
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
module piso(DATA_BIT,TX_DATA,shift,load_data,clk,reset );
output reg DATA_BIT=0;
input clk,reset,shift,load_data;
input [7:0]TX_DATA;
reg [7:0]temp;
always@(posedge clk ,negedge reset)
begin
if(!reset)
begin
DATA_BIT<=0;
temp<=0;
end
else if(load_data==1)
begin
//DATA_BIT<=TX_DATA[0];
temp<=TX_DATA;
end
else if(shift==1)
begin
DATA_BIT<=temp[0];
temp<=temp>>1;
end
end
//assign
//temp=TX_DATA;
endmodule
