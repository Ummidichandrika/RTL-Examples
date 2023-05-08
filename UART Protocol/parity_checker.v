`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:31:57 04/18/2023 
// Design Name: 
// Module Name:    parity_checker 
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
module parity_checker(parity_error,parity_load,RX_in,RX_DATA );
output reg parity_error;
input[7:0] RX_DATA;
input RX_in,parity_load;
always @(*)
begin
if(parity_load)
begin
if(RX_in==(^RX_DATA))
parity_error<=0;
else
parity_error<=1;
end
else
parity_error<=0;
end
endmodule 
