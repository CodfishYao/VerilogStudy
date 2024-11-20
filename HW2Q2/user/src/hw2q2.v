module hw2q2(
        input clk,rst_n,din_vld,din,
        output result
    );
    reg result;
    reg [7:0] seq;
    parameter  destSeq = 12'b111000_101110;
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            if(din_vld) begin
                seq[0] = din;
                seq = seq << 1;
            end
            if(((!(seq[7:2] ^ destSeq[11:6]))||(!(seq[7:2] ^ destSeq[5:0])))&&din_vld) begin
                result <= 1;
            end
            else begin
                result <= 0;
            end
        end
        else begin
            seq <= 8'b00000000;
            result <= 0;
        end
    end
endmodule
