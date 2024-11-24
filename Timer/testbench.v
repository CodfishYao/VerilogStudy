`timescale 1ps/1ps
module testbench();

    parameter MAIN_FRE       = 100;
    reg       sys_clk        = 0;
    reg       sys_rst        = 0;
    reg       btn_clear      = 0;
    reg       btn_start_stop = 0;

    always begin
        #(100/MAIN_FRE) sys_clk = ~sys_clk;
    end

    always begin
        #5 sys_rst = 1;
    end
    initial begin
        btn_clear = 0;
        #1001 btn_clear = 1;
        #1500 btn_clear = 0;
        #2001 btn_start_stop = 1;
        #2500 btn_start_stop = 0;
        #3011 btn_start_stop = 1;
        #3500 btn_start_stop = 0;
        #4011 btn_start_stop = 1;
        #4500 btn_start_stop = 0;
    end
    //Instance
    // outports wire
    wire [3:0] 	hr_h;
    wire [3:0] 	hr_l;
    wire [3:0] 	min_h;
    wire [3:0] 	min_l;
    wire [3:0] 	sec_h;
    wire [3:0] 	sec_l;
    stop_watch u_stop_watch(
              .Clk        	( sys_clk         ),
              .rst_n      	( sys_rst         ),
              .Clear      	( btn_clear       ),
              .start_stop 	( btn_start_stop  ),
              .hr_h       	( hr_h        ),
              .hr_l       	( hr_l        ),
              .min_h      	( min_h       ),
              .min_l      	( min_l       ),
              .sec_h      	( sec_h       ),
              .sec_l      	( sec_l       )
          );



    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, testbench);
        #1000000 $finish;
    end

endmodule  //TOP
