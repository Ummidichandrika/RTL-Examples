// Code your testbench here
// or browse Examples
`timescale 1ns / 1ps

module sync_fifo_tb;

    // Parameters
    parameter DEPTH = 8;
    parameter WIDTH = 8;

    // Inputs
    reg clk;
    reg rst;
    reg wr_en;
    reg rd_en;
    reg [WIDTH-1:0] din;

    // Outputs
    wire [WIDTH-1:0] dout;
    wire full;
    wire empty;

    // Instantiate the Unit Under Test (UUT)
    sync_fifo #(DEPTH, WIDTH) uut (
        .clk(clk), 
        .rst(rst), 
        .wr_en(wr_en), 
        .rd_en(rd_en), 
        .din(din), 
        .dout(dout), 
        .full(full), 
        .empty(empty)
    );

    // Clock generation (100MHz)
    always #5 clk = ~clk;

    initial begin
        // Initialize Inputs
        clk = 0;
        rst = 1;
        wr_en = 0;
        rd_en = 0;
        din = 0;

        // Wait for global reset
        #20;
        rst = 0;
        
        // --- Test Case 1: Write until Full ---
        $display("Starting Test Case 1: Write until Full");
        repeat (DEPTH) begin
            @(posedge clk);
            if (!full) begin
                wr_en = 1;
                din = $random;
                $display("Writing: %d", din);
            end
        end
        @(posedge clk);
        wr_en = 0;
        #10;
        if (full) $display("FIFO is Full as expected.");

        // --- Test Case 2: Read until Empty ---
        $display("\nStarting Test Case 2: Read until Empty");
        repeat (DEPTH) begin
            @(posedge clk);
            if (!empty) begin
                rd_en = 1;
            end
        end
        @(posedge clk);
        rd_en = 0;
        #10;
        if (empty) $display("FIFO is Empty as expected.");

        // --- Test Case 3: Simultaneous Read and Write ---
        $display("\nStarting Test Case 3: Simultaneous Read/Write");
        @(posedge clk);
        wr_en = 1;
        din = 8'hAA;
        @(posedge clk);
        wr_en = 1;
        rd_en = 1;
        din = 8'hBB;
        @(posedge clk);
        wr_en = 0;
        rd_en = 1;
        @(posedge clk);
        rd_en = 0;

        #50;
        $display("Simulation Finished");
        $finish;
    end
      
    initial begin
        $dumpfile("fifo_test.vcd");
        $dumpvars(0, sync_fifo_tb);
    end

endmodule
