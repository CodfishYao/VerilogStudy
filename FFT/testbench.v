`timescale 1ps/1ps
module fft_256_tb();
    //inports reg
    reg clk;
    reg rst_n;
    reg inv;
    reg stb;
    reg sop_in;
    reg [15:0] x_re;
    reg [15:0] x_im;
    // outports wire
    wire        	valid_out;
    wire        	sop_out;
    wire [15:0] 	y_re;
    wire [15:0] 	y_im;
    //fft_256
    fft_256 #(
                .NUMBER_OF_TIMES_IN  	( 9'b011111110  ),
                .NUMBER_OF_TIMES_OUT 	( 9'b100000000  ))
            u_fft_256(
                .clk       	( clk        ),
                .rst_n     	( rst_n      ),
                .inv       	( inv        ),
                .stb       	( stb        ),
                .sop_in    	( sop_in     ),
                .x_re      	( x_re       ),
                .x_im      	( x_im       ),
                .valid_out 	( valid_out  ),
                .sop_out   	( sop_out    ),
                .y_re      	( y_re       ),
                .y_im      	( y_im       )
            );
    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, fft_256_tb);
        #40000 $finish;
    end
    initial begin
        clk <= 1'b0;
        rst_n <= 1'b0;
        inv <= 1'b0;
        stb <= 1'b1;
        sop_in <= 1'b0;
        x_re <= 0;
        x_im <= 0;
        #10
        rst_n <= 1'b1;
        stb <= 1'b0;
    end
    always #10 clk <= ~clk;
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin

        end
        else begin
            if(x_re < 256 && x_re != 0) begin
                x_re = x_re + 1;
                x_im = x_im + 1;
                sop_in = 0;
            end
            else begin
                x_re = 1;
                x_im = 1;
                sop_in = 1;
            end
        end
    end
endmodule
