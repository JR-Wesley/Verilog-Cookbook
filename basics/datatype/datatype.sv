
module datatype ();

endmodule

module code2_20;
struct {
    logic signed [15:0] re;
    logic signed [15:0] im;
} c0, c1;
struct {
    time t; integer val;
} a;
endmodule

module code2_21;
typedef struct packed {
    logic signed [15:0] re;
    logic signed [15:0] im;
} Cplx;
Cplx c0, c1;
wire Cplx c2 = c0;
endmodule

package CplxTypes;
typedef struct {
    logic signed [15:0] re;
    logic signed [15:0] im;
} Cplx;
endpackage

module code2_22;
import CplxTypes::*;
logic signed [15:0] a = 16'sd3001;
logic signed [15:0] b = -16'sd8778; 
Cplx c0, c1, c2;                       //c0=c1=c2='{x,x}
wire Cplx c3 = c1;                     //c3=c1='{x,x}
wire Cplx c4 = '{a, b};                //c4={3001,-8778}
initial begin
c0.re = 16'sd3001;                     //c0='{3001,x}
c0.im = b;                             //c0='{3001,-8778}
c1 = '{16'sd3001, -16'sd8778};         //c3=c1={3001,-8778}
c2 = '{a, -16'sd1};                    //c2={3001,-1}
c2 = '{c2.im, c2.re};                  //c2={-1,3001}
a = 16'sd1;                            //c4={1,-8778}
end
endmodule

module code2_23;
typedef struct packed {
    logic signed [15:0] re;
    logic signed [15:0] im;
} Cplx;
Cplx c0 = {16'sd5, -16'sd5};
logic signed [15:0] a = c0.re;        //a=5
logic signed [15:0] b = c0[31:16];    //b=5
logic [3:0] c = c0[17:14];            //c=4'b0111
Cplx c1 = {<<16{c0}};                 //c1='{-5,5}
endmodule

module code2_24;
typedef union packed {
    logic [15:0] val;
    struct packed {
        logic [7:0] msbyte;
        logic [7:0] lsbyte;
    } bytes;
} Abc;
Abc a;
initial begin
a.val = 16'h12a3;           //a.byte.msbyte=8'h12, lsbyte=8'a3
a.bytes.msbyte = 8'hcd;     //a.val=16'hcda3;
end
endmodule

module code2_25;
typedef union tagged {
    logic [31:0] val;
    struct packed {
        byte b3;
        byte b2;
        byte b1;
        byte b0;
    } bytes;
} Abct;
Abct ut;
logic [31:0] c;
byte d;
initial begin
ut.val = 32'h7a3f5569;
ut = tagged val 32'h1234abcd;
d = ut.bytes.b0;
ut = tagged bytes '{'h11, 'h22, 'h33, 'h44};
d = ut.bytes.b0;
end
endmodule

module code2_26;
logic [3:0][7:0] a[0:1][0:2] =
    '{'{32'h00112233, 32'h112a3a44, 32'h22334455},
      '{32'h33445566, 32'h4455aa77, 32'hf5667788}
     };
logic [31:0] b = a[0][2];        //32'h22334455;
logic [15:0] c = a[0][1][2:1];   //16'h2a3a;
logic [7:0] d = a[1][1][1];      //8'haa;
logic [3:0] e = a[1][2][3][4+:4];//4'hf;
initial begin
    a[0][0][3:2] = a[1][0][1:0]; //a[0][0]=32'h55662233
end

logic rd[16], rc[16];
logic [15:0] va;
logic an;
initial begin
	{>>{rd}} = 16'b1 << 1;
	va = {>>{rd}};
	rc = rd;
	an = |({>>{rd}} & {>>{rc}});
end
endmodule
