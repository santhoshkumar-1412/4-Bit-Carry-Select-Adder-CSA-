`timescale 1ns/1ps
module fa(s,cout,a,b,cin);
output s,cout;
input a,b,cin;
assign s=a^b^cin;
assign cout=(a&b)|(a&cin)|(b&cin);
endmodule
module bit4_rca(s,cout,a,b,cin);
output [3:0]s;
output cout;
input [3:0]a,b;
input cin;
wire c1,c2,c3;
fa fa0(s[0],c1,a[0],b[0],cin);
fa fa1(s[1],c2,a[1],b[1],c1);
fa fa2(s[2],c3,a[2],b[2],c2);
fa fa3(s[3],cout,a[3],b[3],c3);
endmodule
module bit4_csa(S,Cout,A,B,Cin);
output [3:0]S;
output Cout;
input [3:0]A,B;
input Cin;
wire [3:0]s0;
wire cout0;
wire [3:0]s1;
wire cout1;
bit4_rca cin_0(.s(s0),.cout(cout0),.a(A),.b(B),.cin(1'b0));
bit4_rca cin_1(.s(s1),.cout(cout1),.a(A),.b(B),.cin(1'b1));
assign S = (Cin == 1'b0) ? s0 : s1;
assign Cout = (Cin == 1'b0) ? cout0 : cout1;
endmodule
