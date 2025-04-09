
module procedure ();

endmodule


module code2_27;
logic [7:0] a = 8'd0, b = 8'd0;
wire [7:0] #5ns c = a;
wire [7:0] d;
assign #2ns d = c;
initial begin
    #10 a = 8'd10;
    #20 a = 8'd20;
    b = #10 8'd30;
    b = #20 8'd40;
    #30 a = 8'd30;
end
endmodule

module code2_28;
logic [7:0] a = 8'd0, b = 8'd0;
wire [7:0] #5ns c = a;
wire [7:0] d;
assign #2ns d = c;
initial fork
    #10 a = 8'd10;
    #20 a = 8'd20;
    b = #10 8'd30;
    b = #20 8'd40;
    #30 a = 8'd30;
join
endmodule

module code2_28_obs;
import CplxTypes::*;
logic [7:0] arr[0:255];
Cplx c0;
initial begin
    arr = '{256{8'h80}};
    c0 = '{16'sd100, -16'sd100};
end
integer a = 1, b = 2;
initial begin
    a = 3;
    b = a;
end
integer c = 1, d = 2;
initial fork
	c = 3;
    d = c;
join
endmodule

module code2_29;
logic [1:0] data = '1;
logic pup = '0;
wire (pull1, highz0) sda = pup;
assign (highz1, strong0) sda = data[0];
assign (highz1, strong0) sda = data[1];
initial begin
    #10ns data[0] = '0;
	#10ns data[1] = '0;
	#10ns data = '1;
	#10ns pup = '1;
	#10ns data[0] = '0;
	#10ns data[1] = '0;
end
endmodule

module code2_30;
logic ck = '1;
wire #2ns clk = ck;          //?ck??2ns??clk
logic [7:0] a = '0, b = '0;
logic [7:0] c, d, e, f;
always begin
    #10ns ck = ~ck;          //????20ns???ck
end
always begin
    #5ns a = a + 8'b1;       //??10ns?????a
    #5ns b = b + 8'b1;       //??10ns?????b
end
always@(a, b) begin          //???????
    c = a + b;
end
always@(*) begin             //????always???
    d = a + b;
end
always@(clk, a) begin        //clk??????
    if(clk) e = a;
end
always@(posedge clk) begin   //clk??????
    f = a;
end
endmodule

module code2_31;
logic ck = '1;
wire #2ns clk = ck;          //?ck??2ns??clk
logic en = '1, arst = '0;
logic [7:0] a = '0, b = '0;
logic [7:0] c, d, e, f, g, h, i;
initial begin
    #100 en = '0;
    #50 arst = '1;
    #50 en = '1;
    #50 arst = '0;
    #50 arst = '1;
    #50 arst = '0;
end
always begin
    #10ns ck = ~ck;          //????20ns???ck
end
always begin
    #5ns a = a + 8'b1;       //??10ns?????a
    #5ns b = b + 8'b1;       //??10ns?????b
end
always_comb begin             //????always???
    c = a + b;
end
always_comb begin        //clk??????
    if(clk) d = a + b;
end
always_comb begin        //clk??????
    if(clk) e = a + b;
    else e = a - b;
end
always_ff@(posedge clk) begin   //clk?????????
    f = a;
end
always_ff@(posedge clk iff en) //clk???????????????
begin                          //??en??en?????????
    g = a;
end
always_ff@(posedge clk iff en or posedge arst) //clk?????
begin                                          //?????????
    if(arst) h = 8'd0;                     //arst???????h??
    else h = a;
end
always_ff@(posedge clk iff en|arst)             //clk?????
begin                                          //?????????
    if(arst) i = '0;
    else i = a;
end
endmodule

module code2_33;
    logic a = '0, b = '0, c;
    initial begin
        a = '1;     //   1      a = 1
        b = a;      //   2      b = 1
        a <= '0;    //   4      a = 0
        b <= a;     //   4      b = 1
        c = '0;     //   3      c = 0
        c = b;      //   4      c = 1
    end
endmodule

module code2_34;
    logic clk = '1;
    always #10 clk = ~clk;
    logic [1:0] a[4] = '{'0, '0, '0, '0};
    always_ff@(posedge clk) begin :eg1
        a[0][0] = '1;
        a[0][1] = a[0][0];
    end
    always_ff@(posedge clk) begin
        a[1][0] = '1;
        a[1][1] <= a[1][0];
    end
    always_ff@(posedge clk) begin
        a[2][0] <= '1;
        a[2][1] = a[2][0];
    end
    always_ff@(posedge clk) begin
        a[3][0] <= '1;
        a[3][1] <= a[3][0];
    end
endmodule

module code2_35;
    logic [3:0] a = 4'd0;
    always #10 a = a + 4'd1;
    logic [3:0] b[4], c[4];
    always_comb begin
        b[0] = a + 4'd1;
        c[0] = b[0] + 4'd1;
    end
    always_comb begin
        b[1] = a + 4'd1;
        c[1] <= b[1] + 4'd1;
    end
    always_comb begin
        b[2] <= a + 4'd1;
        c[2] = b[2] + 4'd1;
    end
    always_comb begin
        b[3] <= a + 4'd1;
        c[3] <= b[3] + 4'd1;
    end
endmodule

