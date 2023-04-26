module read_pointer #(parameter PTR_WIDTH=3) (
  input rclock, rreset, r_en,
  input [PTR_WIDTH:0] gray_wptr_sync,
  output reg [PTR_WIDTH:0] bin_rptr, gray_rptr,
  output reg empty
);

  reg [PTR_WIDTH:0] bin_rptr_next;
  reg [PTR_WIDTH:0] gray_rptr_next;
  wire rempty;

  assign bin_rptr_next = bin_rptr+(r_en & !empty);
  assign gray_rptr_next = (bin_rptr_next >>1)^bin_rptr_next;
  assign rempty = (gray_wptr_sync == gray_rptr_next);
  
  always@(posedge rclock or negedge rreset) begin
    if(!rreset) begin
      bin_rptr <= 0;
      gray_rptr <= 0;
    end
    else begin
      bin_rptr <= bin_rptr_next;
      gray_rptr <= gray_rptr_next;
    end
  end
  
  always@(posedge rclock or negedge rreset) begin
    if(!rreset) empty <= 1;
    else        empty <= rempty;
  end
endmodule
