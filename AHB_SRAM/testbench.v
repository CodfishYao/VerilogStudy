`timescale 1ps/1ps
module sram_ctr_ahb_tb();
    //inports reg
    reg hclk, hresetn, hwrite;
    reg [1:0] htrans;
    reg [2:0] hsize;
    reg [31:0] haddr;
    reg [2:0] hburst;
    reg [31:0] hwdata;

    // outports wire
    wire        	hready;
    wire [1:0]  	hresp;
    wire [31:0] 	hrdata;
    wire        	sram_csn;
    wire        	sram_wen;
    wire [11:0] 	sram_a;
    wire [31:0] 	sram_d;

    sram_ctr_ahb u_sram_ctr_ahb(
                     .hclk     	( hclk      ),
                     .hresetn  	( hresetn   ),
                     .hwrite   	( hwrite    ),
                     .htrans   	( htrans    ),
                     .hsize    	( hsize     ),
                     .haddr    	( haddr     ),
                     .hburst   	( hburst    ),
                     .hwdata   	( hwdata    ),
                     .hready   	( hready    ),
                     .hresp    	( hresp     ),
                     .hrdata   	( hrdata    ),
                     .sram_csn 	( sram_csn  ),
                     .sram_wen 	( sram_wen  ),
                     .sram_a   	( sram_a    ),
                     .sram_d   	( sram_d    ),
                     .sram_q   	( sram_q    )
                 );

    wire [31:0] sram_q;

    SRAM32 u_SRAM32(
               .clk   	( hclk    ),
               .rst_n 	( hresetn  ),
               .cs_n  	( sram_csn   ),
               .w_en  	( sram_wen   ),
               .r_en  	( !sram_wen   ),
               .addr  	( sram_a   ),
               .din   	( sram_d    ),
               .dout  	( sram_q   )
           );

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, sram_ctr_ahb_tb);
        #2000 $finish;
    end

    always #10 hclk <= ~hclk;
    reg [31:0] i;
    initial begin
        hclk <= 1'b0;
        hresetn <= 1'b0;
        hwrite <= 1'b1;
        htrans <= 2'b00;
        hsize <= 3'd2;
        haddr <= 32'b0;
        hburst <= 3'b0;
        hwdata <= 32'b0;
        #10
         hresetn <= 1'b1;
        htrans <= 2'b10;
        #980
         haddr <= 32'b0;
        hwrite <= 1'b0;
    end
    always @(negedge hready) begin
        haddr <= haddr + 1;
        hwdata <= hwdata + 1;
    end

endmodule //sram_ctr_ahb_tb
