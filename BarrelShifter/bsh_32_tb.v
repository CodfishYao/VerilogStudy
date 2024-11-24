`timescale 1ns/1ns
module bsh_32_tb();
    //inports wires
    reg [31:0] data_in;
    reg dir;
    reg [4:0] sh;

    // outports wire
    wire [31:0] 	data_out;
    bsh_32 u_bsh_32(
               .clk         ( clk       ),
               .data_in  	( data_in   ),
               .dir      	( dir       ),
               .sh       	( sh        ),
               .data_out 	( data_out  )
           );
    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, bsh_32_tb);
        #120 $finish;
    end
    reg clk = 0;
    always begin
        #10
        clk = ~clk;
    end
    integer seed1 = 1;
    integer seed2 = 2;
    //每10ns产生一个随机数
    initial begin
        data_in = 32'b0;
        dir = 0;
        sh = 0;
        repeat(10) begin
            #10
             dir = ~dir;
            data_in = $random(seed1);
            sh = $random(seed2)%33;
        end
        #10 $finish;
    end
endmodule
