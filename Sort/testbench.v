`timescale 1ps/1ps
module sort_32_u8_tb;
    reg clk, rst_n, vld_in;
    reg  [7:0] din_0, din_1, din_2, din_3, din_4;
    reg  [7:0] din_5, din_6, din_7, din_8, din_9;
    reg  [7:0] din_10, din_11, din_12, din_13, din_14;
    reg  [7:0] din_15, din_16, din_17, din_18, din_19;
    reg  [7:0] din_20, din_21, din_22, din_23, din_24;
    reg  [7:0] din_25, din_26, din_27, din_28, din_29;
    reg  [7:0] din_30, din_31;
    // outports wire
    wire       	vld_out;
    wire [7:0] 	dout_0;
    wire [7:0] 	dout_1;
    wire [7:0] 	dout_2;
    wire [7:0] 	dout_3;
    wire [7:0] 	dout_4;
    wire [7:0] 	dout_5;
    wire [7:0] 	dout_6;
    wire [7:0] 	dout_7;
    wire [7:0] 	dout_8;
    wire [7:0] 	dout_9;
    wire [7:0] 	dout_10;
    wire [7:0] 	dout_11;
    wire [7:0] 	dout_12;
    wire [7:0] 	dout_13;
    wire [7:0] 	dout_14;
    wire [7:0] 	dout_15;
    wire [7:0] 	dout_16;
    wire [7:0] 	dout_17;
    wire [7:0] 	dout_18;
    wire [7:0] 	dout_19;
    wire [7:0] 	dout_20;
    wire [7:0] 	dout_21;
    wire [7:0] 	dout_22;
    wire [7:0] 	dout_23;
    wire [7:0] 	dout_24;
    wire [7:0] 	dout_25;
    wire [7:0] 	dout_26;
    wire [7:0] 	dout_27;
    wire [7:0] 	dout_28;
    wire [7:0] 	dout_29;
    wire [7:0] 	dout_30;
    wire [7:0] 	dout_31;

    sort_32_u8 u_sort_32_u8(
                   .clk     	( clk      ),
                   .rst_n   	( rst_n    ),
                   .vld_in  	( vld_in   ),
                   .din_0   	( din_0    ),
                   .din_1   	( din_1    ),
                   .din_2   	( din_2    ),
                   .din_3   	( din_3    ),
                   .din_4   	( din_4    ),
                   .din_5   	( din_5    ),
                   .din_6   	( din_6    ),
                   .din_7   	( din_7    ),
                   .din_8   	( din_8    ),
                   .din_9   	( din_9    ),
                   .din_10  	( din_10   ),
                   .din_11  	( din_11   ),
                   .din_12  	( din_12   ),
                   .din_13  	( din_13   ),
                   .din_14  	( din_14   ),
                   .din_15  	( din_15   ),
                   .din_16  	( din_16   ),
                   .din_17  	( din_17   ),
                   .din_18  	( din_18   ),
                   .din_19  	( din_19   ),
                   .din_20  	( din_20   ),
                   .din_21  	( din_21   ),
                   .din_22  	( din_22   ),
                   .din_23  	( din_23   ),
                   .din_24  	( din_24   ),
                   .din_25  	( din_25   ),
                   .din_26  	( din_26   ),
                   .din_27  	( din_27   ),
                   .din_28  	( din_28   ),
                   .din_29  	( din_29   ),
                   .din_30  	( din_30   ),
                   .din_31  	( din_31   ),
                   .vld_out 	( vld_out  ),
                   .dout_0  	( dout_0   ),
                   .dout_1  	( dout_1   ),
                   .dout_2  	( dout_2   ),
                   .dout_3  	( dout_3   ),
                   .dout_4  	( dout_4   ),
                   .dout_5  	( dout_5   ),
                   .dout_6  	( dout_6   ),
                   .dout_7  	( dout_7   ),
                   .dout_8  	( dout_8   ),
                   .dout_9  	( dout_9   ),
                   .dout_10 	( dout_10  ),
                   .dout_11 	( dout_11  ),
                   .dout_12 	( dout_12  ),
                   .dout_13 	( dout_13  ),
                   .dout_14 	( dout_14  ),
                   .dout_15 	( dout_15  ),
                   .dout_16 	( dout_16  ),
                   .dout_17 	( dout_17  ),
                   .dout_18 	( dout_18  ),
                   .dout_19 	( dout_19  ),
                   .dout_20 	( dout_20  ),
                   .dout_21 	( dout_21  ),
                   .dout_22 	( dout_22  ),
                   .dout_23 	( dout_23  ),
                   .dout_24 	( dout_24  ),
                   .dout_25 	( dout_25  ),
                   .dout_26 	( dout_26  ),
                   .dout_27 	( dout_27  ),
                   .dout_28 	( dout_28  ),
                   .dout_29 	( dout_29  ),
                   .dout_30 	( dout_30  ),
                   .dout_31 	( dout_31  )
               );

    always begin
        #10 clk = ~clk;
    end
    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, sort_32_u8_tb);
        #10000 $finish;
    end
    initial begin
        clk = 1'b0;
        rst_n = 1'b0;
        vld_in = 1'b1;
        din_0 = 31; din_10 = 11; din_20 = 4; din_30 = 20;
        din_1 = 29; din_11 = 9; din_21 = 4; din_31 = 30;
        din_2 = 27; din_12 = 7; din_22 = 8;
        din_3 = 25; din_13 = 5; din_23 = 16;
        din_4 = 23; din_14 = 3; din_24 = 8;
        din_5 = 21; din_15 = 1; din_25 = 16;
        din_6 = 19; din_16 = 2; din_26 = 32;
        din_7 = 17; din_17 = 2; din_27 = 32;
        din_8 = 15; din_18 = 4; din_28 = 0;
        din_9 = 13; din_19 = 4; din_29 = 10;
        #10 rst_n = 1'b1;
        #50
        din_0 = 12; din_10 = 10; din_20 = 4; din_30 = 0;
        din_1 = 29; din_11 = 9; din_21 = 4; din_31 = 21;
        din_2 = 27; din_12 = 7; din_22 = 0;
        din_3 = 0; din_13 = 5; din_23 = 16;
        din_4 = 23; din_14 = 9; din_24 = 7;
        din_5 = 21; din_15 = 5; din_25 = 16;
        din_6 = 19; din_16 = 3; din_26 = 32;
        din_7 = 1; din_17 = 2; din_27 = 32;
        din_8 = 15; din_18 = 4; din_28 = 0;
        din_9 = 13; din_19 = 4; din_29 = 8;
        #120
        din_0 = 0; din_10 = 0; din_20 = 0; din_30 = 0;
        din_1 = 0; din_11 = 0; din_21 = 0; din_31 = 0;
        din_2 = 0; din_12 = 0; din_22 = 0;
        din_3 = 0; din_13 = 0; din_23 = 0;
        din_4 = 0; din_14 = 0; din_24 = 7;
        din_5 = 0; din_15 = 0; din_25 = 0;
        din_6 = 0; din_16 = 0; din_26 = 0;
        din_7 = 0; din_17 = 0; din_27 = 0;
        din_8 = 0; din_18 = 0; din_28 = 0;
        din_9 = 0; din_19 = 0; din_29 = 0;
        #120
        din_0 = 10; din_10 = 10; din_20 = 10; din_30 = 10;
        din_1 = 10; din_11 = 10; din_21 = 10; din_31 = 10;
        din_2 = 10; din_12 = 10; din_22 = 10;
        din_3 = 10; din_13 = 10; din_23 = 10;
        din_4 = 10; din_14 = 10; din_24 = 10;
        din_5 = 10; din_15 = 10; din_25 = 10;
        din_6 = 10; din_16 = 10; din_26 = 10;
        din_7 = 10; din_17 = 10; din_27 = 10;
        din_8 = 10; din_18 = 10; din_28 = 10;
        din_9 = 10; din_19 = 10; din_29 = 10;
    end
endmodule
