`timescale 1ns/1ns
module hw2q1_tb;
    reg [31:0] data_in;
    wire [5:0] pos_out;
    integer i;
    hw2q1 u1(.data_in(data_in),.pos_out(pos_out));
    initial begin
        $dumpfile("waveout.vcd");
        $dumpvars(0, hw2q1_tb);
    end
    initial begin
         data_in = 32'b10000000_00000000_00000000_00000000;
         for(i = 0;i<32;i=i+1)
         begin
            #10
             data_in = data_in>>1;
         end
        #10 $finish;
    end
endmodule
