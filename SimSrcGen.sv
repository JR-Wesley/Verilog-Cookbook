`ifndef __SIMSRCGEN_SV__
`define __SIMSRCGEN_SV__

package SimSrcGen;
  task automatic GenClk(ref logic clk, input realtime delay, realtime period);
    clk = 1'b0;
    #delay;
    forever #(period / 2) clk = ~clk;
  endtask
  task automatic GenRst(ref logic clk, ref logic rst, input int start, input int duration);
    rst = 1'b0;
    repeat (start) @(posedge clk);
    rst = 1'b1;
    repeat (duration) @(posedge clk);
    rst = 1'b0;
  endtask
  task automatic KeyPress(ref logic key, input realtime t);
    for (int i = 0; i < 30; i++) begin
      #0.11ms key = '0;
      #0.14ms key = '1;
    end
    #t;
    key = '0;
  endtask
  task automatic QuadEncGo(ref logic a, b, input logic ccw, realtime qprd);
    a = 0;
    b = 0;
    if (!ccw) begin
      #qprd a = 1;
      #qprd b = 1;
      #qprd a = 0;
      #qprd b = 0;
    end else begin
      #qprd b = 1;
      #qprd a = 1;
      #qprd b = 0;
      #qprd a = 0;
    end
  endtask
endpackage



`endif
