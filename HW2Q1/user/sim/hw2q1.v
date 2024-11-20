module hw2q1(
    input  [31:0] data_in,
    output [5:0] pos_out
);
reg [31:0] data_in_reg;
reg [5:0] pos_out;
reg [5:0] pos;
always @(*) begin
    data_in_reg = data_in;
    casex(data_in_reg)
        32'b1xxxxxxx_xxxxxxxx_xxxxxxxx_xxxxxxxx:pos = 6'd0;
        32'b01xxxxxx_xxxxxxxx_xxxxxxxx_xxxxxxxx:pos = 6'd1;
        32'b001xxxxx_xxxxxxxx_xxxxxxxx_xxxxxxxx:pos = 6'd2;
        32'b0001xxxx_xxxxxxxx_xxxxxxxx_xxxxxxxx:pos = 6'd3;
        32'b00001xxx_xxxxxxxx_xxxxxxxx_xxxxxxxx:pos = 6'd4;
        32'b000001xx_xxxxxxxx_xxxxxxxx_xxxxxxxx:pos = 6'd5;
        32'b0000001x_xxxxxxxx_xxxxxxxx_xxxxxxxx:pos = 6'd6;
        32'b00000001_xxxxxxxx_xxxxxxxx_xxxxxxxx:pos = 6'd7;
        32'b00000000_1xxxxxxx_xxxxxxxx_xxxxxxxx:pos = 6'd8;
        32'b00000000_01xxxxxx_xxxxxxxx_xxxxxxxx:pos = 6'd9;
        32'b00000000_001xxxxx_xxxxxxxx_xxxxxxxx:pos = 6'd10;
        32'b00000000_0001xxxx_xxxxxxxx_xxxxxxxx:pos = 6'd11;
        32'b00000000_00001xxx_xxxxxxxx_xxxxxxxx:pos = 6'd12;
        32'b00000000_000001xx_xxxxxxxx_xxxxxxxx:pos = 6'd13;
        32'b00000000_0000001x_xxxxxxxx_xxxxxxxx:pos = 6'd14;
        32'b00000000_00000001_xxxxxxxx_xxxxxxxx:pos = 6'd15;
        32'b00000000_00000000_1xxxxxxx_xxxxxxxx:pos = 6'd16;
        32'b00000000_00000000_01xxxxxx_xxxxxxxx:pos = 6'd17;
        32'b00000000_00000000_001xxxxx_xxxxxxxx:pos = 6'd18;
        32'b00000000_00000000_0001xxxx_xxxxxxxx:pos = 6'd19;
        32'b00000000_00000000_00001xxx_xxxxxxxx:pos = 6'd20;
        32'b00000000_00000000_000001xx_xxxxxxxx:pos = 6'd21;
        32'b00000000_00000000_0000001x_xxxxxxxx:pos = 6'd22;
        32'b00000000_00000000_00000001_xxxxxxxx:pos = 6'd23;
        32'b00000000_00000000_00000000_1xxxxxxx:pos = 6'd24;
        32'b00000000_00000000_00000000_01xxxxxx:pos = 6'd25;
        32'b00000000_00000000_00000000_001xxxxx:pos = 6'd26;
        32'b00000000_00000000_00000000_0001xxxx:pos = 6'd27;
        32'b00000000_00000000_00000000_00001xxx:pos = 6'd28;
        32'b00000000_00000000_00000000_000001xx:pos = 6'd29;
        32'b00000000_00000000_00000000_0000001x:pos = 6'd30;
        32'b00000000_00000000_00000000_00000001:pos = 6'd31;
        default: pos = 6'd32;
    endcase
    pos_out = pos;
    
end

endmodule