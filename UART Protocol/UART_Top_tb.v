`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:38:07 04/18/2023
// Design Name:   UART_Top
// Module Name:   /home/ise/UART/UART_Top_tb.v
// Project Name:  UART
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: UART_Top
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module UART_Top_tb;

	// Inputs
	reg [1:0] sel;
	reg TX_start;
	reg [7:0] TX_DATA;
	reg clk;
	reg reset;

	// Outputs
	wire stop_error;
	wire parity_error;
	wire [7:0] RX_dataout;

	// Instantiate the Unit Under Test (UUT)
	UART_Top uut (
		.stop_error(stop_error), 
		.parity_error(parity_error), 
		.RX_dataout(RX_dataout), 
		.sel(sel), 
		.TX_start(TX_start), 
		.TX_DATA(TX_DATA), 
		.clk(clk), 
		.reset(reset)
	);

	initial begin
		// Initialize Inputs
		clk=0;
		sel = 2'b10;
TX_start = 1;
TX_DATA = 8'b10101010;
reset = 1;
end
always #10 clk=~clk;
endmodule

