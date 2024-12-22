module sqrt_u32_tb();
    // inports regs
    reg clk;
    reg rst_n;
    reg vld_in;
    reg [31:0] x;
    // outports wire
    wire vld_out;
    wire [15:0] y;
    sqrt_u32 u_sqrt_u32(
                 .clk     	( clk      ),
                 .rst_n   	( rst_n    ),
                 .vld_in  	( vld_in   ),
                 .x       	( x        ),
                 .vld_out 	( vld_out  ),
                 .y       	( y        )
             );
    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, sqrt_u32_tb);
        #1000 $finish;
    end
    always begin
        #10 clk = ~clk;
    end
    initial begin
        clk = 0;
        rst_n = 0;
        #10 rst_n = 1;
        #10
        vld_in = 1;
        x = 32'd2147483648;
        #200
        vld_in = 0;
        #10
        vld_in = 1;
        x = 32'd4294967295;
    end

endmodule
