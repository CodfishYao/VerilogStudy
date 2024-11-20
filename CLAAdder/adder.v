module add_tc_16_16(
        input [31:0] A,
        input [31:0] B,
        output [32:0] Sum
    );
    reg [32:0] Sum;
endmodule
//4bit adder
module Adder_4bit(

);
endmodule
//4bit CLA
module CLA_4bit(
        input [3:0] P,//进位传送函数
        input [3:0] G,//进位函数
        input       Cin,//输入进位
        output[3:0] Ci,//进位
        output      Po,//输出的传送函数
        output      Go//输出的仅为函数
    );
    assign Ci[0] = G[0] | ( P[0] & Cin );
    assign Ci[1] = G[1] | ( P[1] & G[0]) | ( P[1] & P[0] & Cin );
    assign Ci[2] = G[2] | ( P[2] & G[1]) | ( P[2] & P[1] & G[0])
           | ( P[2] & P[1] & P[0]&  Cin);
    assign Ci[3] = G[3] | ( P[3] & G[2]) | ( P[3] & P[2] & G[1])
           | ( P[3] & P[2] & P[1]& G[0]) | ( P[3] & P[2] & P[1] & P[0] & Cin);
    assign Go    = G[3] | ( P[3] & G[2]) | ( P[3] & P[2] & G[1])
           | ( P[3] & P[2] & P[1]& G[0]);
    assign Po    = P[3] & P[2] & P[1] & P[0];
endmodule
//1bit Adder
module Adder_1bit(
        input A,//加数
        input B,//加数
        input Cin,//输入进位
        output S,//和
        output G,//与
        output P//或
    );
    assign S = A^B^Cin;
    assign G = A&B;
    assign P = A|B;
endmodule
