// Code your testbench here
// or browse Examples
module patten_gen_tb();
reg clock, reset;
wire [7:0] seq_out;
pattern_gen DUT(clock, reset, seq_out);

always
begin
#5 clock= ~clock;
end


task rst();
begin
@(negedge clock)
reset=1;
@(negedge clock)
reset=0;
end
  endtask

initial
begin
clock= 1;
rst;
#75;
  $finish;

end

initial begin
  $display("Pattern Generated:");
  $monitor("%b_%b", seq_out [7:4], seq_out[3:0]);
end
endmodule
