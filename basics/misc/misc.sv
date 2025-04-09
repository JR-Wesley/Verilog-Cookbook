`default_nettype none
module test_chapter2;
  code2_39 inst_code2 ();
endmodule

module code2_36;
  initial begin
    $display("Hello World!");
  end
endmodule

// code 2_38
module my_adder #(
    parameter DW = 8  //integer????????8
) (
  input  wire               clk,
  rst,
  en,
  input  wire  [DW - 1 : 0] a,
  b,  //????????
  output logic [    DW : 0] sum   //????????
);
  always_ff @(posedge clk) begin
    if (rst) sum <= '0;
    else if (en) sum <= a + b;
  end
endmodule

module code2_39;
  logic clk = '0;
  always #5 clk = ~clk;
  logic [7:0] a = '0, b = '0, sum_ab;
  logic co_ab;
  logic [11:0] c = '0, d = '0;
  logic [12:0] sum_cd;
  always begin
    #10 a++;
    b++;
    c++;
    d++;
  end
  my_adder #(
      .DW(8)
  ) the_adder_8b (
    .clk(clk),
    .rst(1'b0),
    .en (1'b1),
    .a  (a),
    .b  (b),
    .sum({co_ab, sum_ab})
  );
  my_adder #(
      .DW(12)
  ) the_adder_12b (
    .clk(clk),
    .rst(1'b0),
    .en (1'b1),
    .a  (c),
    .b  (d),
    .sum(sum_cd)
  );
endmodule

// ====== code 2-40 ======

module mem40 #(
    parameter LEN = 256,
              DW  = 8
) (
  input  wire                        clk,
  rst,
  input  wire  [$clog2(LEN) - 1 : 0] addr,
  input  wire  [         DW - 1 : 0] d,
  input  wire                        wr,
  output logic [         DW - 1 : 0] q
);
  logic [DW - 1 : 0] m[LEN] = '{LEN{'0}};
  always_ff @(posedge clk) begin
    if (rst) m <= '{LEN{'0}};
    else if (wr) m[addr] <= d;
  end
  always_ff @(posedge clk) begin
    if (rst) q <= '0;
    else q <= m[addr];
  end
endmodule

module mem_tester40 #(
    parameter LEN = 256,
              DW  = 8
) (
  input  wire                        clk,
  rst,
  output logic [$clog2(LEN) - 1 : 0] addr,
  output logic [         DW - 1 : 0] d,
  output logic                       wr,
  input  wire  [         DW - 1 : 0] q
);
  initial addr = '0;
  always @(posedge clk) begin
    if (rst) addr <= '0;
    else addr <= addr + 1'b1;
  end
  assign wr = 1'b1;
  assign d = DW'(addr);
endmodule

module testmem40;
  logic clk = '0, rst = '0;
  always #5 clk = ~clk;
  initial begin
    #10 rst = '1;
    #20 rst = '0;
  end
  logic [5:0] addr;
  logic [7:0] d, q;
  logic wr;
  mem_tester #(64, 8) the_tester (
    clk,
    rst,
    addr,
    d,
    wr,
    q
  );
  mem #(64, 8) the_mem (
    clk,
    rst,
    addr,
    d,
    wr,
    q
  );
endmodule

// ====== end of code 2-40 ======

// ====== code 2-41 ======

interface membus #(  //????membus???
    parameter LEN = 256,
              DW  = 8
) (
  input wire clk,
  input wire rst   //??????clk?rst
);
  logic [$clog2(LEN) - 1 : 0] addr;
  logic [DW - 1 : 0] d, q;
  logic wr;
  modport master(
      output addr, d, wr,  //????master
      input clk, rst, q
  );
  modport slave(
      input clk, rst, addr, d, wr,  //????slave
      output q
  );
endinterface

module mem #(
    parameter LEN = 256,
              DW  = 8
) (
  membus.slave bus
);  //?????????bus
  logic [DW - 1 : 0] m[LEN] = '{LEN{'0}};
  always_ff @(posedge bus.clk) begin  //??bus??clk
    if (bus.rst) m <= '{LEN{'0}};
    else if (bus.wr) m[bus.addr] <= bus.d;
  end
  always_ff @(posedge bus.clk) begin
    if (bus.rst) bus.q <= '0;
    else bus.q <= m[bus.addr];
  end
endmodule

module mem_tester #(
    parameter LEN = 256,
              DW  = 8
) (
  membus.master bus
);
  initial bus.addr = '0;
  always @(posedge bus.clk) begin
    if (bus.rst) bus.addr <= '0;
    else bus.addr <= bus.addr + 1'b1;
  end
  assign bus.wr = 1'b1;
  assign bus.d = bus.addr;
endmodule

module testintfmem;
  logic clk = '0, rst = '0;
  always #5 clk = ~clk;
  initial begin
    #10 rst = '1;
    #20 rst = '0;
  end
  membus #(64, 8) the_bus (
    clk,
    rst
  );  //?????
  mem_tester #(64, 8) the_tester (the_bus);  //???????????
  mem #(64, 8) the_mem (the_bus);  //???????????
endmodule

// ====== end of code 2-41 ======

// code 2-42
module code2_42 (
  input  wire  [7:0] gray,
  output logic [7:0] bin
);
  assign bin[7] = ^gray[7:7];
  assign bin[6] = ^gray[7:6];
  assign bin[5] = ^gray[7:5];
  assign bin[4] = ^gray[7:4];
  assign bin[3] = ^gray[7:3];
  assign bin[2] = ^gray[7:2];
  assign bin[1] = ^gray[7:1];
  assign bin[0] = ^gray[7:0];
endmodule

// code 2-43
module code2_43 #(
    parameter DW = 8
) (
  input  wire  [DW - 1 : 0] gray,
  output logic [DW - 1 : 0] bin
);
  generate
    for (genvar i = 0; i < DW; i++) begin : binbits
      assign bin[i] = ^gray[DW-1 : i];
    end
  endgenerate
endmodule

module code2_44;
  localparam DW = 8;

  task automatic gen_reset(ref reset, input time start, input time stop);
    #start reset = 1'b1;
    #(stop - start) reset = 1'b0;
  endtask
  logic rst = 1'b0;
  initial gen_reset(rst, 10ns, 25ns);

  function automatic [$clog2(DW) - 1 : 0] log2(input [DW - 1 : 0] x);
    log2 = 0;
    while (x > 1) begin
      log2++;
      x >>= 1;
    end
  endfunction
  logic [DW - 1 : 0] a = 8'b0;
  logic [$clog2(DW) - 1 : 0] b;
  always #10 a++;
  assign b = log2(a);
endmodule

// ====== code 2-45 ======
package Q15Types;
  typedef logic signed [15:0] Q15;
  typedef struct packed {Q15 re, im;} CplxQ15;
  function CplxQ15 add(CplxQ15 a, CplxQ15 b);
    add.re = a.re + b.re;
    add.im = a.im + b.im;
  endfunction
  function CplxQ15 mulCplxQ15(CplxQ15 a, CplxQ15 b);
    mulCplxQ15.re = (32'(a.re) * b.re - 32'(a.im) * b.im) >>> 15;
    mulCplxQ15.im = (32'(a.re) * b.im + 32'(a.im) * b.re) >>> 15;
  endfunction
endpackage

module testpackage;
  import Q15Types::*;
  CplxQ15 a = '{'0, '0}, b = '{'0, '0};
  always begin
    #10 a.re += 16'sd50;
    a.im += 16'sd100;
    b.re += 16'sd200;
    b.im += 16'sd400;
  end
  CplxQ15 c;
  always_comb c = mulCplxQ15(a, b);
  real ar, ai, br, bi, cr, ci, dr, di;
  always @(c) begin
    ar = real'(a.re) / 32768;
    ai = real'(a.im) / 32768;
    br = real'(b.re) / 32768;
    bi = real'(b.im) / 32768;
    cr = real'(c.re) / 32768;
    ci = real'(c.im) / 32768;
    dr = ar * br - ai * bi;
    di = ar * bi + ai * br;
    if (dr < 1.0 && dr > -1.0 && di < 1.0 && di > -1.0) begin
      if (cr - dr > 1.0 / 32768.0 || cr - dr < -1.0 / 32768.0) $display("err:\t", cr, "\t", dr);
      if (ci - di > 1.0 / 32768.0 || ci - di < -1.0 / 32768.0) $display("err:\t", ci, "\t", di);
    end
  end
endmodule

// ====== end of code 2-45 ======

module testrealtobits;
  logic [63:0] a;
  logic [31:0] b;
  real c;
  initial begin
    a = $realtobits(0.375);
    b = $shortrealtobits(0.375);
    c = $atan2(0, 0);
    c = $atan2(1, 0);
    c = $atan2(0, -1);
    c = $atan2(-1, 0);
  end
endmodule

module code2_997 (
  input      wire integer a,
  output var integer      b
);
  integer ar[4] = '{11, 13, 17, 19};
  always_comb begin
    //	case(a) inside
    //        0,1: b = 1;
    //        2: b = 2;
    //        3,4, [6:9], ar: b = 3;
    //        default: b = 0;
    //    endcase
    b = 0;
    for (int i = 0; i < 10; i++) b = b + a;
  end
endmodule

module code2_998;
  real a = 0.0;
  logic b;
  always #10 a = a + 1.0;
  always_comb begin
    b = a inside {1.0, 2.0, 5.0, [8.0 : 10.0]};
  end
endmodule

module code2_999;
  logic [7:0] af;
  logic [7:0] ag[8];

  logic a = '0, b = '1;
  logic clk = '0;
  always #5 clk = ~clk;
  //always fork
  //a = @(posedge clk) 1'b1;
  //b = @(posedge clk) a;
  //join
  always a = @(posedge clk) 1'b1;
  always b = @(posedge clk) a;
endmodule

module code2_996;
  logic clk = '0;
  always #5 clk = ~clk;
  logic rst = '0;
  initial begin
    #10 rst = '1;
    #20 rst = '0;
  end
  logic en1s, en1m, en1h;
  logic [5:0] sec, min;
  logic [4:0] hr;
  cnt #(1000) cnt_1s (
    .clk,
    .rst  /*, .en(1'b1)*/,
    .co(en1s)
  );
  cnt #(60) cnt_60s (
    .clk,
    .rst,
    .en (en1s),
    .cnt(sec),
    .co (en1m)
  );
  cnt #(60) cnt_60m (
    .clk,
    .rst,
    .en (en1m),
    .cnt(min),
    .co (en1h)
  );
  cnt #(24) cnt_60h (
    .clk,
    .rst,
    .en (en1h),
    .cnt(hr)
  );
endmodule

module cnt #(
    parameter longint unsigned M = 100
) (
  input      wire logic                     clk,
  rst = 1'b0,
  en = 1'b1,
  output var logic      [$clog2(M) - 1 : 0] cnt = '0,
  output var logic                          co
);
  localparam DW = $clog2(M);
  always_ff @(posedge clk) begin
    if (rst) cnt <= 1'b0;
    else if (en) begin
      if (cnt < DW'(M - 1)) cnt <= cnt + 1'b1;
      else cnt <= 1'b0;
    end
  end
  assign co = en & (cnt == DW'(M - 1));
endmodule
