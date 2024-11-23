module mul_tc_16_16(
        input [15:0] a,
        input [15:0] b,
        output reg [31:0] product
    );

    wire [7:0] booth0;
    wire [7:0] booth1;
    wire [7:0] booth2;
    wire [16:0] b0;
    assign b0 = {b,1'b0};//乘数后补一个0
    //reg [16:0] PP1,PP2,PP3,PP4,PP5,PP6,PP7,PP8;
    wire [16:0] PP [7:0];//存储部分积的网络
    //reg [7:0] PPreg [16:0];
    //生成所有的部分积
    genvar i;
    generate
        for(i = 0; i < 8 ;i = i + 1) begin
            toBooth u_toBooth(
                        .multiplicand 	( b0[2*(i+1):2*i]  ),
                        .booth        	( {booth2[i],booth1[i],booth0[i]} )
                    );
            generatePP u_generatePP(
                           .A(a),
                           .booth({booth2[i],booth1[i],booth0[i]}),
                           .PP(PP[i])
                       );
        end
    endgenerate
    //将部分积进行符号位扩展
    wire [31:0] PP0;
    assign PP0 = (PP[0][16] == 1'b1) ? {15'b1,PP[0]} : {15'b0,PP[0]};
    wire [29:0] PP1;
    assign PP1 = (PP[1][16] == 1'b1) ? {13'b1,PP[1]} : {13'b0,PP[1]};
    wire [27:0] PP2;
    assign PP2 = (PP[2][16] == 1'b1) ? {11'b1,PP[2]} : {11'b0,PP[2]};
    wire [25:0] PP3;
    assign PP3 = (PP[3][16] == 1'b1) ? {9'b1, PP[3]} : {9'b0, PP[3]};
    wire [23:0] PP4;
    assign PP4 = (PP[4][16] == 1'b1) ? {7'b1, PP[4]} : {7'b0, PP[4]};
    wire [21:0] PP5;
    assign PP5 = (PP[5][16] == 1'b1) ? {5'b1, PP[5]} : {5'b0, PP[5]};
    wire [19:0] PP6;
    assign PP6 = (PP[6][16] == 1'b1) ? {3'b1, PP[6]} : {3'b0, PP[6]};
    wire [17:0] PP7;
    assign PP7 = (PP[7][16] == 1'b1) ? {1'b1, PP[7]} : {1'b0, PP[7]};
    //第一层的和与进位
    wire [29:0] S1;
    wire [28:0] C1;
    wire [25:0] S2;
    wire [22:0] C2;
    //Wallace树的第一层全加器和半加器
    assign S2[1:0] = PP3[1:0];
    genvar firstHACnt;
    //半加器
    generate
        for(firstHACnt = 0; firstHACnt < 2; firstHACnt = firstHACnt + 1) begin
            HA u_firstHA0(
                   .A(PP0[firstHACnt + 2]),
                   .B(PP1[firstHACnt]),
                   .S(S1[firstHACnt]),
                   .C(C1[firstHACnt])
               );
            HA u_firstHA1(
                   .A(PP3[firstHACnt + 2]),
                   .B(PP4[firstHACnt]),
                   .S(S2[firstHACnt + 2]),
                   .C(C2[firstHACnt])
               );
        end
    endgenerate
    //全加器
    genvar firstFACnt0;
    generate
        for(firstFACnt0 = 0; firstFACnt0 < 27; firstFACnt0 = firstFACnt0 +1) begin
            FA u_firstFA0(
                   .A ( PP0[firstFACnt0 + 4] ),
                   .B ( PP1[firstFACnt0 + 2] ),
                   .Ci( PP2[firstFACnt0    ] ),
                   .S ( S1 [firstFACnt0 + 2] ),
                   .C ( C1 [firstFACnt0 + 2] )
               );
        end
    endgenerate
    FA u_firstFALast0(
           .A  ( PP1[31] ),
           .B  ( PP2[29] ),
           .Ci ( PP3[27] ),
           .S  ( S1 [29] ),
           .C  ( )
       );
    genvar firstFACnt1;
    generate
        for(firstFACnt1 = 0; firstFACnt1 < 21; firstFACnt1 = firstFACnt1 +1) begin
            FA u_firstFA1(
                   .A ( PP3[firstFACnt1 + 4] ),
                   .B ( PP4[firstFACnt1 + 2] ),
                   .Ci( PP5[firstFACnt1    ] ),
                   .S ( S2 [firstFACnt1 + 4] ),
                   .C ( C2 [firstFACnt1 + 2] )
               );
        end
    endgenerate
    FA u_firstFALast1(
           .A  ( PP4[25] ),
           .B  ( PP2[23] ),
           .Ci ( PP3[21] ),
           .S  ( S2 [25] ),
           .C  ( )
       );
    //第二层的和与进位
    wire [28:0] S3;
    wire [27:0] C3;
    wire [22:0] S4;
    wire [18:0] C4;
    //Wallace树的第二层全加器和半加器
    //半加器
    genvar secondHACnt0;
    generate
        for(secondHACnt0 = 0; secondHACnt0 < 3; secondHACnt0 = secondHACnt0 + 1) begin
            HA u_secondHA0(
                   .A 	( S1[secondHACnt0 + 1]  ),
                   .B 	( C1[secondHACnt0    ]  ),
                   .S 	( S3[secondHACnt0    ]  ),
                   .C 	( C3[secondHACnt0    ]  )
               );

        end
    endgenerate
    assign S4[2:0] = C2[2:0];
    genvar secondHACnt1;
    generate
        for(secondHACnt1 = 0; secondHACnt1 < 2; secondHACnt1 = secondHACnt1 + 1) begin
            HA u_secondHA0(
                   .A 	( C2 [secondHACnt1 + 3]  ),
                   .B 	( PP6[secondHACnt1    ]  ),
                   .S 	( S4 [secondHACnt1 + 3]  ),
                   .C 	( C4 [secondHACnt1    ]  )
               );

        end
    endgenerate
    //全加器
    genvar secondFACnt0;
    generate
        for(secondFACnt0 = 0; secondFACnt0 < 25; secondFACnt0 = secondFACnt0 + 1) begin
            FA u_secondFA0(
                   .A  	( S1 [secondFACnt0 + 4]  ),
                   .B  	( C1 [secondFACnt0 + 3]  ),
                   .Ci 	( S2 [secondFACnt0] ),
                   .S  	( S3 [secondFACnt0 + 3]  ),
                   .C  	( C3 [secondFACnt0 + 3]  )
               );
        end
    endgenerate
    FA u_secondFAlast0(
           .A  	( S1 [29] ),
           .B  	( C1 [28] ),
           .Ci 	( S2 [25] ),
           .S  	( S3 [28]),
           .C  	(    )
       );
    genvar secondFACnt1;
    generate
        for(secondFACnt1 = 0; secondFACnt1 < 17; secondFACnt1 = secondFACnt1 + 1) begin
            FA u_secondFA1(
                   .A  	( C2 [secondFACnt1 + 5]  ),
                   .B  	( PP6[secondFACnt1 + 2]  ),
                   .Ci 	( PP7[secondFACnt1]  ),
                   .S  	( S4 [secondFACnt1 + 5]  ),
                   .C  	( C4 [secondFACnt1 + 2]  )
               );
        end
    endgenerate
    FA u_secondFAlast1(
           .A  	( C2 [22] ),
           .B  	( PP6[19] ),
           .Ci 	( PP7[17] ),
           .S  	( S4 [22]),
           .C  	(    )
       );
    //第三层的和与进位
    wire [27:0] S5;
    wire [26:0] C5;
    //Wallace树的第三层全加器和半加器
    //半加器
    genvar thirdHACnt0;
    generate
        for(thirdHACnt0 = 0; thirdHACnt0 < 3; thirdHACnt0 = thirdHACnt0 + 1) begin
            HA u_secondHA0(
                   .A 	( S3[thirdHACnt0 + 1]  ),
                   .B 	( C3[thirdHACnt0    ]  ),
                   .S 	( S5[thirdHACnt0    ]  ),
                   .C 	( C5[thirdHACnt0    ]  )
               );
        end
    endgenerate
    //全加器
    genvar thirdFACnt0;
    generate
        for(thirdFACnt0 = 0; thirdFACnt0 < 22; thirdFACnt0 = thirdFACnt0 + 1) begin
            FA u_secondFA0(
                   .A  	( S3 [thirdFACnt0 + 6]  ),
                   .B  	( C3 [thirdFACnt0 + 5]  ),
                   .Ci 	( S4 [thirdFACnt0] ),
                   .S  	( S5 [thirdFACnt0 + 5]  ),
                   .C  	( C5 [thirdFACnt0 + 5]  )
               );
        end
    endgenerate
    FA u_thirdFAlast0(
           .A  	( S3 [28] ),
           .B  	( C3 [27] ),
           .Ci 	( S4 [22] ),
           .S  	( S5 [27] ),
           .C  	(    )
       );
    //第四层的和与进位
    wire [26:0] S6;
    wire [25:0] C6;
    //Wallace树的第四层全加器和半加器
    //半加器
    genvar fourthHACnt0;
    generate
        for(fourthHACnt0 = 0; fourthHACnt0 < 8; fourthHACnt0 = fourthHACnt0 + 1) begin
            HA u_secondHA0(
                   .A 	( S5[fourthHACnt0 + 1]  ),
                   .B 	( C5[fourthHACnt0    ]  ),
                   .S 	( S6[fourthHACnt0    ]  ),
                   .C 	( C6[fourthHACnt0    ]  )
               );
        end
    endgenerate
    //全加器
    genvar fourthFACnt0;
    generate
        for(fourthFACnt0 = 0; fourthFACnt0 < 18; fourthFACnt0 = fourthFACnt0 + 1) begin
            FA u_secondFA0(
                   .A  	( S5 [fourthFACnt0 + 9]  ),
                   .B  	( C5 [fourthFACnt0 + 8]  ),
                   .Ci 	( C4 [fourthFACnt0] ),
                   .S  	( S6 [fourthFACnt0 + 8]  ),
                   .C  	( C6 [fourthFACnt0 + 8]  )
               );
        end
    endgenerate
    FA u_fourthFAlast0(
           .A  	( S5 [27] ),
           .B  	( C5 [26] ),
           .Ci 	( C4 [18] ),
           .S  	( S6 [26] ),
           .C  	(    )
       );
    //Wallace树的最后一层行波进位加法器
    wire [25:0] sum = S6[26:1] + C6[25:0];
    //给输出寄存器赋值
    always @(*) begin
        product[1:0]  = PP0[1:0];
        product[2]    = S1 [0];
        product[3]    = S3 [0];
        product[4]    = S5 [0];
        product[5]    = S6 [0];
        product[31:6] = sum;
    end
endmodule
//生成部分积
module generatePP(
        input [15:0] A,
        input [2:0] booth,
        output reg [16:0] PP
    );
    always @(*) begin
        case(booth)
            3'b000: begin//此时操作值为0
                PP = 17'b0;
            end
            3'b001: begin//部分积是A
                PP[15:0] = A;
                //判断A是否是负数，不是是负数高位补0，反之补1
                if(A[15]==1'b0) begin
                    PP[16] = 1'b0;
                end
                else begin
                    PP[16] = 1'b1;
                end
            end
            3'b010: begin//部分积是A的二倍
                PP[16:1] = A;
                PP[0] = 0;
            end
            3'b110: begin//部分积是A的负二倍
                PP[16:1] = (~A) + 1'b1;
                PP[0] = 0;
            end
            3'b101: begin//部分积是A的-1倍
                PP[15:0] = (~A) + 1'b1;
                PP[16] = PP[15];
            end
            default:
                PP = 17'b0;
        endcase
    end
endmodule
//booth控制码
module toBooth(
        input [2:0] multiplicand,
        output reg [2:0] booth
    );
    always @(*) begin
        case(multiplicand)
            3'b000:
                booth = 3'b000;
            3'b001:
                booth = 3'b001;
            3'b010:
                booth = 3'b001;
            3'b011:
                booth = 3'b010;
            3'b100:
                booth = 3'b110;
            3'b101:
                booth = 3'b101;
            3'b110:
                booth = 3'b101;
            3'b111:
                booth = 3'b000;
            default:
                booth = 3'b000;
        endcase
    end
endmodule
//全加器
module FA(
        input A,
        input B,
        input Ci,
        output S,
        output C
    );
    assign C = (A & B) | ((A ^ B) & Ci);
    assign S = A ^ B ^ Ci;
endmodule
//半加器
module HA(
        input A,
        input B,
        output S,
        output C
    );
    assign C = A & B;
    assign S = A ^ B;
endmodule
