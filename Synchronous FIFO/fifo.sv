module sync_fifo #(parameter DEPTH=8, WIDTH=8)(
  input clk, rst,
  input wr_en, rd_en,
  input [WIDTH-1:0] din,
  output reg [WIDTH-1:0] dout,
  output full, empty
);

  reg [WIDTH-1:0] mem [0:DEPTH-1];
  reg [$clog2(DEPTH):0] wr_ptr, rd_ptr;

  // Write Logic with Reset
  always @(posedge clk) begin
    if (rst) begin
      wr_ptr <= 0;
    end else if (wr_en && !full) begin
      mem[wr_ptr[$clog2(DEPTH)-1:0]] <= din;
      wr_ptr <= wr_ptr + 1;
    end
  end

  // Read Logic with Reset
  always @(posedge clk) begin
    if (rst) begin
      rd_ptr <= 0;
      dout   <= 0;
    end else if (rd_en && !empty) begin
      dout <= mem[rd_ptr[$clog2(DEPTH)-1:0]];
      rd_ptr <= rd_ptr + 1;
    end
  end

  assign empty = (wr_ptr == rd_ptr);
  assign full  = (wr_ptr[$clog2(DEPTH)] != rd_ptr[$clog2(DEPTH)]) &&
                 (wr_ptr[$clog2(DEPTH)-1:0] == rd_ptr[$clog2(DEPTH)-1:0]);

endmodule
