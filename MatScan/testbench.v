`timescale 1ps/1ps
module mat_scan_tb();
    // inports regs
    reg clk, rst_n, vld_in;
    reg [9:0] din;
    //reg clk = 1;
    // outports wire
    // outports wire
    wire       	vld_out;
    wire [9:0] 	dout;

    mat_sacn u_mat_sacn(
        .clk     	( clk      ),
        .rst_n   	( rst_n    ),
        .vld_in  	( vld_in   ),
        .din     	( din      ),
        .vld_out 	( vld_out  ),
        .dout    	( dout     )
    );
    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, mat_scan_tb);
        #4000 $finish;
    end
    
    initial begin
        clk <= 1'b0;
        rst_n <= 1'b0;
        din <= 10'b00_0000_0000;
        vld_in <= 1'b0;
        #20
        rst_n <= 1'b1;
        vld_in <= 1'b1;
        #1290
        vld_in <= 1'b0;
    end

    always #10 clk <= ~clk;

    always @(posedge clk) begin
        if (vld_in == 1'b1) begin
           din <= din + 1'b1;
        end
    end

endmodule