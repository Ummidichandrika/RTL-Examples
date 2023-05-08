`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:34:57 04/18/2023 
// Design Name: 
// Module Name:    UART_Top 
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
module UART_Top(stop_error,parity_error,RX_dataout,sel,TX_start,TX_DATA,clk,reset);
output stop_error,parity_error;
output[7:0] RX_dataout;
input TX_start,clk,reset;
input [1:0] sel;
input [7:0] TX_DATA;
wire TX_dataout,clock_out;
Transmitter r1(TX_dataout,clock_out,reset,TX_start ,TX_DATA);
Baud_rate_generator r2(clock_out,sel,clk,reset);
Receiver r3(stop_error,RX_dataout,TX_dataout,clock_out,reset,parity_error);
endmodule 
