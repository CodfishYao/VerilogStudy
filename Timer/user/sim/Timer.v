module stop_watch(
        input Clk,
        input rst_n,
        input Clear,
        input start_stop,
        output reg [3:0] hr_h,
        output reg [3:0] hr_l,
        output reg [3:0] min_h,
        output reg [3:0] min_l,
        output reg [3:0] sec_h,
        output reg [3:0] sec_l
    );
    /*1MHz即1秒有100_0000个时钟，
    故应该每1000_0000个时钟，
    增加1秒
    */
    //用于判断是否此时应该增加一秒
    parameter addSec = 100;//正常应该1000_0000
    reg [19:0] addSecCnt;
    //用于按钮消抖计时
    parameter passShake = 1;//正常应该10_0000
    reg [13:0] passSShakeCnt;
    reg [13:0] passCShakeCnt;
    //是否要开始按钮按下后的计时
    //00-未操作 01-开始按下 11-按下 10-抬起
    reg[1:0] sBtnFlag, cBtnFlag;
    //存储按钮状态
    reg sBtn_1, sBtn_2;
    reg cBtn_1, cBtn_2;
    //用于判断当前是正在计时还是暂停计时,1为停止，0为继续
    reg isPaused = 1'b0;
    //用于判断是否清零
    reg isClear = 1'b0;
    //用于存储十进制的时间
    reg [5:0] sec, min;
    reg [6:0] hr;
    //更新寄存器中按钮状态
    always @(posedge Clk or negedge rst_n) begin
        if(!rst_n) begin
            sBtn_1 <= 1'b0;
            sBtn_2 <= 1'b0;
            cBtn_1 <= 1'b0;
            cBtn_2 <= 1'b0;
        end
        else begin
            sBtn_1 <= start_stop;
            sBtn_2 <= sBtn_1;
            cBtn_1 <= Clear;
            cBtn_2 <= cBtn_1;
            //start_stop按钮状态
            case(sBtnFlag)
                2'b00: begin
                    if(sBtn_1 != sBtn_2) begin
                        sBtnFlag <= 2'b01;
                    end
                end
                2'b01: begin
                    passSShakeCnt <= passSShakeCnt + 1'b1;
                    if(passShake == passSShakeCnt) begin
                        passSShakeCnt <= 14'b0;
                        if(sBtn_1==1) begin
                            isPaused <= ~isPaused;
                            sBtnFlag <= 2'b11;
                        end
                        else begin
                            sBtnFlag <= 2'b00;
                        end
                    end
                end
                2'b11: begin
                    if(sBtn_1 == 0) begin
                        sBtnFlag <= 2'b10;
                    end
                end
                2'b10: begin
                    passSShakeCnt <= passCShakeCnt + 1'b1;
                    if(passShake == passSShakeCnt) begin
                        passSShakeCnt <= 14'b0;
                        if(sBtn_1==0) begin
                            sBtnFlag <= 2'b00;
                        end
                        else begin
                            sBtnFlag <= 2'b11;
                        end
                    end
                end
                default:
                    sBtnFlag <= 2'b00;
            endcase
            //对于Clear按钮，状态
            case(cBtnFlag)
                2'b00: begin
                    if(cBtn_1 != cBtn_2) begin
                        cBtnFlag <= 2'b01;
                    end
                end
                2'b01: begin
                    passCShakeCnt <= passCShakeCnt + 1'b1;
                    if(passShake == passCShakeCnt) begin
                        passCShakeCnt <= 14'b0;
                        if(cBtn_1==1) begin
                            isClear <= 1'b1;//清零
                            isPaused <= 1'b1;//停止计时
                            cBtnFlag <= 2'b11;
                        end
                        else begin
                            cBtnFlag <= 2'b00;
                        end
                    end
                end
                2'b11: begin
                    if(cBtn_1 == 0) begin
                        cBtnFlag <= 2'b10;
                    end
                end
                2'b10: begin
                    passCShakeCnt <= passCShakeCnt + 1'b1;
                    if(passShake == passCShakeCnt) begin
                        passCShakeCnt <= 14'b0;
                        if(cBtn_1==0) begin
                            isClear <= 1'b0;
                            cBtnFlag <= 2'b00;
                        end
                        else begin
                            cBtnFlag <= 2'b11;
                        end
                    end
                end
                default:
                    sBtnFlag <= 2'b00;
            endcase
        end
    end
    //该always块用于计时
    always @(posedge Clk or negedge rst_n) begin
        if(!rst_n) begin//是否复位
            addSecCnt <= 20'b0;
            hr <= 7'b0;
            min <= 6'b0;
            sec <= 6'b0;
        end
        else begin
            //是否被清零
            if(isClear) begin
                addSecCnt <= 20'b0;
                hr <= 7'b0;
                min <= 6'b0;
                sec <= 6'b0;
            end
            else begin
                //如果没有被清零是否处于暂停状态
                if(!isPaused) begin
                    //没暂停的话每个时钟周期计数+1
                    addSecCnt <= addSecCnt + 1;
                    if(addSec == addSecCnt) begin
                        addSecCnt <= 20'b0;
                        if(sec != 6'b11_1011) begin
                            //秒不到59则加一
                            sec <= sec + 1'b1;
                        end
                        else begin
                            //秒到59秒则秒清零，判断分钟是否到59分
                            sec<= 6'b0;
                            if(min != 6'b11_1011) begin
                                //min不到59分钟加1
                                min <= min + 1'b1;
                            end
                            else begin
                                //min到了59分则分钟清零，判断小时是否到99
                                min<= 6'b0;
                                if(hr != 7'b110_0011) begin
                                    //hr不到99加一
                                    hr <= hr + 1'b1;
                                end
                                else begin
                                    //hr到了99清零
                                    hr<= 7'b0;
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    wire [3:0] hr_hw;
    wire [3:0] hr_lw;
    toBCD u_toBCD_hr(
              .bin_in        	( hr ),
              .bcd_out_tens  	( hr_hw ),
              .bcd_out_units 	( hr_lw )
          );
    wire [3:0] min_hw;
    wire [3:0] min_lw;
    toBCD u_toBCD_min(
              .bin_in        	( min ),
              .bcd_out_tens  	( min_hw ),
              .bcd_out_units 	( min_lw )
          );
    wire [3:0] sec_hw;
    wire [3:0] sec_lw;
    toBCD u_toBCD_sec(
              .bin_in        	( sec ),
              .bcd_out_tens  	( sec_hw ),
              .bcd_out_units 	( sec_lw )
          );
    always @(*) begin
        hr_h <= hr_hw;
        hr_l <= hr_lw;
        min_h <= min_hw;
        min_l <= min_lw;
        sec_h <= sec_hw;
        sec_l <= sec_lw;
    end
endmodule
//
module toBCD (
        input  [6:0]    bin_in,
        output  reg [3:0]   bcd_out_tens,
        output  reg [3:0]   bcd_out_units
    );
    reg [6:0] bin_reg;
    reg [7:0] bcd_reg;
    reg [6:0] bin_mid;
    reg [3:0] tens;
    //reg [3:0] units;
    parameter ten     = 7'b1010000;
    always @(*) begin
        bin_reg = bin_in;
        bin_mid = bin_reg;
        //十位
        if(bin_mid >= (ten)) begin
            bin_mid = bin_mid - (ten);
            tens[3] = 1'b1;
        end
        else begin
            tens[3] = 1'b0;
        end
        if(bin_mid >= (ten>>1)) begin
            bin_mid = bin_mid - (ten>>1);
            tens[2] = 1'b1;
        end
        else begin
            tens[2] = 1'b0;
        end
        if(bin_mid >= (ten>>2)) begin
            bin_mid = bin_mid - (ten>>2);
            tens[1] = 1'b1;
        end
        else begin
            tens[1] = 1'b0;
        end
        if(bin_mid >= (ten>>3)) begin
            bin_mid = bin_mid - (ten>>3);
            tens[0] = 1'b1;
        end
        else begin
            tens[0] = 1'b0;
        end
        bcd_out_tens = tens;
        bcd_out_units = bin_mid[3:0];
    end
endmodule //hw2q3
