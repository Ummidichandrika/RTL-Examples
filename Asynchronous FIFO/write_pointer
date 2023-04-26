module write_pointer #(parameter PTR_WIDTH=3) (
  input wclock, wreset, w_en,
  input [PTR_WIDTH:0] gray_rptr_sync,
  output reg [PTR_WIDTH:0] bin_wptr, gray_wptr,
  output reg full
);

  reg [PTR_WIDTH:0] bin_wptr_next;
  reg [PTR_WIDTH:0] gray_wptr_next;
   
  reg wrap_around;
  wire wfull;
  
  assign bin_wptr_next = bin_wptr+(w_en & !full);
  assign gray_wptr_next = (bin_wptr_next >>1)^bin_wptr_next;
  
  always@(posedge wclock or negedge wreset) begin
    if(!wreset) begin
      bin_wptr <= 0; // set default value
      gray_wptr <= 0;
    end
    else begin
      bin_wptr <= bin_wptr_next; // increment binary write pointer
      gray_wptr <= gray_wptr_next; // increment gray write pointer
    end
  end
  
  always@(posedge wclock or negedge wreset) begin
    if(!wreset) full <= 0;
    else        full <= wfull;
  end

  assign wfull = (gray_wptr_next == {~gray_rptr_sync[PTR_WIDTH:PTR_WIDTH-1], gray_rptr_sync[PTR_WIDTH-2:0]});

endmodule
