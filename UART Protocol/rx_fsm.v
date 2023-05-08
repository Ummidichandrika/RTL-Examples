`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:26:18 04/18/2023 
// Design Name: 
// Module Name:    rx_fsm 
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

module rx_fsm(shift,parity_load,check_stop,clk,reset,de_strtbit,parity_error);
output reg shift,parity_load,check_stop;
input clk, reset,de_strtbit,parity_error;
reg [2:0]state=2'b00, next_state=2'b00;
reg flag1,flag2;
reg temp, temp1;
reg [3:0]x1=0;
reg [3:0]x2=0;
parameter IDLE=3'b000,
DATA_BIT=3'b001, 
PARITY_BIT=3'b010,
 STOP_BIT=3'b011;
always @(*)
begin
case(state)
IDLE: 
begin 
next_state=de_strtbit?DATA_BIT:IDLE;
shift=0;
parity_load=0;
check_stop=0;
temp=0;
temp1=0;
 end
DATA_BIT :
begin
 next_state=flag1?PARITY_BIT:DATA_BIT;
 shift=1;
parity_load=0;
check_stop=0;
 temp=1;
 temp1=0;
 end
PARITY_BIT:
 begin
 next_state=parity_error?IDLE:(flag2?STOP_BIT:PARITY_BIT) ;
shift=0;
parity_load=1;
check_stop=0;
temp=0;
temp1=1;
 end
STOP_BIT:
begin 
next_state=flag2?IDLE:STOP_BIT ;
shift=0;
parity_load=0;
check_stop=1;
temp=0;
temp1=1;
 end
default: 
begin next_state=IDLE;
 shift=0;
 parity_load=0;
 check_stop=0; 
 temp=0;temp1=0; 
 end
endcase
end
always@ (posedge clk,negedge reset)
begin
if(~reset)
state<=IDLE;
else
state<=next_state;
end
always@(posedge clk)
begin
if(temp)
begin
if(x1==4'd6)
begin
flag1=1;
x1=0;
end
else
begin
flag1=0; 
x1=x1+1;
end
end
else
begin
x1=0;
flag1=0;
end
end
always@(posedge clk)
begin
if(temp1)
begin
if(x2==4'd15)
begin
flag2=1;
x2=0;
end
else
begin
flag2=0;
x2=x2+1;
end
end
else
begin
x2=0;
flag2=0;
end
end
endmodule
