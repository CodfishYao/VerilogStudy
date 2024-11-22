module mul_tc_16_16(
        input [15:0] a,
        input [15:0] b,
        output[31:0] product
    );

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
