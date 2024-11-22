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
    assign PP1 = (PP[0][16] == 1'b1) ? {15'b1,PP[0]} : {15'b0,PP[0]};
    wire [29:0] PP1;
    assign PP1 = (PP[1][16] == 1'b1) ? {13'b1,PP[1]} : {13'b0,PP[1]};
    wire [27:0] PP2;
    assign PP1 = (PP[2][16] == 1'b1) ? {11'b1,PP[2]} : {11'b0,PP[2]};
    wire [25:0] PP3;
    assign PP1 = (PP[3][16] == 1'b1) ? {9'b1, PP[3]} : {9'b0, PP[3]};
    wire [23:0] PP4;
    assign PP1 = (PP[4][16] == 1'b1) ? {7'b1, PP[4]} : {7'b0, PP[4]};
    wire [21:0] PP5;
    assign PP1 = (PP[5][16] == 1'b1) ? {5'b1, PP[5]} : {5'b0, PP[5]};
    wire [19:0] PP6;
    assign PP1 = (PP[6][16] == 1'b1) ? {3'b1, PP[6]} : {3'b0, PP[6]};
    wire [17:0] PP7;
    assign PP1 = (PP[7][16] == 1'b1) ? {1'b1, PP[7]} : {1'b0, PP[7]};
    //


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
