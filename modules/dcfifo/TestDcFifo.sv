`timescale 1ns / 1ps

`include "../../SimSrcGen.sv"
`include "./DcFifo.sv"

module TestDcFifo;
  import SimSrcGen::*;
  logic w_clk, w_rst_n;
  logic r_clk, r_rst_n;
  initial GenClk(w_clk, 8, 10);
  initial GenClk(r_clk, 7, 9);
  initial GenRstn(w_clk, w_rst_n, 1, 2);
  initial GenRstn(r_clk, r_rst_n, 1, 2);

  logic [7:0] din = '0, dout;
  logic wr = '0, rd = '0;
  logic [2:0] w_wr_cnt, w_rd_cnt, w_data_cnt;
  logic w_full, w_empty;
  logic [2:0] r_wr_cnt, r_rd_cnt, r_data_cnt;
  logic r_full, r_empty;

  initial begin
    #100;

    // ---- try write 10 data ----
    repeat (10) @(posedge w_clk) {wr, din} = {1'b1, 8'($urandom())};
    @(posedge w_clk) wr = 1'b0;
    // ---- try read 10 data ----
    repeat (2) @(posedge r_clk);
    repeat (10) @(posedge r_clk) rd = 1'b1;
    @(posedge r_clk) rd = 1'b0;

    // ---- try write 5 data ----
    repeat (5) @(posedge w_clk) {wr, din} = {1'b1, 8'($urandom())};
    @(posedge w_clk) wr = 1'b0;
    // ---- try read 5 data ----
    repeat (2) @(posedge r_clk);
    repeat (5) @(posedge r_clk) rd = 1'b1;
    @(posedge r_clk) rd = 1'b0;

    // ---- try write 5 data ----
    repeat (5) @(posedge w_clk) {wr, din} = {1'b1, 8'($urandom())};
    @(posedge w_clk) wr = 1'b0;
    // ---- try read 5 data ----
    repeat (2) @(posedge r_clk);
    repeat (5) @(posedge r_clk) rd = 1'b1;
    @(posedge r_clk) rd = 1'b0;

    #100 $finish();
  end

  DcFifo #(
      .DW(8),
      .AW(3)
  ) theFifo (
    .*,
    .write(wr & ~w_full),
    .read (rd & ~r_empty)
  );

endmodule

