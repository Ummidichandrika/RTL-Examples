`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:19:59 04/18/2023 
// Design Name: 
// Module Name:    Receiver 
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
module Receiver(stop_error,RX_dataout,RX_in,clk,reset,parity_error);
output[7:0] RX_dataout;
output stop_error,parity_error;
input RX_in,clk,reset;
wire shift,parity_load,parity_error,check_stop, de_strtbit;
wire [7:0]RX_DATA;
detect_start t1(de_strtbit,RX_in,clk );
rx_fsm t2(shift,parity_load,check_stop,clk,reset,de_strtbit,parity_error);
sipo t3(RX_DATA,RX_in,shift,clk, reset);
parity_checker t4(parity_error,parity_load,RX_in,RX_DATA );
stop_bit_checker t5(stop_error,RX_dataout,check_stop,RX_in,RX_DATA ,clk);

endmodule

