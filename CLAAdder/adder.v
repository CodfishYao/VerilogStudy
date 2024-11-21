module add_tc_16_16(
        input [31:0] A,
        input [31:0] B,
        output [32:0] Sum
    );
    //reg [32:0] Sum;
    wire [3:0] G, P;
    Adder_16bit u_Adder_16bit_1(
                    .A   	( A[15:0]   ),
                    .B   	( B[15:0]   ),
                    .Cin 	( Cin       ),
                    .S   	( Sum[15:0] ),
                    .Go  	( G[0]      ),
                    .Po  	( P[0]      )
                );
    Adder_16bit u_Adder_16bit_2(
                    .A   	( A[31:16]  ),
                    .B   	( B[31:16]  ),
                    .Cin 	(           ),
                    .S   	( Sum[31:16]),
                    .Go  	( G[1]      ),
                    .Po  	( P[1]      )
                );
    CLA_4bit u_CLA_4bit(
                    .P   	( P         ),
                    .G   	( G         ),
                    .Cin 	( Cin       ),
                    .Ci  	(           ),
                    .Po  	(           ),
                    .Go  	(           )
                );
    assign Sum[32] = G[1] | (P[1] & G[0]) | (P[1] & P[0] & Cin);        
endmodule
//16bit adder
module Adder_16bit(
        input [15:0] A,
        input [15:0] B,
        input       Cin,
        output[15:0] S,
        output      Go,
        output      Po
    );
    // outports wire
    wire [3:0] G, P, C;
    Adder_4bit u_Adder_4bit_1(
                   .A   	( A[3:0]   ),
                   .B   	( B[3:0]   ),
                   .Cin 	( Cin      ),
                   .S   	( S[3:0]   ),
                   .Go  	( G[0]     ),
                   .Po  	( P[0]     )
               );
    Adder_4bit u_Adder_4bit_2(
                   .A   	( A[7:4]   ),
                   .B   	( B[7:4]   ),
                   .Cin 	( C[0]     ),
                   .S   	( S[7:4]   ),
                   .Go  	( G[1]     ),
                   .Po  	( P[1]     )
               );
    Adder_4bit u_Adder_4bit_3(
                   .A   	( A[11:8]  ),
                   .B   	( B[11:8]  ),
                   .Cin 	( C[1]     ),
                   .S   	( S[11:8]  ),
                   .Go  	( G[2]     ),
                   .Po  	( P[2]     )
               );
    Adder_4bit u_Adder_4bit_4(
                   .A   	( A[15:12] ),
                   .B   	( B[15:12] ),
                   .Cin 	( C[2]     ),
                   .S   	( S[15:12] ),
                   .Go  	( G[3]     ),
                   .Po  	( P[3]     )
               );
    CLA_4bit u_CLA_4bit(
                    .P   	( P        ),
                    .G   	( G        ),
                    .Cin 	( Cin      ),
                    .Ci  	( C        ),
                    .Po  	( Po       ),
                    .Go  	( Go       )
                );
endmodule
//4bit adder
module Adder_4bit(
        input [3:0] A,
        input [3:0] B,
        input       Cin,
        output[3:0] S,
        output      Go,
        output      Po
    );
    // outports wire
    wire [3:0] G, P, C;
    Adder_1bit u_Adder_1bit_1(
                   .A   ( A[0] ),
                   .B   ( B[0] ),
                   .Cin ( Cin  ),
                   .S   ( S[0] ),
                   .G   ( G[0] ),
                   .P   ( P[0] )
               );
    Adder_1bit u_Adder_1bit_2(
                   .A   ( A[1] ),
                   .B   ( B[1] ),
                   .Cin ( C[0] ),
                   .S   ( S[1] ),
                   .G   ( G[1] ),
                   .P   ( P[1] )
               );
    Adder_1bit u_Adder_1bit_3(
                   .A   ( A[2] ),
                   .B   ( B[2] ),
                   .Cin ( C[1] ),
                   .S   ( S[2] ),
                   .G   ( G[2] ),
                   .P   ( P[2] )
               );
    Adder_1bit u_Adder_1bit_4(
                   .A   ( A[3] ),
                   .B   ( B[3] ),
                   .Cin ( C[2] ),
                   .S   ( S[3] ),
                   .G   ( G[3] ),
                   .P   ( P[3] )
               );
    CLA_4bit u_CLA_4bit(
                 .P   	( P    ),
                 .G   	( G    ),
                 .Cin 	( Cin  ),
                 .Ci  	( C    ),
                 .Po  	( Po   ),
                 .Go  	( Go   )
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
    assign S = A ^ B ^ Cin;
    assign G = A & B;
    assign P = A | B;
endmodule
