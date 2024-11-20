`timescale 1ns/1ns
module hw2q3_tb;
    reg [7:0] bin_in;
    wire [9:0] bcd_out;
    hw2q3   u3(.bin_in(bin_in),.bcd_out(bcd_out));//模块名可换
    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, hw2q3_tb);	// tb的模块名
    end
    initial begin
         bin_in = 8'b11111111;
        #10
         bin_in = 8'b11001000;
        #10
         bin_in = 8'b11000111;
        #10
         bin_in = 8'b01100101;
        #10
         bin_in = 8'b01100011;
        #10
         bin_in = 8'b00000001;
        #10
         bin_in = 8'b00000000;

        #100 $finish;
    end

endmodule
