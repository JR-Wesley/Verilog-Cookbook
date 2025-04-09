
module operator ();

endmodule

module code2_9;

  logic [3:0] a = 4'he;
  logic [1:0] b = a;  //b=2'b10
  logic [5:0] c = a;  //c=6'b001110
  logic [5:0] d = 6'(a);  //??
  logic [5:0] e = 6'($signed(a));  //e=6'b111110
  logic signed [7:0] f = 4'sd5 * a;  //f=70
  logic signed [7:0] g = 4'sd5 * $signed(a);  //g=-10

endmodule

module code2_10;

  logic [3:0] a = 4'hF;
  logic [5:0] b = 6'h3A;
  logic [11:0] c = {a * b};  //c???38
  logic [11:0] d = a * b;  //d???870
  logic signed [15:0] a0 = 16'sd30000, a1 = 16'sd20000;
  logic signed [15:0] sum0 = (a0 + a1) >>> 1;  //sum0=-7768
  logic signed [15:0] sum1 = (17'sd0 + a0 + a1) >>> 1;  //sum1=25000
  logic signed [15:0] sum2 = (17'(a0) + a1) >>> 1;  //sum2=25000

endmodule

module code2_11;
  parameter logic signed [3:0] pa = -4'sd6;
  const logic signed [3:0] pb = -4'sd6;
  logic [7:0] a = 8'd250;  //8'd250=8'hFA
  logic signed [3:0] b = -4'sd6;  //-4'sd6(4'hA)
  logic c = a == b;  //c=0
  logic d = a == -4'sd6;  //d=1
  logic pc = a == pa;
  logic pd = a == pb;
  logic e = 8'sd0 > b;  //e=1
  logic f = 8'd0 < b;  //f=1
  logic [7:0] prod0 = 4'd9 * -4'sd7;  //prod0=193
  logic signed [7:0] prod1 = 4'd9 * -4'sd7;  //prod1=-63
  logic [7:0] prod2 = 8'd5 * b;  //prod2=50
  logic [7:0] prod3 = 8'd5 * -4'sd6;  //prod3=226

endmodule

module code2_12;
  logic [15:0] a = 16'h5e39;  //16'b0101_1110_0011_1001
  logic b = a[15], c = a['ha];  //b=1'b0, c=1'b1
  logic [3:0] d = a[11:8], e = a[13:10];  //d=4'b1110, e=4'b0111
  logic [7:0] f = a[7:0], g = a[2*4:1];  //f=8'h39, g=8'b0001_1100
  logic [7:0] h = a[4+:8], i = a[15-:8];  //h=8'he3, i=8'h5e
  logic [3:0] j;
  //logic [2:0] k = a[j+2:j];           //???????????????
  logic [2:0] l = a[j+:3];  //??i=3, j=3'b111
  initial begin
    a[7:4] = 4'h9;  //a=16'h5e99
    a[4] = 1'b0;  //a=16'h5e89
  end
endmodule

module code2_13;
  logic [7:0] a = 8'hc2;  //a=1100_0010
  logic signed [3:0] b = -4'sh6;  //b=4'b1010=4'ha
  logic [11:0] c = {a, b};  //c=12'hc2a
  logic [15:0] d = {3'b101, b, a, 1'b0};  //d=16'b101_1010_1100_0010_0
  logic [63:0] e = {4 * 4{b}};  //e=64'haaaa_aaaa_aaaa_aaaa
  logic [17:0] f = {3{b, 2'b11}};  //f=18'b101011_101011_101011
  logic [15:0] g = {a, {4{2'b01}}};  //g=16'hc255
  initial begin
    {a, b} = 12'h9bf;  //a=8'h9b, b=4'hf=-4'sh1
  end
endmodule

module code2_14;
  logic [15:0] a = 16'h37bf;  //16'b0011_0111_1011_1111
  logic [15:0] b = {>>{a}};  //b=16'h37bf
  logic [15:0] c = {<<{a}};  //c=16'hfdec=16'b1111_1101_1110_1100
  logic [19:0] d = {<<{4'ha, a}};  //d=16'hfdec5
  logic [15:0] e = {<<4{a}};  //e=16'hfb73
  logic [15:0] f = {<<8{a}};  //f=16'hbf37
  logic [15:0] g = {<<byte{a}};  //g=16'hbf37
  logic [8:0] h = {<<3{{<<{9'b110011100}}}};  //h=9'b011_110_001
  logic [3:0] i;
  initial begin
    {<<{i}} = 4'b1011;  //i=4'b1101
    {<<2{i}} = 4'b1011;  //i=4'b1110
  end
endmodule

module code2_15;
  logic [7:0] a = 8'h9c;  //  8'b10011100 = 156
  logic signed [7:0] b = -8'sh64;  //  8'b10011100 = -100
  logic [7:0] c = a << 2;  //c=8'b01110000
  logic [7:0] d = b << 2;  //d=8'b01110000
  logic [7:0] e = b <<< 2;  //e=8'b01110000
  logic [7:0] f = b >> 2;  //f=8'b00100111 = 39 
  logic [7:0] g = a >>> 2;  //g=8'b00100111 = 39
  logic [7:0] h = b >>> 2;  //h=8'b11100111 = -25
  logic [7:0] i = 9'sh9c >>> 2;  //i=8'b00100111
  logic [1:0] j = -4'sd5 >>> 2;
endmodule

module code2_16;
  logic [3:0] a = 4'h3;
  logic [3:0] b;
  initial begin
    a++;  //a=4
    a--;  //a=3
    b = 4'd1 + a++;  //b=4, a=4
    b = 4'd1 + ++a;  //b=6, a=5
    b = a++ + (a = a - 1);
  end
endmodule

module code2_17;
  logic a = 4'b0010 || 2'b1z;  // a = 1'b1 | 1'bx = 1'b1
  logic b = 4'b1001 < 4'b11xx;  // b = 1'bx
  logic c = 4'b1001 == 4'b100x;  // c = 1'bx
  logic d = 4'b1001 != 4'b000x;  // d = 1'b1
  logic e = 4'b1001 === 4'b100x;  // e = 1'b0
  logic f = 4'b100x === 4'b100x;  // f = 1'b1
  logic g = 4'b1001 ==? 4'b10xx;  // g = 1'b1
  logic h = 4'b1001 !=? 4'b11??;  // h = 1'b1
  logic i = 4'b10x1 !=? 4'b100?;  // i = 1'bx
  logic ii0 = 0 -> 1;
  logic ii1 = 0 -> 0;
  logic ii2 = 1 -> 1;
  logic ii3 = 0 -> 1'bx;
  logic ii4 = 1'bx -> 1;
  logic ii5 = 1 -> 0;
  logic eq0 = 0 <-> 0;
  logic eq1 = 1 <-> 1;
  logic eq2 = 0 <-> 1;
  logic eq3 = 1 <-> 0;
endmodule

module code2_19;
  let max(a, b) = a > b ? a : b; let abs(a) = a > 0 ? a : -a;
  logic signed [15:0] a, b, c;
  initial begin
    c = max(abs(a), abs(b));
  end
endmodule
