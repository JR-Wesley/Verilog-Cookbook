`timescale 1ns / 100ps

`include "../../SimSrcGen.sv"
`include "./ScFifo2.sv"
`include "./ScFifo1.sv"

module TestScFifo;
  import SimSrcGen::*;
  logic clk, rst_n;
  initial GenClk(clk, 8, 10);
  initial GenRstn(clk, rst_n, 1, 1);

  logic [7:0] din = '0, dout;
  logic wr = '0, rd = '0;
  logic [2:0] wr_cnt, rd_cnt, data_cnt;
  logic full, empty;

  initial begin
    repeat (10) @(posedge clk) {wr, din} = {1'b1, 8'($urandom())};
    @(posedge clk) wr = 1'b0;

    repeat (10) @(posedge clk) rd = 1'b1;
    @(posedge clk) rd = 1'b0;

    repeat (5) @(posedge clk) {wr, din} = {1'b1, 8'($urandom())};
    @(posedge clk) wr = 1'b0;

    repeat (5) @(posedge clk) rd = 1'b1;
    @(posedge clk) rd = 1'b0;

    repeat (5) @(posedge clk) {wr, din} = {1'b1, 8'($urandom())};
    @(posedge clk) wr = 1'b0;

    repeat (5) @(posedge clk) rd = 1'b1;
    @(posedge clk) rd = 1'b0;
    #10 $finish();
  end

  ScFifo2 #(
      .DW(8),
      .AW(3)
  ) theFifo (
    .*,
    .write(wr & ~full),
    .read (rd & ~empty)
  );

  logic [7:0] dout_p;
  logic [2:0] wr_cnt_p, rd_cnt_p, data_cnt_p;
  logic full_p, empty_p;
  ScFifo1 #(
      .DW(8),
      .AW(3)
  ) u_FIFO (
    .*,
    .dout    (dout_p),
    .wr_cnt  (wr_cnt_p),
    .rd_cnt  (rd_cnt_p),
    .data_cnt(data_cnt_p),
    .full    (full_p),
    .empty   (empty_p),
    .write   (wr & ~full),
    .read    (rd & ~empty)
  );

endmodule
