module sqrt_u32(
        input clk,
        input rst_n,
        input vld_in,
        input [31:0] x,
        output vld_out,
        output [15:0] y
    );
    //存储被开方数
    reg [31:0] x1;
    //存储开方的结果
    reg [15:0] sqrt;
    //存储迭代的次数
    reg [4:0] iter;
    //输出结果有效寄存器
    reg vld_out;
    assign y = sqrt;
    always@(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            iter = 16;
            sqrt = 0;
            vld_out = 0;
            x1 = x;
        end
        else begin
            //输入有效
            if(vld_in == 1) begin
                //还没迭代完
                if(iter > 0) begin
                    if(iter == 16) begin
                        x1 = x;
                        sqrt = {1'b1,15'b0};
                    end
                    vld_out = 0;
                    //
                    sqrt[iter-1] = 1;
                    //如果当前求出的值比x大，则不保留
                    if(sqrt*sqrt > x1) begin
                        sqrt[iter] = 0;
                    end
                    //迭代次数减一
                    iter = iter - 1;
                end
                else begin
                    //如果当前求出的值比x大，则不保留
                    if(sqrt*sqrt > x1) begin
                        sqrt[0] = 0;
                    end
                    //迭代完毕
                    iter = 16;
                    vld_out = 1;
                    x1 = x;
                end
            end else begin
                //输入无效
            end
        end
    end
endmodule
