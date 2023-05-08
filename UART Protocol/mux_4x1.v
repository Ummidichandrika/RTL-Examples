`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:16:44 04/18/2023 
// Design Name: 
// Module Name:    mux_4x1 
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

module mux_4x1(TX_dataout,DATA_BIT,PARITY_BIT,s0,s1 );
output TX_dataout;
input DATA_BIT,PARITY_BIT;
input s0,s1;
reg START_BIT=0;
reg STOP_BIT=1;
assign
TX_dataout=(~s0&~s1&START_BIT)|(~s0&s1&DATA_BIT)|(s0&~s1&PARITY_BIT)|(s0&s1&STOP_BIT);
endmodule 
