module bsh_32(
        input        clk,
        input [31:0] data_in,
        input        dir,
        input [4:0]  sh,
        output[31:0]  data_out
    );
    //用来保证可以得到时序信息
    reg [31:0] data_out;
    reg [31:0] data0;
    always@(*)begin
        data0 = data_in;
    end
    wire [31:0] data1;
    assign data1 = sh[0]?
                        (dir?
                            {data0[0],data0[31:1]}:
                            {data0[30:0],data0[31]}):
                        data_in;
    wire [31:0] data2;
    assign data2 = sh[1]?
                        (dir?
                            {data1[1:0],data1[31:2]}:
                            {data1[29:0],data1[31:30]}):
                        data1;
    wire [31:0] data3;
    assign data3 = sh[2]?
                        (dir?
                            {data2[3:0],data2[31:4]}:
                            {data2[27:0],data2[31:28]}):
                        data2;
    wire [31:0] data4;
    assign data4 = sh[3]?
                        (dir?
                            {data3[7:0],data3[31:8]}:
                            {data3[23:0],data3[31:24]}):
                        data3;
    wire [31:0] data5;
    assign data5 = sh[4]?
                        (dir?
                            {data4[15:0],data4[31:16]}:
                            {data4[15:0],data4[31:16]}):
                        data4;
    always @(*) begin
        data_out = data5;
    end
endmodule
