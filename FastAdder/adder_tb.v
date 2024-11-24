`timescale 1ns/1ns
module adder_tb();
    // outports wire
    wire [32:0] 	Sum;
    add_tc_16_16 u_add_tc_16_16(
                     .clk   ( clk  ),
                     .A   	( A    ),
                     .B   	( B    ),
                     .Sum 	( Sum  )
                 );
    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, adder_tb);
        #200 $finish;
    end
    reg clk = 0;
    always begin
        #50 clk = ~clk;
    end
    reg [31:0] A;
    reg [31:0] B;
    integer seed1 = 1;
    integer seed2 = 2;
    //每100ns产生一个随机数
    initial begin
        A = 0;
        B = 0;
        repeat(10) begin
            #100
             A = $random(seed1);
            B = $random(seed2);
        end
        #5 $finish;
    end

endmodule
