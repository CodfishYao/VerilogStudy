module mat_sacn(
        input           clk,
        input           rst_n,
        input           vld_in,
        input  [9:0]    din,
        output          vld_out,
        output [9:0]    dout
    );
    //地址寄存器
    reg [5:0] addr;
    //
    reg cs_n, w_en, r_en;
    //
    reg vld_out;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            addr <= 6'd63;//6'b0;
            cs_n <= 1'b1;
            w_en <= 1'b0;
            r_en <= 1'b0;
            vld_out <= 1'b0;
        end
        else if (vld_in) begin
            //逐个写入数据
            w_en <= 1'b1;
            cs_n <= 1'b0;
            addr <= addr + 1'b1;
            if(addr == 6'd63)begin
                r_en <= 1'b0;
            end
        end
        else begin
            vld_out <= 1'b1;
            r_en <= 1'b1;
            w_en <= 1'b0;
            //状态转换
            case (addr)
                6'd00 : addr <= 6'd01;
                6'd01 : addr <= 6'd08;
                6'd08 : addr <= 6'd16;
                6'd16 : addr <= 6'd09;
                6'd09 : addr <= 6'd02;
                6'd02 : addr <= 6'd03;
                6'd03 : addr <= 6'd10;
                6'd10 : addr <= 6'd17;
                6'd17 : addr <= 6'd24;
                6'd24 : addr <= 6'd32;
                6'd32 : addr <= 6'd25;
                6'd25 : addr <= 6'd18;
                6'd18 : addr <= 6'd11;
                6'd11 : addr <= 6'd04;
                6'd04 : addr <= 6'd05;
                6'd05 : addr <= 6'd12;
                6'd12 : addr <= 6'd19;
                6'd19 : addr <= 6'd26;
                6'd26 : addr <= 6'd33;
                6'd33 : addr <= 6'd40;
                6'd40 : addr <= 6'd48;
                6'd48 : addr <= 6'd41;
                6'd41 : addr <= 6'd34;
                6'd34 : addr <= 6'd27;
                6'd27 : addr <= 6'd20;
                6'd20 : addr <= 6'd13;
                6'd13 : addr <= 6'd06;
                6'd06 : addr <= 6'd07;
                6'd07 : addr <= 6'd14;
                6'd14 : addr <= 6'd21;
                6'd21 : addr <= 6'd28;
                6'd28 : addr <= 6'd35;
                6'd35 : addr <= 6'd42;
                6'd42 : addr <= 6'd49;
                6'd49 : addr <= 6'd56;
                6'd56 : addr <= 6'd57;
                6'd57 : addr <= 6'd50;
                6'd50 : addr <= 6'd43;
                6'd43 : addr <= 6'd36;
                6'd36 : addr <= 6'd29;
                6'd29 : addr <= 6'd22;
                6'd22 : addr <= 6'd15;
                6'd15 : addr <= 6'd23;
                6'd23 : addr <= 6'd30;
                6'd30 : addr <= 6'd37;
                6'd37 : addr <= 6'd44;
                6'd44 : addr <= 6'd51;
                6'd51 : addr <= 6'd58;
                6'd58 : addr <= 6'd59;
                6'd59 : addr <= 6'd52;
                6'd52 : addr <= 6'd45;
                6'd45 : addr <= 6'd38;
                6'd38 : addr <= 6'd31;
                6'd31 : addr <= 6'd39;
                6'd39 : addr <= 6'd46;
                6'd46 : addr <= 6'd53;
                6'd53 : addr <= 6'd60;
                6'd60 : addr <= 6'd61;
                6'd61 : addr <= 6'd54;
                6'd54 : addr <= 6'd47;
                6'd47 : addr <= 6'd55;
                6'd55 : addr <= 6'd62;
                6'd62 : addr <= 6'd63;
                6'd63 : addr <= 6'd00;
                default: addr <= 6'd0;
            endcase
        end
    end
    SRAM64 u_SRAM64(
        .clk   	( clk    ),
        .rst_n 	( rst_n  ),
        .cs_n  	( cs_n   ),
        .w_en  	( w_en   ),
        .r_en  	( r_en   ),
        .addr  	( addr   ),
        .din   	( din    ),
        .dout  	( dout   )
    );

    /*
    *
     *片选信号寄存器
     *片1：0001；片2：0010，片3：0100，片4：1000
     *
    reg [3:0] cs;
    wire [3:0] cs_n;
    assign cs_n = ~cs;
    //读写状态寄存器，1为读，0为写
    reg opState;
    assign r_en = opState;
    assign w_en = ~opState; 
    //利用MUX选择输出连那个SRAM
    reg  [9:0] dout;
    wire [9:0] dout_s [3:0];
    always @(*) begin
        case (cs)
            4'b0001: dout <= dout_s[0];
            4'b0010: dout <= dout_s[1];
            4'b0100: dout <= dout_s[2];
            4'b1000: dout <= dout_s[3];
            default: dout <= dout_s[0];
        endcase
    end
    // SRAM 的输出 wire
    genvar sramCnt;
    generate
        for(sramCnt = 0; sramCnt < 4; sramCnt = sramCnt + 1) begin
            SRAM u_SRAM(
                     .clk   	( clk           ),
                     .rst_n 	( rst_n         ),
                     .cs_n  	( cs_n[sramCnt] ),
                     .w_en  	( w_en          ),
                     .r_en  	( r_en          ),
                     .addr  	( addr          ),
                     .din   	( din           ),
                     .dout  	( dout_s[sramCnt])
                 );
        end
    endgenerate
    //输入输出计数器,用于确定输入还是输出
    reg [6:0] cnt;
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n)begin
            addr <= 4'b0;
            cs <= 4'b0001;
            opState <= 0;
            cnt <= 0;
        end else if(w_en & vld_in)begin
            //写
            //通过更改地址，每片读入数据
            if(addr < 15)begin
                addr <= addr + 1;
            end else begin
                addr <= 4'b0;
            end
            //将写状态改为读状态
            if(cnt < 63)begin
                //切换SRAM
                if(cnt == 15 || cnt == 31 || cnt == 47)begin
                    cs <= cs << 1;
                end
                cnt <= cnt + 1;
            end else begin
                cs <= 4'b0001;
                cnt <= 0;
                opState <= 1;
            end
        end else if(r_en)begin
            //读
            //SRAM1->2
            if(cnt == 3 || cnt == 8 || cnt == 17 || cnt == 30 || cnt == 43)begin
                cs <= cs << 1;
            end
            //SRAM2->1
            if(cnt == 4 || cnt == 13 || cnt == 26 || cnt == 42)begin
                cs <= cs >> 1;
            end
            //SRAM2->3
            if(cnt == 10 || cnt == 19 || cnt == 32 || cnt == 45 || cnt == 54)begin
                cs <= cs << 1;
            end
            //SRAM3->2
            if(cnt == 11 || cnt == 24 || cnt == 40 || cnt == 53)begin
                cs <= cs >> 1;
            end
            //SRAM3->4
            if(cnt == 21 || cnt == 34 || cnt == 47 || cnt == 56 || cnt == 61)begin
                cs <= cs << 1;
            end
            //SRAM4->3
            if(cnt == 22 || cnt == 38 || cnt == 51 || cnt == 60)begin
                cs <= cs >> 1;
            end
            //读出
            //cnt转换addr
            case (cnt)
                0, 3, 10, 21 : addr <= 4'b0000;//1
                1, 8, 19, 34 : addr <= 4'b0001;//2
                5, 12, 23, 37 : addr <= 4'b0010;//3
                6, 17, 32, 47 : addr <= 4'b0011;//4
                14, 25, 39, 50 : addr <= 4'b0100;//5
                15, 30, 46, 56 : addr <= 4'b0101;//6
                27, 41, 52, 59 : addr <= 4'b0110;//7
                28, 43, 54, 61 : addr <= 4'b0111;//8
                2, 9, 20, 35 : addr <= 4'b1000;//9
                4, 11, 22, 36 : addr <= 4'b1001;//10
                7, 18, 33, 48 : addr <= 4'b1010;//11
                13, 24, 38, 49 : addr <= 4'b1011;//12
                16, 31, 46, 57 : addr <= 4'b1100;//13
                26, 40, 51, 58 : addr <= 4'b1101;//14
                29, 44, 55, 62 : addr <= 4'b1110;//15
                42, 53, 60, 63 : addr <= 4'b1111;//16
                default: addr <= 4'b0000;
            endcase
            //将读状态改为写状态
            if(cnt < 63)begin
                cnt <= cnt + 1;
            end else begin
                cs <= 4'b0001;
                cnt <= 0;
                opState <= 0;
            end
        end
    end
    */
endmodule //mat_scan
//16位SRAM
module SRAM(
        input           clk,
        input           rst_n,
        input           cs_n,   //片选信号
        input           w_en,   //写使能
        input           r_en,   //读使能
        input  [3:0]    addr,   //地址
        input  [9:0]    din,    //输入数据
        output [9:0]    dout    //输出数据
    );
    //输出寄存器
    reg [9:0] dout;
    //数据寄存器，可寄存16个数据
    reg [9:0] mem [15:0];
    integer i;
    //写入
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            for (i = 0; i < 16; i=i+1) begin
                mem[i] <= 10'b0;
            end
            dout <= 10'b0;
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
//64位SRAM
module SRAM64(
        input           clk,
        input           rst_n,
        input           cs_n,   //片选信号
        input           w_en,   //写使能
        input           r_en,   //读使能
        input  [5:0]    addr,   //地址
        input  [9:0]    din,    //输入数据
        output [9:0]    dout    //输出数据
    );
    //输出寄存器
    reg [9:0] dout;
    //数据寄存器，可寄存16个数据
    reg [9:0] mem [63:0];
    integer i;
    //写入
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            for (i = 0; i < 64; i=i+1) begin
                mem[i] <= 10'b0;
            end
            dout <= 10'b0;
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

