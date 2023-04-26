module synchronizer #(parameter WIDTH=3) (input clock, reset, [WIDTH:0] data_in, output reg [WIDTH:0] data_out);
  reg [WIDTH:0] q1;
  always@(posedge clock) begin
    if(!reset) begin
      q1 <= 0;
      data_out <= 0;
    end
    else begin
      q1 <= data_in;
      data_out <= q1;
    end
  end
endmodule
