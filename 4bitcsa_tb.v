`timescale 1ns/1ps
module bit4_csa_tb;
wire [3:0]S;
wire Cout;
reg [3:0]A,B;
reg Cin;
bit4_csa dut(.S(S),.Cout(Cout),.A(A),.B(B),.Cin(Cin));
initial 
begin
$monitor("Time=0\%0td | A=%d B=%d Cin=%d |Sum=%d Cout=%b",$time,A,B,Cin,S,Cout);
$dumpfile("4BITCARRYSELECTADDER.vcd");
$dumpvars(0,bit4_csa_tb);
A=4'd3;B=4'd4;Cin=1'b0;
#10;A=4'd3;B=4'd4;Cin=1'b1;
#10;A=4'd7;B=4'd5;Cin=1'b0;
#10;A=4'd5;B=4'd8;Cin=1'b1;
#20;
$finish;
end
endmodule
