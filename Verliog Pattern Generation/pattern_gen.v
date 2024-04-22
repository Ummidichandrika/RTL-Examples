// Code your design here
module pattern_gen(
      input clock, 
      input reset, 
	  output [7:0] seq_out
	  );
  reg [7:0] seq_tmp,seq_in;
reg [3:0]count;

always@(posedge clock)
begin
if (reset)
count = 0;
else if(count == 7)
count =0;
else
count = count+1;
end


always@(*)
begin
  if(count== 1'b0 || count==3'b010 || count==3'b100 || count==3'b110) 
seq_in=8'h01;//8 600000001
  else if(count == 1'b1)
begin
seq_tmp=8'h10;
  seq_in=seq_tmp;
end

  else if(count==3'b011 || count==3'b101 || count==3'b111)
begin
seq_tmp[3:0]=4'h0;
seq_tmp[7:4]=seq_tmp[7:4] << 1;
  seq_in=seq_tmp;
  
end
 
end

assign seq_out=seq_in;

endmodule
