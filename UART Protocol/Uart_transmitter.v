`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:04:04 04/18/2023 
// Design Name: 
// Module Name:    transmitter 
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
module Transmitter(TX_dataout,clk,reset,TX_start ,TX_DATA);
output TX_dataout;
input TX_start,clk,reset;
input [7:0] TX_DATA;
wire s0,s1,shift,load_data,DATA_BIT,PARITY_BIT;
tx_fsm t1(s0,s1,load_data,shift,TX_start,clk,reset);
piso t2(DATA_BIT,TX_DATA,shift,load_data,clk,reset );
mux_4x1 t3(TX_dataout,DATA_BIT,PARITY_BIT,s0,s1 );
parity_generator t4(PARITY_BIT,TX_DATA,load_data);
endmodule 
