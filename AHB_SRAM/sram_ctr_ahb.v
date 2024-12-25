module sram_ctr_ahb (
        input   hclk,//系统时钟
        input   hresetn,//系统异步复位，低电平有效
        input   hwrite,//写有效
        input   [1:0]   htrans,//当前传输类型
        input   [2:0]   hsize,//当前传输大小
        input   [31:0]  haddr,//读写地址，地址控制总线
        input   [2:0]   hburst,//当前突发类型
        input   [31:0]  hwdata,//写数据总线
        output reg hready,//传输完成指示
        output reg [1:0] hresp,//传输响应
        output reg [31:0] hrdata,//读数据总线
        output reg sram_csn,//SRAM片选，低电平有效
        output reg sram_wen,//SRAM写使能，低电平有效
        output reg [11:0] sram_a,//SRAM读写地址
        output reg [31:0] sram_d,//SRAM写数据
        input [31:0] sram_q//SRAM读数据
    );
    //采样/读写寄存器,0采样，1读写
    reg State;
    //记录剩余的周期个数,最大32
    reg [5:0] tCnt;
    //第一个周期采样地址和驱动信号
    always @(posedge hclk or negedge hresetn) begin
        if(!hresetn) begin
            State <= 0;
            tCnt <= 0;
            //关断与SRAM的链接
            sram_csn <= 1;
            hready <= 0;
        end
        else begin
            if(!State) begin
                //htrans: 00-IDLE 01-BUSY 10-NONSEQ 11-SEQ
                //hresp: 00-OKAY 01-ERROR 10-RETRY 11-SPLIT
                case (htrans)
                    2'b00 :
                        hresp <= 2'b00;
                    2'b01 :
                        hresp <= 2'b00;
                    2'b10 : begin
                        //采样
                        sram_a <= haddr[11:0];//因为通过State控制，所以不冲突
                        case (hsize)
                            3'd0, 3'd1:
                                hresp <= 2'b01;//做不到一次传输8或16bit
                            3'd2: begin
                                State <= 1;//采样完毕转入读写
                                hresp <= 2'b00; //一次传输32bit
                                //片选
                                sram_csn <= 0;
                                //赋值读写状态
                                sram_wen <= hwrite;//1为写，0为读
                                //链接
                                sram_d <= hwdata;
                                hrdata <= sram_q;
                                //判断突发类型来给tCnt赋值
                                case (hburst)
                                    3'b001: begin//未指定长度的增量突发
                                        tCnt <= 32;
                                    end
                                    3'b010, 3'b011: begin//4拍回环/增量
                                        tCnt <= 4;
                                    end
                                    3'b100, 3'b101: begin//8拍回环/增量
                                        tCnt <= 8;
                                    end
                                    3'b110, 3'b111: begin//16拍回环/增量
                                        tCnt <= 16;
                                    end
                                    default:
                                        tCnt <= 1;
                                endcase
                            end
                            3'd3: begin
                                if(!hburst) begin
                                    //仅32bit支持突发
                                    //片选
                                    sram_csn <= 0;
                                    //赋值读写状态
                                    sram_wen <= hwrite;//1为写，0为读
                                    //链接
                                    sram_d <= hwdata;
                                    hrdata <= sram_q;
                                    State <= 1;//采样完毕转入读写
                                    hresp <= 2'b11;//一次传输64bit（要分2个周期）
                                    tCnt <= 2;
                                end
                                else begin
                                    hresp <= 2'b01;
                                end
                            end
                            3'd4: begin
                                if(!hburst) begin
                                    //仅32bit支持突发
                                    //片选
                                    sram_csn <= 0;
                                    //赋值读写状态
                                    sram_wen <= hwrite;//1为写，0为读
                                    //链接
                                    sram_d <= hwdata;
                                    hrdata <= sram_q;
                                    State <= 1;//采样完毕转入读写
                                    hresp <= 2'b11;//一次传输128bit（要分4个周期）
                                    tCnt <= 4;
                                end
                                else begin
                                    hresp <= 2'b01;
                                end
                            end
                            3'd5: begin
                                if(!hburst) begin
                                    //仅32bit支持突发
                                    //片选
                                    sram_csn <= 0;
                                    //赋值读写状态
                                    sram_wen <= hwrite;//1为写，0为读
                                    //链接
                                    sram_d <= hwdata;
                                    hrdata <= sram_q;
                                    State <= 1;//采样完毕转入读写
                                    hresp <= 2'b11;//一次传输256bit（要分8个周期）
                                    tCnt <= 8;
                                end
                                else begin
                                    hresp <= 2'b01;
                                end
                            end
                            3'd6: begin
                                if(!hburst) begin
                                    //仅32bit支持突发
                                    //片选
                                    sram_csn <= 0;
                                    //赋值读写状态
                                    sram_wen <= hwrite;//1为写，0为读
                                    //链接
                                    sram_d <= hwdata;
                                    hrdata <= sram_q;
                                    State <= 1;//采样完毕转入读写
                                    hresp <= 2'b11;//一次传输512bit（要分16个周期）
                                    tCnt <= 16;
                                end
                                else begin
                                    hresp <= 2'b01;
                                end
                            end
                            3'd7: begin
                                if(!hburst) begin
                                    //仅32bit支持突发
                                    //片选
                                    sram_csn <= 0;
                                    //赋值读写状态
                                    sram_wen <= hwrite;//1为写，0为读
                                    //链接
                                    sram_d <= hwdata;
                                    hrdata <= sram_q;
                                    State <= 1;//采样完毕转入读写
                                    hresp <= 2'b11;//一次传输1024bit（要分32个周期）
                                    tCnt <= 32;
                                end
                                else begin
                                    hresp <= 2'b01;
                                end
                            end
                            default: begin
                                hresp <= 2'b01;//发生错误
                            end
                        endcase
                    end
                    2'b11 :
                        hresp <= 2'b10;//todo: 未完成
                    default:
                        hresp <= 2'b01;
                endcase
            end
        end
    end

    //从第二个周期往后要传输数据
    always @(posedge hclk or negedge hresetn) begin
        if (!hresetn) begin
            hrdata <= 0;
        end
        else begin
            if(State) begin
                //hready为1时表明正在进行数据传输
                hready <= 1;
                //以下是分周期访问地址对应的SRAM的内容
                if(hburst == 3'b000 || hburst == 3'b001) begin
                    //非突发情况/未指定增量
                    if(tCnt != 0) begin
                        //继续循环
                        tCnt <= tCnt - 1;//减一次
                        if(sram_a != 12'hfff) begin
                            //没到头地址可以继续加
                            sram_a <= sram_a + 1'b1;
                        end
                        else begin
                            //到头了就归零
                            sram_a <= 12'b0;
                        end
                    end
                    else begin
                        hready <= 0;//传输完毕
                        State <= 0;
                    end
                end
                else begin
                    //突发情况
                    case (hburst)
                        3'b010: begin//4拍回环
                            hready <= 0;//todo
                        end
                        3'b011: begin//4拍增量
                            if(tCnt != 0) begin
                                //继续循环
                                tCnt <= tCnt - 1;//减一次
                                if(sram_a <= 12'hffb) begin
                                    //若地址有足够的剩余量可以继续加
                                    sram_a <= sram_a + 12'd4;
                                end
                                else begin
                                    //保证每两个数据的地址间距相同
                                    sram_a <=  12'd3 - (12'hfff - sram_a);
                                end
                            end
                            else begin
                                hready <= 0;//传输完毕
                                State <= 0;
                            end
                        end
                        3'b100: begin//8拍回环
                            hready <= 0;//todo
                            State <= 0;
                        end
                        3'b101: begin//8拍增量
                            if(tCnt != 0) begin
                                //继续循环
                                tCnt <= tCnt - 1;//减一次
                                if(sram_a <= 12'hff8) begin
                                    //若地址有足够的剩余量可以继续加
                                    sram_a <= sram_a + 12'd8;
                                end
                                else begin
                                    //保证每两个数据的地址间距相同
                                    sram_a <=  12'd7 - (12'hfff - sram_a);
                                end
                            end
                            else begin
                                hready <= 0;//传输完毕
                                State <= 0;
                            end
                        end
                        3'b110: begin//16拍回环
                            hready <= 0;//todo
                            State <= 0;
                        end
                        3'b111: begin//16拍增量
                            if(tCnt != 0) begin
                                //继续循环
                                tCnt <= tCnt - 1;//减一次
                                if(sram_a <= 12'hff0) begin
                                    //若地址有足够的剩余量可以继续加
                                    sram_a <= sram_a + 12'd16;
                                end
                                else begin
                                    //保证每两个数据的地址间距相同
                                    sram_a <= 12'd15 - (12'hfff - sram_a);
                                end
                            end
                            else begin
                                hready <= 0;//传输完毕
                                State <= 0;
                            end

                        end
                        default:begin
                            hready <= 0;//传输完毕
                            State <= 0;
                        end
                    endcase
                end
            end
        end
    end
endmodule //sram_ctr_ahb

//32位SRAM
module SRAM32(
        input           clk,
        input           rst_n,
        input           cs_n,   //片选信号
        input           w_en,   //写使能
        input           r_en,   //读使能
        input  [11:0]    addr,   //地址
        input  [31:0]    din,    //输入数据
        output [31:0]    dout    //输出数据
    );
    //输出寄存器
    reg [31:0] dout;
    //数据寄存器，可寄存16个数据
    reg [31:0] mem [4095:0];
    integer i;
    //写入
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            for (i = 0; i < 4096; i=i+1) begin
                mem[i] <= 10'b0;
            end
            dout <= 32'b0;
        end
        //写入
        else if (w_en == 1'b1 && cs_n == 1'b0) begin
            mem[addr] <= din;
        end
        //读出
        else if (r_en == 1'b1 && cs_n == 1'b0) begin
            dout <= mem[addr];
        end
        else begin
            dout <= dout;
        end
    end
endmodule
