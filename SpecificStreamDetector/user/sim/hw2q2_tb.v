`timescale 1ps/1ps
module hw2q2_tb();
    reg clk = 0;
    reg rst_n = 1;
    reg din_vld = 0;
    reg din = 0;
    wire result;
    hw2q2 u_hw2q2(
              .clk     	( clk      ),
              .rst_n   	( rst_n    ),
              .din_vld 	( din_vld  ),
              .din     	( din      ),
              .result  	( result   )
          );
    initial begin
        clk = 0;
        rst_n = 0;
        din_vld = 0;
        din = 0;
        //din:0 0 1 1 1 0 0 0 1 1 0 1 1 1 0 0 0 0
        #10
         din = 0;
         din_vld = 1;
        #20
         din = 0;
        #20
         din = 1;
        #20
         din = 1;
        #20
         din = 1;
        #20
         din = 0;
        #20
         din = 0;
        #20
         din = 0;
        #20
         din = 1;
        #20
         din = 1;
        #20
         din = 0;
        #20
         din = 1;
        #20
         din = 1;
        #20
         din = 1;
        #20
         din = 0;
        #20
         din = 0;
        #20
         din = 0;
        #20
         din = 0;
    end
    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, hw2q2_tb);
        #400 $finish;
    end/*
    always@(*) begin
        #10 clk <=~clk;
    end*/
endmodule
