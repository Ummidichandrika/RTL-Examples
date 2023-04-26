module fifo_mem #(parameter DEPTH=8, DATA_WIDTH=8, PTR_WIDTH=3) (
  input wclock, w_en, rclock, r_en,
  input [PTR_WIDTH:0] bin_wptr, bin_rptr,
  input [DATA_WIDTH-1:0] data_in,
  input full, empty,
  output reg [DATA_WIDTH-1:0] data_out
);
  reg [DATA_WIDTH-1:0] fifo[0:DEPTH-1];
  
  always@(posedge wclock) begin
    if(w_en & !full) begin
      fifo[bin_wptr[PTR_WIDTH-1:0]] <= data_in;
    end
  end
  
  /* always@(posedge rclock) begin
    if(r_en & !empty) begin
      data_out <= fifo[bin_rptr[PTR_WIDTH-1:0]];
    end
  end  */
  assign data_out = fifo[bin_rptr[PTR_WIDTH-1:0]];
  
endmodule
