`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:17:56 04/18/2023 
// Design Name: 
// Module Name:    parity_generator 
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
module parity_generator(PARITY_BIT,TX_DATA,load_data);
output reg PARITY_BIT;
input [7:0]TX_DATA;
input load_data;
always@(*)
begin
if(load_data)
PARITY_BIT = ^TX_DATA;
else
PARITY_BIT=1'b0;
end
endmodule 
