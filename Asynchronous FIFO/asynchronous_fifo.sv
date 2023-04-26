// Code your design here
`include "synchronizer.v"
`include "write_pointer.v"
`include "read_pointer.v"
`include "fifo_mem.v"

module asynchronous_fifo #(parameter DEPTH=8, DATA_WIDTH=8) (
  input wclock, wreset,
  input rclock, rreset,
  input w_en, r_en,
  input [DATA_WIDTH-1:0] data_in,
  output reg [DATA_WIDTH-1:0] data_out,
  output reg full, empty
);
  
  parameter PTR_WIDTH = $clog2(DEPTH);
 
  reg [PTR_WIDTH:0] gray_wptr_sync, gray_rptr_sync;
  reg [PTR_WIDTH:0] bin_wptr, bin_rptr;
  reg [PTR_WIDTH:0] gray_wptr, gray_rptr;

  wire [PTR_WIDTH-1:0] waddr, raddr;

  synchronizer #(PTR_WIDTH) sync_wptr (rclock, rreset, gray_wptr, gray_wptr_sync); //write pointer to read clock domain
  synchronizer #(PTR_WIDTH) sync_rptr (wclock, wreset, gray_rptr, gray_rptr_sync); //read pointer to write clock domain 
  
  write_pointer #(PTR_WIDTH) wptr_h(wclock, wreset, w_en,gray_rptr_sync,bin_wptr,gray_wptr,full);
  read_pointer #(PTR_WIDTH) rptr_h(rclock, rreset, r_en,gray_wptr_sync,bin_rptr,gray_rptr,empty);
  fifo_mem fifom(wclock, w_en, rclock, r_en,bin_wptr, bin_rptr, data_in,full,empty, data_out);

endmodule
