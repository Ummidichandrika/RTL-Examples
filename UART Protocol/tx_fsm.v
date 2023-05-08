`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:07:09 04/18/2023 
// Design Name: 
// Module Name:    tx_fsm 
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
module tx_fsm(s0,s1,load_data,shift,TX_start,clk,reset);
output reg load_data,shift,s0,s1;
input TX_start,clk,reset;
reg [2:0] state, next_state;
reg flag1,flag2;
reg temp,temp1;
reg [3:0]x1=0;
reg [4:0]x2=0;
parameter IDLE=3'b000 ,START_BIT=3'b001 ,DATA_BIT=3'b010 ,PARITY_BIT=3'b011
,STOP_BIT=3'b100;
always@(*)
begin
case(state)
IDLE :
begin 
next_state=TX_start?START_BIT:IDLE; 
load_data=0;
shift=0;
s0=1;
s1=1;
temp=0;
temp1=0;
end
START_BIT :
begin 
next_state=flag1?DATA_BIT:START_BIT;
load_data=1;
shift=0;
s0=0;
s1=0;
temp=0;
temp1=1;
end
DATA_BIT: 
begin
 next_state=flag2?PARITY_BIT:DATA_BIT;
load_data=0;
shift=1;
s0=0;
s1=1;
temp=1;
temp1=0;
end
PARITY_BIT:
 begin 
 next_state=flag1?STOP_BIT:PARITY_BIT;
load_data=0;
shift=0;
s0=1;
s1=0;
temp=0;
temp1=1;
end
STOP_BIT:
 begin
 next_state=flag1?IDLE:STOP_BIT;
load_data=0;
shift=0;
s0=1;s1=1;
temp=0;
temp1=1;
end
default: 
begin
 next_state=3'b000; 
 load_data=0;
 shift=0 ;
 s0=1;
 s1=1;
 temp=0;
 temp1=0;
 end
endcase
end
always@(posedge clk)
begin
if(temp)
begin
if(x1==4'd8)
begin
flag2=1;
x1=0;
end
else
begin
flag2=0;
x1=x1+1;
end
end
else
flag2=0;
end
always@(posedge clk)
begin
if(temp1)
begin
if(x2==5'd15)
begin
flag1=1;
x2=0;
end
else
begin
flag1=0;
x2=x2+1;
end
end
else
flag1=0;
end
always @(posedge clk,negedge reset)
begin
if(~reset)
state<=IDLE;
else
state<=next_state;
end
endmodule 

