module mul_tc_16_16_tb();
    // inports regs
    reg [15:0] a,b;
    //reg clk = 1;
    // outports wire
    wire [31:0] 	product;
    mul_tc_16_16 u_mul_tc_16_16(
                     //.clk       ( clk      ),
                     .a       	( a        ),
                     .b       	( b        ),
                     .product 	( product  )
                 );
    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, mul_tc_16_16_tb);
        #200 $finish;
    end
    integer seed1 = 1;
    integer seed2 = 2;
    //每10ns产生一个随机数
    initial begin
        a = 16'b1011101010000110;
        b = 16'b0111100101001101;
        repeat(10) begin
            #10
            a = $random(seed1)%16'b1111_1111_1111_1111;
            b = $random(seed2)%16'b1111_1111_1111_1111;
        end
        #5 $finish;
    end

endmodule
