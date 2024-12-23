module sort_32_u8(
        input        clk, rst_n, vld_in,
        input  [7:0] din_0, din_1, din_2, din_3, din_4,
        input  [7:0] din_5, din_6, din_7, din_8, din_9,
        input  [7:0] din_10, din_11, din_12, din_13, din_14,
        input  [7:0] din_15, din_16, din_17, din_18, din_19,
        input  [7:0] din_20, din_21, din_22, din_23, din_24,
        input  [7:0] din_25, din_26, din_27, din_28, din_29,
        input  [7:0] din_30, din_31,
        output       vld_out,
        output [7:0] dout_0, dout_1, dout_2, dout_3, dout_4,
        output [7:0] dout_5, dout_6, dout_7, dout_8, dout_9,
        output [7:0] dout_10, dout_11, dout_12, dout_13, dout_14,
        output [7:0] dout_15, dout_16, dout_17, dout_18, dout_19,
        output [7:0] dout_20, dout_21, dout_22, dout_23, dout_24,
        output [7:0] dout_25, dout_26, dout_27, dout_28, dout_29,
        output [7:0] dout_30, dout_31
    );
    //
    reg vld_out;
    reg outState;
    //存入输入变量
    reg [7:0] din [31:0];
    //存入输出变量
    reg [7:0] dout [31:0];
    //对上面两个变量赋值
    always @(*) begin
        if(!vld_out) begin//compare_end == 32'b1111_1111_1111_1111_1111_1111_1111_1111
            din[0] <= din_0; din[10] <= din_10; din[20] <= din_20; din[30] <= din_30;
            din[1] <= din_1; din[11] <= din_11; din[21] <= din_21; din[31] <= din_31;
            din[2] <= din_2; din[12] <= din_12; din[22] <= din_22; 
            din[3] <= din_3; din[13] <= din_13; din[23] <= din_23; 
            din[4] <= din_4; din[14] <= din_14; din[24] <= din_24; 
            din[5] <= din_5; din[15] <= din_15; din[25] <= din_25; 
            din[6] <= din_6; din[16] <= din_16; din[26] <= din_26; 
            din[7] <= din_7; din[17] <= din_17; din[27] <= din_27; 
            din[8] <= din_8; din[18] <= din_18; din[28] <= din_28; 
            din[9] <= din_9; din[19] <= din_19; din[29] <= din_29; 
        end
    end
    assign dout_0 = dout[0]; assign dout_10 = dout[10]; assign dout_20 = dout[20]; assign dout_30 = dout[30];
    assign dout_1 = dout[1]; assign dout_11 = dout[11]; assign dout_21 = dout[21]; assign dout_31 = dout[31];
    assign dout_2 = dout[2]; assign dout_12 = dout[12]; assign dout_22 = dout[22]; 
    assign dout_3 = dout[3]; assign dout_13 = dout[13]; assign dout_23 = dout[23]; 
    assign dout_4 = dout[4]; assign dout_14 = dout[14]; assign dout_24 = dout[24]; 
    assign dout_5 = dout[5]; assign dout_15 = dout[15]; assign dout_25 = dout[25]; 
    assign dout_6 = dout[6]; assign dout_16 = dout[16]; assign dout_26 = dout[26]; 
    assign dout_7 = dout[7]; assign dout_17 = dout[17]; assign dout_27 = dout[27]; 
    assign dout_8 = dout[8]; assign dout_18 = dout[18]; assign dout_28 = dout[28]; 
    assign dout_9 = dout[9]; assign dout_19 = dout[19]; assign dout_29 = dout[29]; 
    //判断有几个零
    reg [5:0] zeroCnt;
    always @(*)begin
        if(!rst_n)begin
            zeroCnt = 0;
        end else begin
            if(vld_in)begin
                zeroCnt = 0;
                if(din[0] == 32'b0)begin
                    zeroCnt = zeroCnt + 1;
                end
                if(din[1] == 32'b0)begin
                    zeroCnt = zeroCnt + 1;
                end
                if(din[2] == 32'b0)begin
                    zeroCnt = zeroCnt + 1;
                end
                if(din[3] == 32'b0)begin
                    zeroCnt = zeroCnt + 1;
                end
                if(din[4] == 32'b0)begin
                    zeroCnt = zeroCnt + 1;
                end
                if(din[5] == 32'b0)begin
                    zeroCnt = zeroCnt + 1;
                end
                if(din[6] == 32'b0)begin
                    zeroCnt = zeroCnt + 1;
                end
                if(din[7] == 32'b0)begin
                    zeroCnt = zeroCnt + 1;
                end
                if(din[8] == 32'b0)begin
                    zeroCnt = zeroCnt + 1;
                end
                if(din[9] == 32'b0)begin
                    zeroCnt = zeroCnt + 1;
                end
                if(din[10] == 32'b0)begin
                    zeroCnt = zeroCnt + 1;
                end
                if(din[11] == 32'b0)begin
                    zeroCnt = zeroCnt + 1;
                end
                if(din[12] == 32'b0)begin
                    zeroCnt = zeroCnt + 1;
                end
                if(din[13] == 32'b0)begin
                    zeroCnt = zeroCnt + 1;
                end
                if(din[14] == 32'b0)begin
                    zeroCnt = zeroCnt + 1;
                end
                if(din[15] == 32'b0)begin
                    zeroCnt = zeroCnt + 1;
                end
                if(din[16] == 32'b0)begin
                    zeroCnt = zeroCnt + 1;
                end
                if(din[17] == 32'b0)begin
                    zeroCnt = zeroCnt + 1;
                end
                if(din[18] == 32'b0)begin
                    zeroCnt = zeroCnt + 1;
                end
                if(din[19] == 32'b0)begin
                    zeroCnt = zeroCnt + 1;
                end
                if(din[20] == 32'b0)begin
                    zeroCnt = zeroCnt + 1;
                end
                if(din[21] == 32'b0)begin
                    zeroCnt = zeroCnt + 1;
                end
                if(din[22] == 32'b0)begin
                    zeroCnt = zeroCnt + 1;
                end
                if(din[23] == 32'b0)begin
                    zeroCnt = zeroCnt + 1;
                end
                if(din[24] == 32'b0)begin
                    zeroCnt = zeroCnt + 1;
                end
                if(din[25] == 32'b0)begin
                    zeroCnt = zeroCnt + 1;
                end
                if(din[26] == 32'b0)begin
                    zeroCnt = zeroCnt + 1;
                end
                if(din[27] == 32'b0)begin
                    zeroCnt = zeroCnt + 1;
                end
                if(din[28] == 32'b0)begin
                    zeroCnt = zeroCnt + 1;
                end
                if(din[29] == 32'b0)begin
                    zeroCnt = zeroCnt + 1;
                end
                if(din[30] == 32'b0)begin
                    zeroCnt = zeroCnt + 1;
                end
                if(din[31] == 32'b0)begin
                    zeroCnt = zeroCnt + 1;
                end
            end
        end
    end
    //并行全比较排序
    /*用于存储比较结果
    一共有
    */
    wire [31:0] compare [31:0];
    //比较是否结束
    reg [31:0] compare_end ;
    /*
     *每个输入数的权
     *一共要记录32个数，每个数最大的权是31
     *注意：若当前权与上一个相同，则后续所有权需要减一
     */
    reg [5:0] weighted [31:0];
    //记录相同大小的个数
    //reg [5:0] sameCnt [31:0];
    //开始拓展
    reg startExpand;
    //比较
    genvar i, j;
    generate for(i = 0; i < 32; i = i + 1)begin
        for(j = 0; j < 32; j = j + 1)begin
            if(i != j)begin
                assign compare[i][j] = din[i] >= din [j] ? 1'b1: 1'b0;
            end else begin
                assign compare[i][j] = 1'b0;
            end
        end
    end
    endgenerate
    genvar k, l;
    generate for(k = 0; k < 32; k = k + 1)begin
        always @(*)begin
            if(!startExpand)begin
                weighted[k] <= compare[k][0]  + compare[k][1]  + compare[k][2]  + compare[k][3]  + compare[k][4]
                            + compare[k][5]  + compare[k][6]  + compare[k][7]  + compare[k][8]  + compare[k][9]
                            + compare[k][10] + compare[k][11] + compare[k][12] + compare[k][13] + compare[k][14]
                            + compare[k][15] + compare[k][16] + compare[k][17] + compare[k][18] + compare[k][19]
                            + compare[k][20] + compare[k][21] + compare[k][22] + compare[k][23] + compare[k][24]
                            + compare[k][25] + compare[k][26] + compare[k][27] + compare[k][28] + compare[k][29]
                            + compare[k][30] + compare[k][31];
                compare_end[k] <= 0;
            end
        end
    end
    endgenerate
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            //compare_end <= 32'b1111_1111_1111_1111_1111_1111_1111_1111;//默认比较结束可以比较
            startExpand <= 0;
            dout[0] <= 0; dout[10] <= 0; dout[20] <= 0; dout[30] <= 0;
            dout[1] <= 0; dout[11] <= 0; dout[21] <= 0; dout[31] <= 0;
            dout[2] <= 0; dout[12] <= 0; dout[22] <= 0;
            dout[3] <= 0; dout[13] <= 0; dout[23] <= 0;
            dout[4] <= 0; dout[14] <= 0; dout[24] <= 0;
            dout[5] <= 0; dout[15] <= 0; dout[25] <= 0;
            dout[6] <= 0; dout[16] <= 0; dout[26] <= 0;
            dout[7] <= 0; dout[17] <= 0; dout[27] <= 0;
            dout[8] <= 0; dout[18] <= 0; dout[28] <= 0;
            dout[9] <= 0; dout[19] <= 0; dout[29] <= 0;
        end
        else begin
            if(0) begin
            end else begin
                dout[weighted[0]] <= din[0]; dout[weighted[10]] <= din[10]; dout[weighted[20]] <= din[20]; dout[weighted[30]] <= din[30];
                dout[weighted[1]] <= din[1]; dout[weighted[11]] <= din[11]; dout[weighted[21]] <= din[21]; dout[weighted[31]] <= din[31];
                dout[weighted[2]] <= din[2]; dout[weighted[12]] <= din[12]; dout[weighted[22]] <= din[22];
                dout[weighted[3]] <= din[3]; dout[weighted[13]] <= din[13]; dout[weighted[23]] <= din[23];
                dout[weighted[4]] <= din[4]; dout[weighted[14]] <= din[14]; dout[weighted[24]] <= din[24];
                dout[weighted[5]] <= din[5]; dout[weighted[15]] <= din[15]; dout[weighted[25]] <= din[25];
                dout[weighted[6]] <= din[6]; dout[weighted[16]] <= din[16]; dout[weighted[26]] <= din[26];
                dout[weighted[7]] <= din[7]; dout[weighted[17]] <= din[17]; dout[weighted[27]] <= din[27];
                dout[weighted[8]] <= din[8]; dout[weighted[18]] <= din[18]; dout[weighted[28]] <= din[28];
                dout[weighted[9]] <= din[9]; dout[weighted[19]] <= din[19]; dout[weighted[29]] <= din[29];
                if(!vld_out)begin
                    startExpand <= 1;
                end
            end
        end
    end
    //扩展次数
    reg [32:0] exTimes;
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n)begin
            exTimes <= 0;
        end else begin
            if(startExpand == 1)begin
                if(dout[30] == 0 && zeroCnt < 31)begin
                    dout[30] = dout[31];
                end
                if(dout[29] == 0 && zeroCnt < 30)begin
                    dout[29] = dout[30];
                end
                if(dout[28] == 0 && zeroCnt < 29)begin
                    dout[28] = dout[29];
                end
                if(dout[27] == 0 && zeroCnt < 28)begin
                    dout[27] = dout[28];
                end
                if(dout[26] == 0 && zeroCnt < 27)begin
                    dout[26] = dout[27];
                end
                if(dout[25] == 0 && zeroCnt < 26)begin
                    dout[25] = dout[26];
                end
                if(dout[24] == 0 && zeroCnt < 25)begin
                    dout[24] = dout[25];
                end
                if(dout[23] == 0 && zeroCnt < 24)begin
                    dout[23] = dout[24];
                end
                if(dout[22] == 0 && zeroCnt < 23)begin
                    dout[22] = dout[23];
                end
                if(dout[21] == 0 && zeroCnt < 22)begin
                    dout[21] = dout[22];
                end
                if(dout[20] == 0 && zeroCnt < 21)begin
                    dout[20] = dout[21];
                end
                if(dout[19] == 0 && zeroCnt < 20)begin
                    dout[19] = dout[20];
                end
                if(dout[18] == 0 && zeroCnt < 19)begin
                    dout[18] = dout[19];
                end
                if(dout[17] == 0 && zeroCnt < 18)begin
                    dout[17] = dout[18];
                end
                if(dout[16] == 0 && zeroCnt < 17)begin
                    dout[16] = dout[17];
                end
                if(dout[15] == 0 && zeroCnt < 16)begin
                    dout[15] = dout[16];
                end
                if(dout[14] == 0 && zeroCnt < 15)begin
                    dout[14] = dout[15];
                end
                if(dout[13] == 0 && zeroCnt < 14)begin
                    dout[13] = dout[14];
                end
                if(dout[12] == 0 && zeroCnt < 13)begin
                    dout[12] = dout[13];
                end
                if(dout[11] == 0 && zeroCnt < 12)begin
                    dout[11] = dout[12];
                end
                if(dout[10] == 0 && zeroCnt < 11)begin
                    dout[10] = dout[11];
                end
                if(dout[9] == 0 && zeroCnt < 10)begin
                    dout[9] = dout[10];
                end
                if(dout[8] == 0 && zeroCnt < 9)begin
                    dout[8] = dout[9];
                end
                if(dout[7] == 0 && zeroCnt < 8)begin
                    dout[7] = dout[8];
                end
                if(dout[6] == 0 && zeroCnt < 7)begin
                    dout[6] = dout[7];
                end
                if(dout[5] == 0 && zeroCnt < 6)begin
                    dout[5] = dout[6];
                end
                if(dout[4] == 0 && zeroCnt < 5)begin
                    dout[4] = dout[5];
                end
                if(dout[3] == 0 && zeroCnt < 4)begin
                    dout[3] = dout[4];
                end
                if(dout[2] == 0 && zeroCnt < 3)begin
                    dout[2] = dout[3];
                end
                if(dout[1] == 0 && zeroCnt < 2)begin
                    dout[1] = dout[2];
                end
                if(dout[0] == 0 && zeroCnt < 1)begin
                    dout[0] = dout[1];
                end
                exTimes <=  exTimes + 1;
                startExpand <= 0;
                vld_out <= 1;
                outState <= 1;
            end
        end
    end
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n)begin
            vld_out <= 0;
            outState <= 0;
        end else begin
            if(vld_out)begin
                outState <= 0;
                vld_out <= 0;
                dout[0] <= 0; dout[10] <= 0; dout[20] <= 0; dout[30] <= 0;
                dout[1] <= 0; dout[11] <= 0; dout[21] <= 0; dout[31] <= 0;
                dout[2] <= 0; dout[12] <= 0; dout[22] <= 0;
                dout[3] <= 0; dout[13] <= 0; dout[23] <= 0;
                dout[4] <= 0; dout[14] <= 0; dout[24] <= 0;
                dout[5] <= 0; dout[15] <= 0; dout[25] <= 0;
                dout[6] <= 0; dout[16] <= 0; dout[26] <= 0;
                dout[7] <= 0; dout[17] <= 0; dout[27] <= 0;
                dout[8] <= 0; dout[18] <= 0; dout[28] <= 0;
                dout[9] <= 0; dout[19] <= 0; dout[29] <= 0;
            end
        end
    end
endmodule