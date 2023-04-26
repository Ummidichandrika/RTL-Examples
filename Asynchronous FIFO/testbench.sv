// Code your testbench here
// or browse Examples
module asynchronous_fifo_tb;

  parameter DATA_WIDTH = 8;

  wire [DATA_WIDTH-1:0] data_out;
  wire full;
  wire empty;
  reg [DATA_WIDTH-1:0] data_in;
  reg w_en, wclock, wreset;
  reg r_en, rclock, rreset;
 

  // Queue to push data_in
  reg [DATA_WIDTH-1:0] wdata_q[$], wdata;

  asynchronous_fifo as_fifo (wclock, wreset,rclock, rreset,w_en,r_en,data_in,data_out,full,empty);
always #10 wclock = ~wclock;
  always #35 rclock = ~rclock;
  
  initial begin
    wclock = 1'b0; wreset = 1'b0;
    w_en = 1'b0;
    data_in = 0;
	repeat(10) @(posedge wclock);
    wreset = 1'b1;

    repeat(2) begin
      for ( int i=0; i<32; i++)
	  begin
        @(posedge wclock iff !full);
        w_en = (i%2 == 0)? 1'b1 : 1'b0;
        if (w_en) begin
          data_in = $urandom;
          wdata_q.push_back(data_in);
        end
      end
      #50;
    end
  end
  
initial begin
    rclock = 1'b0;
	rreset = 1'b0;
    r_en = 1'b0;

    repeat(20) @(posedge rclock);
    rreset = 1'b1;

    repeat(2) begin
      for ( int i=0; i<32; i++) begin
        @(posedge rclock iff !empty);
        r_en = (i%2 == 0)? 1'b1 : 1'b0;
        if (r_en) begin
          wdata = wdata_q.pop_front();
          if(data_out !== wdata) $error("Time = %0t: Comparison Failed: expected wr_data = %h, rd_data = %h", $time, wdata, data_out);
          else $display("Time = %0t: Comparison Passed: wr_data = %h and rd_data = %h",$time, wdata, data_out);
        end
      end
      #50;
    end
	
 $finish;
  end
   initial begin 
    $dumpfile("dump.vcd"); 
     $dumpvars;
   end

  endmodule
