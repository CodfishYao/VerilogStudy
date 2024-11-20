module hw2q3 (
        input  [7:0]    bin_in,
        output  reg [9:0]   bcd_out
    );
    reg [7:0] bin_reg;
    reg [9:0] bcd_reg;
    reg [7:0] bin_mid;
    reg [1:0] hunderds;
    reg [3:0] tens;
    //reg [3:0] units;
    parameter ten     = 8'b10100000;
    parameter hunderd = 8'b11001000;
    always @(*) begin
        bin_reg = bin_in;
        bin_mid = bin_reg;
        /*
        //个位
        if(bin_mid >= ten) begin
            bin_mid = bin_reg - ten;
        end
        if(bin_mid >= (ten>>1)) begin
            bin_mid = bin_mid - (ten>>1);
        end
        if(bin_mid >= (ten>>2)) begin
            bin_mid = bin_mid - (ten>>2);
        end
        if(bin_mid >= (ten>>3)) begin
            bin_mid = bin_mid - (ten>>3);
        end
        if(bin_mid >= (ten>>4)) begin
            bin_mid = bin_mid - (ten>>4);
        end
        units = bin_mid[3:0];
        */
        //百位
        //bin_mid = bin_reg - units;
        if(bin_mid >= hunderd) begin
            bin_mid = bin_mid - hunderd;
            hunderds[1] = 1'b1;
        end
        else begin
            hunderds[1] = 1'b0;
        end
        if(bin_mid >= (hunderd>>1)) begin
            bin_mid = bin_mid - (hunderd>>1);
            hunderds[0] = 1'b1;
        end
        else begin
            hunderds[0] = 1'b0;
        end
        //十位
        if(bin_mid >= (ten>>1)) begin
            bin_mid = bin_mid - (ten>>1);
            tens[3] = 1'b1;
        end
        else begin
            tens[3] = 1'b0;
        end
        if(bin_mid >= (ten>>2)) begin
            bin_mid = bin_mid - (ten>>2);
            tens[2] = 1'b1;
        end
        else begin
            tens[2] = 1'b0;
        end
        if(bin_mid >= (ten>>3)) begin
            bin_mid = bin_mid - (ten>>3);
            tens[1] = 1'b1;
        end
        else begin
            tens[1] = 1'b0;
        end
        if(bin_mid >= (ten>>4)) begin
            bin_mid = bin_mid - (ten>>4);
            tens[0] = 1'b1;
        end
        else begin
            tens[0] = 1'b0;
        end
        bcd_out = {hunderds,tens,bin_mid[3:0]};
    end
endmodule //hw2q3
