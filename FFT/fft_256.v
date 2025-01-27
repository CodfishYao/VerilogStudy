//参考文献/参考电子文档详见工程说明文件
module fft_256 (
    //256点FFT顶层模块
    input clk,//系统时钟
    input rst_n,//复位，低有效
    input inv,//0-FFT，1-IFFT
    input stb,//输入有效，低有效
    input sop_in,//每组（256个数）的第一个有效输入数据指示
    input [15:0] x_re,//输入数据实部
    input [15:0] x_im,//输入数据虚部
    output valid_out,//输出有效，低有效
    output sop_out,//每组（256个数）的第一个有效输出数据指示
    output [15:0] y_re,//输出数据实部
    output [15:0] y_im//输出数据虚部
);
    //根据公式，256点的FFT将分为8层
    //输入
    wire signed [15:0] x_re_mat [8:0] [255:0];
    wire signed [15:0] x_im_mat [8:0] [255:0];
    //缓冲，以便于并行运行
    //输入
    reg signed [15:0] x_re_buf [255:0];
    reg signed [15:0] x_im_buf [255:0];
    //输出
    reg signed [15:0] y_re_buf [255:0];
    reg signed [15:0] y_im_buf [255:0];
    // enable control
    wire [8:0] en_ctrl;
    //par
    parameter NUMBER_OF_TIMES_IN = 9'b011111110;
    parameter NUMBER_OF_TIMES_OUT = 9'b100000000;
    //自然序输入倒位序输出，使得顺序与预期一致
    //实部
	assign x_re_mat[0][0] =  x_re_buf[0];
	assign x_re_mat[0][1] =  x_re_buf[128];
	assign x_re_mat[0][2] =  x_re_buf[64];
	assign x_re_mat[0][3] =  x_re_buf[192];
	assign x_re_mat[0][4] =  x_re_buf[32];
	assign x_re_mat[0][5] =  x_re_buf[160];
	assign x_re_mat[0][6] =  x_re_buf[96];
	assign x_re_mat[0][7] =  x_re_buf[224];
	assign x_re_mat[0][8] =  x_re_buf[16];
	assign x_re_mat[0][9] =  x_re_buf[144];
	assign x_re_mat[0][10] =  x_re_buf[80];
	assign x_re_mat[0][11] =  x_re_buf[208];
	assign x_re_mat[0][12] =  x_re_buf[48];
	assign x_re_mat[0][13] =  x_re_buf[176];
	assign x_re_mat[0][14] =  x_re_buf[112];
	assign x_re_mat[0][15] =  x_re_buf[240];
	assign x_re_mat[0][16] =  x_re_buf[8];
	assign x_re_mat[0][17] =  x_re_buf[136];
	assign x_re_mat[0][18] =  x_re_buf[72];
	assign x_re_mat[0][19] =  x_re_buf[200];
	assign x_re_mat[0][20] =  x_re_buf[40];
	assign x_re_mat[0][21] =  x_re_buf[168];
	assign x_re_mat[0][22] =  x_re_buf[104];
	assign x_re_mat[0][23] =  x_re_buf[232];
	assign x_re_mat[0][24] =  x_re_buf[24];
	assign x_re_mat[0][25] =  x_re_buf[152];
	assign x_re_mat[0][26] =  x_re_buf[88];
	assign x_re_mat[0][27] =  x_re_buf[216];
	assign x_re_mat[0][28] =  x_re_buf[56];
	assign x_re_mat[0][29] =  x_re_buf[184];
	assign x_re_mat[0][30] =  x_re_buf[120];
	assign x_re_mat[0][31] =  x_re_buf[248];
	assign x_re_mat[0][32] =  x_re_buf[4];
	assign x_re_mat[0][33] =  x_re_buf[132];
	assign x_re_mat[0][34] =  x_re_buf[68];
	assign x_re_mat[0][35] =  x_re_buf[196];
	assign x_re_mat[0][36] =  x_re_buf[36];
	assign x_re_mat[0][37] =  x_re_buf[164];
	assign x_re_mat[0][38] =  x_re_buf[100];
	assign x_re_mat[0][39] =  x_re_buf[228];
	assign x_re_mat[0][40] =  x_re_buf[20];
	assign x_re_mat[0][41] =  x_re_buf[148];
	assign x_re_mat[0][42] =  x_re_buf[84];
	assign x_re_mat[0][43] =  x_re_buf[212];
	assign x_re_mat[0][44] =  x_re_buf[52];
	assign x_re_mat[0][45] =  x_re_buf[180];
	assign x_re_mat[0][46] =  x_re_buf[116];
	assign x_re_mat[0][47] =  x_re_buf[244];
	assign x_re_mat[0][48] =  x_re_buf[12];
	assign x_re_mat[0][49] =  x_re_buf[140];
	assign x_re_mat[0][50] =  x_re_buf[76];
	assign x_re_mat[0][51] =  x_re_buf[204];
	assign x_re_mat[0][52] =  x_re_buf[44];
	assign x_re_mat[0][53] =  x_re_buf[172];
	assign x_re_mat[0][54] =  x_re_buf[108];
	assign x_re_mat[0][55] =  x_re_buf[236];
	assign x_re_mat[0][56] =  x_re_buf[28];
	assign x_re_mat[0][57] =  x_re_buf[156];
	assign x_re_mat[0][58] =  x_re_buf[92];
	assign x_re_mat[0][59] =  x_re_buf[220];
	assign x_re_mat[0][60] =  x_re_buf[60];
	assign x_re_mat[0][61] =  x_re_buf[188];
	assign x_re_mat[0][62] =  x_re_buf[124];
	assign x_re_mat[0][63] =  x_re_buf[252];
	assign x_re_mat[0][64] =  x_re_buf[2];
	assign x_re_mat[0][65] =  x_re_buf[130];
	assign x_re_mat[0][66] =  x_re_buf[66];
	assign x_re_mat[0][67] =  x_re_buf[194];
	assign x_re_mat[0][68] =  x_re_buf[34];
	assign x_re_mat[0][69] =  x_re_buf[162];
	assign x_re_mat[0][70] =  x_re_buf[98];
	assign x_re_mat[0][71] =  x_re_buf[226];
	assign x_re_mat[0][72] =  x_re_buf[18];
	assign x_re_mat[0][73] =  x_re_buf[146];
	assign x_re_mat[0][74] =  x_re_buf[82];
	assign x_re_mat[0][75] =  x_re_buf[210];
	assign x_re_mat[0][76] =  x_re_buf[50];
	assign x_re_mat[0][77] =  x_re_buf[178];
	assign x_re_mat[0][78] =  x_re_buf[114];
	assign x_re_mat[0][79] =  x_re_buf[242];
	assign x_re_mat[0][80] =  x_re_buf[10];
	assign x_re_mat[0][81] =  x_re_buf[138];
	assign x_re_mat[0][82] =  x_re_buf[74];
	assign x_re_mat[0][83] =  x_re_buf[202];
	assign x_re_mat[0][84] =  x_re_buf[42];
	assign x_re_mat[0][85] =  x_re_buf[170];
	assign x_re_mat[0][86] =  x_re_buf[106];
	assign x_re_mat[0][87] =  x_re_buf[234];
	assign x_re_mat[0][88] =  x_re_buf[26];
	assign x_re_mat[0][89] =  x_re_buf[154];
	assign x_re_mat[0][90] =  x_re_buf[90];
	assign x_re_mat[0][91] =  x_re_buf[218];
	assign x_re_mat[0][92] =  x_re_buf[58];
	assign x_re_mat[0][93] =  x_re_buf[186];
	assign x_re_mat[0][94] =  x_re_buf[122];
	assign x_re_mat[0][95] =  x_re_buf[250];
	assign x_re_mat[0][96] =  x_re_buf[6];
	assign x_re_mat[0][97] =  x_re_buf[134];
	assign x_re_mat[0][98] =  x_re_buf[70];
	assign x_re_mat[0][99] =  x_re_buf[198];
	assign x_re_mat[0][100] =  x_re_buf[38];
	assign x_re_mat[0][101] =  x_re_buf[166];
	assign x_re_mat[0][102] =  x_re_buf[102];
	assign x_re_mat[0][103] =  x_re_buf[230];
	assign x_re_mat[0][104] =  x_re_buf[22];
	assign x_re_mat[0][105] =  x_re_buf[150];
	assign x_re_mat[0][106] =  x_re_buf[86];
	assign x_re_mat[0][107] =  x_re_buf[214];
	assign x_re_mat[0][108] =  x_re_buf[54];
	assign x_re_mat[0][109] =  x_re_buf[182];
	assign x_re_mat[0][110] =  x_re_buf[118];
	assign x_re_mat[0][111] =  x_re_buf[246];
	assign x_re_mat[0][112] =  x_re_buf[14];
	assign x_re_mat[0][113] =  x_re_buf[142];
	assign x_re_mat[0][114] =  x_re_buf[78];
	assign x_re_mat[0][115] =  x_re_buf[206];
	assign x_re_mat[0][116] =  x_re_buf[46];
	assign x_re_mat[0][117] =  x_re_buf[174];
	assign x_re_mat[0][118] =  x_re_buf[110];
	assign x_re_mat[0][119] =  x_re_buf[238];
	assign x_re_mat[0][120] =  x_re_buf[30];
	assign x_re_mat[0][121] =  x_re_buf[158];
	assign x_re_mat[0][122] =  x_re_buf[94];
	assign x_re_mat[0][123] =  x_re_buf[222];
	assign x_re_mat[0][124] =  x_re_buf[62];
	assign x_re_mat[0][125] =  x_re_buf[190];
	assign x_re_mat[0][126] =  x_re_buf[126];
	assign x_re_mat[0][127] =  x_re_buf[254];
	assign x_re_mat[0][128] =  x_re_buf[1];
	assign x_re_mat[0][129] =  x_re_buf[129];
	assign x_re_mat[0][130] =  x_re_buf[65];
	assign x_re_mat[0][131] =  x_re_buf[193];
	assign x_re_mat[0][132] =  x_re_buf[33];
	assign x_re_mat[0][133] =  x_re_buf[161];
	assign x_re_mat[0][134] =  x_re_buf[97];
	assign x_re_mat[0][135] =  x_re_buf[225];
	assign x_re_mat[0][136] =  x_re_buf[17];
	assign x_re_mat[0][137] =  x_re_buf[145];
	assign x_re_mat[0][138] =  x_re_buf[81];
	assign x_re_mat[0][139] =  x_re_buf[209];
	assign x_re_mat[0][140] =  x_re_buf[49];
	assign x_re_mat[0][141] =  x_re_buf[177];
	assign x_re_mat[0][142] =  x_re_buf[113];
	assign x_re_mat[0][143] =  x_re_buf[241];
	assign x_re_mat[0][144] =  x_re_buf[9];
	assign x_re_mat[0][145] =  x_re_buf[137];
	assign x_re_mat[0][146] =  x_re_buf[73];
	assign x_re_mat[0][147] =  x_re_buf[201];
	assign x_re_mat[0][148] =  x_re_buf[41];
	assign x_re_mat[0][149] =  x_re_buf[169];
	assign x_re_mat[0][150] =  x_re_buf[105];
	assign x_re_mat[0][151] =  x_re_buf[233];
	assign x_re_mat[0][152] =  x_re_buf[25];
	assign x_re_mat[0][153] =  x_re_buf[153];
	assign x_re_mat[0][154] =  x_re_buf[89];
	assign x_re_mat[0][155] =  x_re_buf[217];
	assign x_re_mat[0][156] =  x_re_buf[57];
	assign x_re_mat[0][157] =  x_re_buf[185];
	assign x_re_mat[0][158] =  x_re_buf[121];
	assign x_re_mat[0][159] =  x_re_buf[249];
	assign x_re_mat[0][160] =  x_re_buf[5];
	assign x_re_mat[0][161] =  x_re_buf[133];
	assign x_re_mat[0][162] =  x_re_buf[69];
	assign x_re_mat[0][163] =  x_re_buf[197];
	assign x_re_mat[0][164] =  x_re_buf[37];
	assign x_re_mat[0][165] =  x_re_buf[165];
	assign x_re_mat[0][166] =  x_re_buf[101];
	assign x_re_mat[0][167] =  x_re_buf[229];
	assign x_re_mat[0][168] =  x_re_buf[21];
	assign x_re_mat[0][169] =  x_re_buf[149];
	assign x_re_mat[0][170] =  x_re_buf[85];
	assign x_re_mat[0][171] =  x_re_buf[213];
	assign x_re_mat[0][172] =  x_re_buf[53];
	assign x_re_mat[0][173] =  x_re_buf[181];
	assign x_re_mat[0][174] =  x_re_buf[117];
	assign x_re_mat[0][175] =  x_re_buf[245];
	assign x_re_mat[0][176] =  x_re_buf[13];
	assign x_re_mat[0][177] =  x_re_buf[141];
	assign x_re_mat[0][178] =  x_re_buf[77];
	assign x_re_mat[0][179] =  x_re_buf[205];
	assign x_re_mat[0][180] =  x_re_buf[45];
	assign x_re_mat[0][181] =  x_re_buf[173];
	assign x_re_mat[0][182] =  x_re_buf[109];
	assign x_re_mat[0][183] =  x_re_buf[237];
	assign x_re_mat[0][184] =  x_re_buf[29];
	assign x_re_mat[0][185] =  x_re_buf[157];
	assign x_re_mat[0][186] =  x_re_buf[93];
	assign x_re_mat[0][187] =  x_re_buf[221];
	assign x_re_mat[0][188] =  x_re_buf[61];
	assign x_re_mat[0][189] =  x_re_buf[189];
	assign x_re_mat[0][190] =  x_re_buf[125];
	assign x_re_mat[0][191] =  x_re_buf[253];
	assign x_re_mat[0][192] =  x_re_buf[3];
	assign x_re_mat[0][193] =  x_re_buf[131];
	assign x_re_mat[0][194] =  x_re_buf[67];
	assign x_re_mat[0][195] =  x_re_buf[195];
	assign x_re_mat[0][196] =  x_re_buf[35];
	assign x_re_mat[0][197] =  x_re_buf[163];
	assign x_re_mat[0][198] =  x_re_buf[99];
	assign x_re_mat[0][199] =  x_re_buf[227];
	assign x_re_mat[0][200] =  x_re_buf[19];
	assign x_re_mat[0][201] =  x_re_buf[147];
	assign x_re_mat[0][202] =  x_re_buf[83];
	assign x_re_mat[0][203] =  x_re_buf[211];
	assign x_re_mat[0][204] =  x_re_buf[51];
	assign x_re_mat[0][205] =  x_re_buf[179];
	assign x_re_mat[0][206] =  x_re_buf[115];
	assign x_re_mat[0][207] =  x_re_buf[243];
	assign x_re_mat[0][208] =  x_re_buf[11];
	assign x_re_mat[0][209] =  x_re_buf[139];
	assign x_re_mat[0][210] =  x_re_buf[75];
	assign x_re_mat[0][211] =  x_re_buf[203];
	assign x_re_mat[0][212] =  x_re_buf[43];
	assign x_re_mat[0][213] =  x_re_buf[171];
	assign x_re_mat[0][214] =  x_re_buf[107];
	assign x_re_mat[0][215] =  x_re_buf[235];
	assign x_re_mat[0][216] =  x_re_buf[27];
	assign x_re_mat[0][217] =  x_re_buf[155];
	assign x_re_mat[0][218] =  x_re_buf[91];
	assign x_re_mat[0][219] =  x_re_buf[219];
	assign x_re_mat[0][220] =  x_re_buf[59];
	assign x_re_mat[0][221] =  x_re_buf[187];
	assign x_re_mat[0][222] =  x_re_buf[123];
	assign x_re_mat[0][223] =  x_re_buf[251];
	assign x_re_mat[0][224] =  x_re_buf[7];
	assign x_re_mat[0][225] =  x_re_buf[135];
	assign x_re_mat[0][226] =  x_re_buf[71];
	assign x_re_mat[0][227] =  x_re_buf[199];
	assign x_re_mat[0][228] =  x_re_buf[39];
	assign x_re_mat[0][229] =  x_re_buf[167];
	assign x_re_mat[0][230] =  x_re_buf[103];
	assign x_re_mat[0][231] =  x_re_buf[231];
	assign x_re_mat[0][232] =  x_re_buf[23];
	assign x_re_mat[0][233] =  x_re_buf[151];
	assign x_re_mat[0][234] =  x_re_buf[87];
	assign x_re_mat[0][235] =  x_re_buf[215];
	assign x_re_mat[0][236] =  x_re_buf[55];
	assign x_re_mat[0][237] =  x_re_buf[183];
	assign x_re_mat[0][238] =  x_re_buf[119];
	assign x_re_mat[0][239] =  x_re_buf[247];
	assign x_re_mat[0][240] =  x_re_buf[15];
	assign x_re_mat[0][241] =  x_re_buf[143];
	assign x_re_mat[0][242] =  x_re_buf[79];
	assign x_re_mat[0][243] =  x_re_buf[207];
	assign x_re_mat[0][244] =  x_re_buf[47];
	assign x_re_mat[0][245] =  x_re_buf[175];
	assign x_re_mat[0][246] =  x_re_buf[111];
	assign x_re_mat[0][247] =  x_re_buf[239];
	assign x_re_mat[0][248] =  x_re_buf[31];
	assign x_re_mat[0][249] =  x_re_buf[159];
	assign x_re_mat[0][250] =  x_re_buf[95];
	assign x_re_mat[0][251] =  x_re_buf[223];
	assign x_re_mat[0][252] =  x_re_buf[63];
	assign x_re_mat[0][253] =  x_re_buf[191];
	assign x_re_mat[0][254] =  x_re_buf[127];
	assign x_re_mat[0][255] =  x_re_buf[255];
	//虚部
	assign x_im_mat[0][0] =  x_im_buf[0];
	assign x_im_mat[0][1] =  x_im_buf[128];
	assign x_im_mat[0][2] =  x_im_buf[64];
	assign x_im_mat[0][3] =  x_im_buf[192];
	assign x_im_mat[0][4] =  x_im_buf[32];
	assign x_im_mat[0][5] =  x_im_buf[160];
	assign x_im_mat[0][6] =  x_im_buf[96];
	assign x_im_mat[0][7] =  x_im_buf[224];
	assign x_im_mat[0][8] =  x_im_buf[16];
	assign x_im_mat[0][9] =  x_im_buf[144];
	assign x_im_mat[0][10] =  x_im_buf[80];
	assign x_im_mat[0][11] =  x_im_buf[208];
	assign x_im_mat[0][12] =  x_im_buf[48];
	assign x_im_mat[0][13] =  x_im_buf[176];
	assign x_im_mat[0][14] =  x_im_buf[112];
	assign x_im_mat[0][15] =  x_im_buf[240];
	assign x_im_mat[0][16] =  x_im_buf[8];
	assign x_im_mat[0][17] =  x_im_buf[136];
	assign x_im_mat[0][18] =  x_im_buf[72];
	assign x_im_mat[0][19] =  x_im_buf[200];
	assign x_im_mat[0][20] =  x_im_buf[40];
	assign x_im_mat[0][21] =  x_im_buf[168];
	assign x_im_mat[0][22] =  x_im_buf[104];
	assign x_im_mat[0][23] =  x_im_buf[232];
	assign x_im_mat[0][24] =  x_im_buf[24];
	assign x_im_mat[0][25] =  x_im_buf[152];
	assign x_im_mat[0][26] =  x_im_buf[88];
	assign x_im_mat[0][27] =  x_im_buf[216];
	assign x_im_mat[0][28] =  x_im_buf[56];
	assign x_im_mat[0][29] =  x_im_buf[184];
	assign x_im_mat[0][30] =  x_im_buf[120];
	assign x_im_mat[0][31] =  x_im_buf[248];
	assign x_im_mat[0][32] =  x_im_buf[4];
	assign x_im_mat[0][33] =  x_im_buf[132];
	assign x_im_mat[0][34] =  x_im_buf[68];
	assign x_im_mat[0][35] =  x_im_buf[196];
	assign x_im_mat[0][36] =  x_im_buf[36];
	assign x_im_mat[0][37] =  x_im_buf[164];
	assign x_im_mat[0][38] =  x_im_buf[100];
	assign x_im_mat[0][39] =  x_im_buf[228];
	assign x_im_mat[0][40] =  x_im_buf[20];
	assign x_im_mat[0][41] =  x_im_buf[148];
	assign x_im_mat[0][42] =  x_im_buf[84];
	assign x_im_mat[0][43] =  x_im_buf[212];
	assign x_im_mat[0][44] =  x_im_buf[52];
	assign x_im_mat[0][45] =  x_im_buf[180];
	assign x_im_mat[0][46] =  x_im_buf[116];
	assign x_im_mat[0][47] =  x_im_buf[244];
	assign x_im_mat[0][48] =  x_im_buf[12];
	assign x_im_mat[0][49] =  x_im_buf[140];
	assign x_im_mat[0][50] =  x_im_buf[76];
	assign x_im_mat[0][51] =  x_im_buf[204];
	assign x_im_mat[0][52] =  x_im_buf[44];
	assign x_im_mat[0][53] =  x_im_buf[172];
	assign x_im_mat[0][54] =  x_im_buf[108];
	assign x_im_mat[0][55] =  x_im_buf[236];
	assign x_im_mat[0][56] =  x_im_buf[28];
	assign x_im_mat[0][57] =  x_im_buf[156];
	assign x_im_mat[0][58] =  x_im_buf[92];
	assign x_im_mat[0][59] =  x_im_buf[220];
	assign x_im_mat[0][60] =  x_im_buf[60];
	assign x_im_mat[0][61] =  x_im_buf[188];
	assign x_im_mat[0][62] =  x_im_buf[124];
	assign x_im_mat[0][63] =  x_im_buf[252];
	assign x_im_mat[0][64] =  x_im_buf[2];
	assign x_im_mat[0][65] =  x_im_buf[130];
	assign x_im_mat[0][66] =  x_im_buf[66];
	assign x_im_mat[0][67] =  x_im_buf[194];
	assign x_im_mat[0][68] =  x_im_buf[34];
	assign x_im_mat[0][69] =  x_im_buf[162];
	assign x_im_mat[0][70] =  x_im_buf[98];
	assign x_im_mat[0][71] =  x_im_buf[226];
	assign x_im_mat[0][72] =  x_im_buf[18];
	assign x_im_mat[0][73] =  x_im_buf[146];
	assign x_im_mat[0][74] =  x_im_buf[82];
	assign x_im_mat[0][75] =  x_im_buf[210];
	assign x_im_mat[0][76] =  x_im_buf[50];
	assign x_im_mat[0][77] =  x_im_buf[178];
	assign x_im_mat[0][78] =  x_im_buf[114];
	assign x_im_mat[0][79] =  x_im_buf[242];
	assign x_im_mat[0][80] =  x_im_buf[10];
	assign x_im_mat[0][81] =  x_im_buf[138];
	assign x_im_mat[0][82] =  x_im_buf[74];
	assign x_im_mat[0][83] =  x_im_buf[202];
	assign x_im_mat[0][84] =  x_im_buf[42];
	assign x_im_mat[0][85] =  x_im_buf[170];
	assign x_im_mat[0][86] =  x_im_buf[106];
	assign x_im_mat[0][87] =  x_im_buf[234];
	assign x_im_mat[0][88] =  x_im_buf[26];
	assign x_im_mat[0][89] =  x_im_buf[154];
	assign x_im_mat[0][90] =  x_im_buf[90];
	assign x_im_mat[0][91] =  x_im_buf[218];
	assign x_im_mat[0][92] =  x_im_buf[58];
	assign x_im_mat[0][93] =  x_im_buf[186];
	assign x_im_mat[0][94] =  x_im_buf[122];
	assign x_im_mat[0][95] =  x_im_buf[250];
	assign x_im_mat[0][96] =  x_im_buf[6];
	assign x_im_mat[0][97] =  x_im_buf[134];
	assign x_im_mat[0][98] =  x_im_buf[70];
	assign x_im_mat[0][99] =  x_im_buf[198];
	assign x_im_mat[0][100] =  x_im_buf[38];
	assign x_im_mat[0][101] =  x_im_buf[166];
	assign x_im_mat[0][102] =  x_im_buf[102];
	assign x_im_mat[0][103] =  x_im_buf[230];
	assign x_im_mat[0][104] =  x_im_buf[22];
	assign x_im_mat[0][105] =  x_im_buf[150];
	assign x_im_mat[0][106] =  x_im_buf[86];
	assign x_im_mat[0][107] =  x_im_buf[214];
	assign x_im_mat[0][108] =  x_im_buf[54];
	assign x_im_mat[0][109] =  x_im_buf[182];
	assign x_im_mat[0][110] =  x_im_buf[118];
	assign x_im_mat[0][111] =  x_im_buf[246];
	assign x_im_mat[0][112] =  x_im_buf[14];
	assign x_im_mat[0][113] =  x_im_buf[142];
	assign x_im_mat[0][114] =  x_im_buf[78];
	assign x_im_mat[0][115] =  x_im_buf[206];
	assign x_im_mat[0][116] =  x_im_buf[46];
	assign x_im_mat[0][117] =  x_im_buf[174];
	assign x_im_mat[0][118] =  x_im_buf[110];
	assign x_im_mat[0][119] =  x_im_buf[238];
	assign x_im_mat[0][120] =  x_im_buf[30];
	assign x_im_mat[0][121] =  x_im_buf[158];
	assign x_im_mat[0][122] =  x_im_buf[94];
	assign x_im_mat[0][123] =  x_im_buf[222];
	assign x_im_mat[0][124] =  x_im_buf[62];
	assign x_im_mat[0][125] =  x_im_buf[190];
	assign x_im_mat[0][126] =  x_im_buf[126];
	assign x_im_mat[0][127] =  x_im_buf[254];
	assign x_im_mat[0][128] =  x_im_buf[1];
	assign x_im_mat[0][129] =  x_im_buf[129];
	assign x_im_mat[0][130] =  x_im_buf[65];
	assign x_im_mat[0][131] =  x_im_buf[193];
	assign x_im_mat[0][132] =  x_im_buf[33];
	assign x_im_mat[0][133] =  x_im_buf[161];
	assign x_im_mat[0][134] =  x_im_buf[97];
	assign x_im_mat[0][135] =  x_im_buf[225];
	assign x_im_mat[0][136] =  x_im_buf[17];
	assign x_im_mat[0][137] =  x_im_buf[145];
	assign x_im_mat[0][138] =  x_im_buf[81];
	assign x_im_mat[0][139] =  x_im_buf[209];
	assign x_im_mat[0][140] =  x_im_buf[49];
	assign x_im_mat[0][141] =  x_im_buf[177];
	assign x_im_mat[0][142] =  x_im_buf[113];
	assign x_im_mat[0][143] =  x_im_buf[241];
	assign x_im_mat[0][144] =  x_im_buf[9];
	assign x_im_mat[0][145] =  x_im_buf[137];
	assign x_im_mat[0][146] =  x_im_buf[73];
	assign x_im_mat[0][147] =  x_im_buf[201];
	assign x_im_mat[0][148] =  x_im_buf[41];
	assign x_im_mat[0][149] =  x_im_buf[169];
	assign x_im_mat[0][150] =  x_im_buf[105];
	assign x_im_mat[0][151] =  x_im_buf[233];
	assign x_im_mat[0][152] =  x_im_buf[25];
	assign x_im_mat[0][153] =  x_im_buf[153];
	assign x_im_mat[0][154] =  x_im_buf[89];
	assign x_im_mat[0][155] =  x_im_buf[217];
	assign x_im_mat[0][156] =  x_im_buf[57];
	assign x_im_mat[0][157] =  x_im_buf[185];
	assign x_im_mat[0][158] =  x_im_buf[121];
	assign x_im_mat[0][159] =  x_im_buf[249];
	assign x_im_mat[0][160] =  x_im_buf[5];
	assign x_im_mat[0][161] =  x_im_buf[133];
	assign x_im_mat[0][162] =  x_im_buf[69];
	assign x_im_mat[0][163] =  x_im_buf[197];
	assign x_im_mat[0][164] =  x_im_buf[37];
	assign x_im_mat[0][165] =  x_im_buf[165];
	assign x_im_mat[0][166] =  x_im_buf[101];
	assign x_im_mat[0][167] =  x_im_buf[229];
	assign x_im_mat[0][168] =  x_im_buf[21];
	assign x_im_mat[0][169] =  x_im_buf[149];
	assign x_im_mat[0][170] =  x_im_buf[85];
	assign x_im_mat[0][171] =  x_im_buf[213];
	assign x_im_mat[0][172] =  x_im_buf[53];
	assign x_im_mat[0][173] =  x_im_buf[181];
	assign x_im_mat[0][174] =  x_im_buf[117];
	assign x_im_mat[0][175] =  x_im_buf[245];
	assign x_im_mat[0][176] =  x_im_buf[13];
	assign x_im_mat[0][177] =  x_im_buf[141];
	assign x_im_mat[0][178] =  x_im_buf[77];
	assign x_im_mat[0][179] =  x_im_buf[205];
	assign x_im_mat[0][180] =  x_im_buf[45];
	assign x_im_mat[0][181] =  x_im_buf[173];
	assign x_im_mat[0][182] =  x_im_buf[109];
	assign x_im_mat[0][183] =  x_im_buf[237];
	assign x_im_mat[0][184] =  x_im_buf[29];
	assign x_im_mat[0][185] =  x_im_buf[157];
	assign x_im_mat[0][186] =  x_im_buf[93];
	assign x_im_mat[0][187] =  x_im_buf[221];
	assign x_im_mat[0][188] =  x_im_buf[61];
	assign x_im_mat[0][189] =  x_im_buf[189];
	assign x_im_mat[0][190] =  x_im_buf[125];
	assign x_im_mat[0][191] =  x_im_buf[253];
	assign x_im_mat[0][192] =  x_im_buf[3];
	assign x_im_mat[0][193] =  x_im_buf[131];
	assign x_im_mat[0][194] =  x_im_buf[67];
	assign x_im_mat[0][195] =  x_im_buf[195];
	assign x_im_mat[0][196] =  x_im_buf[35];
	assign x_im_mat[0][197] =  x_im_buf[163];
	assign x_im_mat[0][198] =  x_im_buf[99];
	assign x_im_mat[0][199] =  x_im_buf[227];
	assign x_im_mat[0][200] =  x_im_buf[19];
	assign x_im_mat[0][201] =  x_im_buf[147];
	assign x_im_mat[0][202] =  x_im_buf[83];
	assign x_im_mat[0][203] =  x_im_buf[211];
	assign x_im_mat[0][204] =  x_im_buf[51];
	assign x_im_mat[0][205] =  x_im_buf[179];
	assign x_im_mat[0][206] =  x_im_buf[115];
	assign x_im_mat[0][207] =  x_im_buf[243];
	assign x_im_mat[0][208] =  x_im_buf[11];
	assign x_im_mat[0][209] =  x_im_buf[139];
	assign x_im_mat[0][210] =  x_im_buf[75];
	assign x_im_mat[0][211] =  x_im_buf[203];
	assign x_im_mat[0][212] =  x_im_buf[43];
	assign x_im_mat[0][213] =  x_im_buf[171];
	assign x_im_mat[0][214] =  x_im_buf[107];
	assign x_im_mat[0][215] =  x_im_buf[235];
	assign x_im_mat[0][216] =  x_im_buf[27];
	assign x_im_mat[0][217] =  x_im_buf[155];
	assign x_im_mat[0][218] =  x_im_buf[91];
	assign x_im_mat[0][219] =  x_im_buf[219];
	assign x_im_mat[0][220] =  x_im_buf[59];
	assign x_im_mat[0][221] =  x_im_buf[187];
	assign x_im_mat[0][222] =  x_im_buf[123];
	assign x_im_mat[0][223] =  x_im_buf[251];
	assign x_im_mat[0][224] =  x_im_buf[7];
	assign x_im_mat[0][225] =  x_im_buf[135];
	assign x_im_mat[0][226] =  x_im_buf[71];
	assign x_im_mat[0][227] =  x_im_buf[199];
	assign x_im_mat[0][228] =  x_im_buf[39];
	assign x_im_mat[0][229] =  x_im_buf[167];
	assign x_im_mat[0][230] =  x_im_buf[103];
	assign x_im_mat[0][231] =  x_im_buf[231];
	assign x_im_mat[0][232] =  x_im_buf[23];
	assign x_im_mat[0][233] =  x_im_buf[151];
	assign x_im_mat[0][234] =  x_im_buf[87];
	assign x_im_mat[0][235] =  x_im_buf[215];
	assign x_im_mat[0][236] =  x_im_buf[55];
	assign x_im_mat[0][237] =  x_im_buf[183];
	assign x_im_mat[0][238] =  x_im_buf[119];
	assign x_im_mat[0][239] =  x_im_buf[247];
	assign x_im_mat[0][240] =  x_im_buf[15];
	assign x_im_mat[0][241] =  x_im_buf[143];
	assign x_im_mat[0][242] =  x_im_buf[79];
	assign x_im_mat[0][243] =  x_im_buf[207];
	assign x_im_mat[0][244] =  x_im_buf[47];
	assign x_im_mat[0][245] =  x_im_buf[175];
	assign x_im_mat[0][246] =  x_im_buf[111];
	assign x_im_mat[0][247] =  x_im_buf[239];
	assign x_im_mat[0][248] =  x_im_buf[31];
	assign x_im_mat[0][249] =  x_im_buf[159];
	assign x_im_mat[0][250] =  x_im_buf[95];
	assign x_im_mat[0][251] =  x_im_buf[223];
	assign x_im_mat[0][252] =  x_im_buf[63];
	assign x_im_mat[0][253] =  x_im_buf[191];
	assign x_im_mat[0][254] =  x_im_buf[127];
	assign x_im_mat[0][255] =  x_im_buf[255];
    //操作输入数据
    integer k;
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            //系统复位
            //输入缓冲寄存器全置零
            for (k = 0; k <= 255; k = k + 1 ) begin
                x_re_buf[k] <= 0;
                x_im_buf[k] <= 0;
            end
        end else begin
            //每一个时钟上升沿将数据输入到输入缓冲寄存器
            //推入
            for (k = 0; k <= 254; k = k + 1 ) begin
                x_re_buf[k+1] <= x_re_buf[k];
                x_im_buf[k+1] <= x_im_buf[k];
            end
            x_re_buf[0] <= x_re;
            x_im_buf[0] <= x_im;
        end
    end
    // input ctrl
    counter counter_u1(
        .clk(clk),
        .rst_n(rst_n),
        .thresh(NUMBER_OF_TIMES_IN),
        .start(sop_in),
        .valid(stb),
        .not_zero(),
        .full(en_ctrl[0]) 
    );
    //操作输出数据
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            //系统复位
            //输出缓冲寄存器全部置零
            for (k = 0; k<=255 ; k=k+1 ) begin
                y_re_buf[k] <= 0;
                y_im_buf[k] <= 0;
            end
        end else if (en_ctrl[8]) begin
            for (k = 0; k<=255 ; k=k+1 ) begin
                y_re_buf[k] <= x_re_mat[8][k];
                y_im_buf[k] <= x_im_mat[8][k];
            end
        end else begin
            //每一个时钟上升沿将待出数据依次推出（输出）
            for (k = 0; k<=254; k=k+1 ) begin
                y_re_buf[k] <= y_re_buf[k+1];
                y_im_buf[k] <= y_im_buf[k+1];
            end
        end
    end
    // output ctrl
    counter counter_u2(
        .clk(clk),
        .rst_n(rst_n),
        .thresh(NUMBER_OF_TIMES_OUT),
        .start(sop_out),
        .valid(1'b1),
        .not_zero(valid_out),
        .full() 
    );   

    assign sop_out = en_ctrl[8];
    reg signed [15:0] y_re_out,y_im_out;
    always@(y_re_buf[0] or y_im_buf[0]) begin
        if (!inv) begin
            y_re_out = y_re_buf[0];
            y_im_out = y_im_buf[0];
        end else begin
            y_re_out = (y_im_buf[0] >>> 6);
            y_im_out = (y_re_buf[0] >>> 6);
        end
    end
    assign y_re = y_re_out;
    assign y_im = y_im_out;
    //8192(0x2000)*Wnr, Wnr = exp(-2Pi*j*r/n) = cos(-2Pi*r/n)+jsin(-2Pi*r/n)
	//r is index, n is N of FFT
    wire signed [15:0] factor_real[127:0];
    wire signed [15:0] factor_imag[127:0];
    //旋转因子
	assign factor_real[0] = 16'h2000;
	assign factor_imag[0] = 16'h0000;
	assign factor_real[1] = 16'h1FFD;
	assign factor_imag[1] = 16'hFF36;
	assign factor_real[2] = 16'h1FF6;
	assign factor_imag[2] = 16'hFE6E;
	assign factor_real[3] = 16'h1FE9;
	assign factor_imag[3] = 16'hFDA5;
	assign factor_real[4] = 16'h1FD8;
	assign factor_imag[4] = 16'hFCDD;
	assign factor_real[5] = 16'h1FC2;
	assign factor_imag[5] = 16'hFC15;
	assign factor_real[6] = 16'h1FA7;
	assign factor_imag[6] = 16'hFB4D;
	assign factor_real[7] = 16'h1F87;
	assign factor_imag[7] = 16'hFA87;
	assign factor_real[8] = 16'h1F62;
	assign factor_imag[8] = 16'hF9C1;
	assign factor_real[9] = 16'h1F38;
	assign factor_imag[9] = 16'hF8FD;
	assign factor_real[10] = 16'h1F0A;
	assign factor_imag[10] = 16'hF839;
	assign factor_real[11] = 16'h1ED7;
	assign factor_imag[11] = 16'hF777;
	assign factor_real[12] = 16'h1E9F;
	assign factor_imag[12] = 16'hF6B5;
	assign factor_real[13] = 16'h1E62;
	assign factor_imag[13] = 16'hF5F6;
	assign factor_real[14] = 16'h1E21;
	assign factor_imag[14] = 16'hF538;
	assign factor_real[15] = 16'h1DDB;
	assign factor_imag[15] = 16'hF47B;
	assign factor_real[16] = 16'h1D90;
	assign factor_imag[16] = 16'hF3C1;
	assign factor_real[17] = 16'h1D41;
	assign factor_imag[17] = 16'hF308;
	assign factor_real[18] = 16'h1CED;
	assign factor_imag[18] = 16'hF251;
	assign factor_real[19] = 16'h1C95;
	assign factor_imag[19] = 16'hF19C;
	assign factor_real[20] = 16'h1C38;
	assign factor_imag[20] = 16'hF0EA;
	assign factor_real[21] = 16'h1BD7;
	assign factor_imag[21] = 16'hF03A;
	assign factor_real[22] = 16'h1B72;
	assign factor_imag[22] = 16'hEF8C;
	assign factor_real[23] = 16'h1B09;
	assign factor_imag[23] = 16'hEEE1;
	assign factor_real[24] = 16'h1A9B;
	assign factor_imag[24] = 16'hEE38;
	assign factor_real[25] = 16'h1A29;
	assign factor_imag[25] = 16'hED92;
	assign factor_real[26] = 16'h19B3;
	assign factor_imag[26] = 16'hECF0;
	assign factor_real[27] = 16'h193A;
	assign factor_imag[27] = 16'hEC50;
	assign factor_real[28] = 16'h18BC;
	assign factor_imag[28] = 16'hEBB3;
	assign factor_real[29] = 16'h183B;
	assign factor_imag[29] = 16'hEB19;
	assign factor_real[30] = 16'h17B5;
	assign factor_imag[30] = 16'hEA82;
	assign factor_real[31] = 16'h172D;
	assign factor_imag[31] = 16'hE9EF;
	assign factor_real[32] = 16'h16A0;
	assign factor_imag[32] = 16'hE95F;
	assign factor_real[33] = 16'h1610;
	assign factor_imag[33] = 16'hE8D2;
	assign factor_real[34] = 16'h157D;
	assign factor_imag[34] = 16'hE84A;
	assign factor_real[35] = 16'h14E6;
	assign factor_imag[35] = 16'hE7C4;
	assign factor_real[36] = 16'h144C;
	assign factor_imag[36] = 16'hE743;
	assign factor_real[37] = 16'h13AF;
	assign factor_imag[37] = 16'hE6C5;
	assign factor_real[38] = 16'h130F;
	assign factor_imag[38] = 16'hE64C;
	assign factor_real[39] = 16'h126D;
	assign factor_imag[39] = 16'hE5D6;
	assign factor_real[40] = 16'h11C7;
	assign factor_imag[40] = 16'hE564;
	assign factor_real[41] = 16'h111E;
	assign factor_imag[41] = 16'hE4F6;
	assign factor_real[42] = 16'h1073;
	assign factor_imag[42] = 16'hE48D;
	assign factor_real[43] = 16'h0FC5;
	assign factor_imag[43] = 16'hE428;
	assign factor_real[44] = 16'h0F15;
	assign factor_imag[44] = 16'hE3C7;
	assign factor_real[45] = 16'h0E63;
	assign factor_imag[45] = 16'hE36A;
	assign factor_real[46] = 16'h0DAE;
	assign factor_imag[46] = 16'hE312;
	assign factor_real[47] = 16'h0CF7;
	assign factor_imag[47] = 16'hE2BE;
	assign factor_real[48] = 16'h0C3E;
	assign factor_imag[48] = 16'hE26F;
	assign factor_real[49] = 16'h0B84;
	assign factor_imag[49] = 16'hE224;
	assign factor_real[50] = 16'h0AC7;
	assign factor_imag[50] = 16'hE1DE;
	assign factor_real[51] = 16'h0A09;
	assign factor_imag[51] = 16'hE19D;
	assign factor_real[52] = 16'h094A;
	assign factor_imag[52] = 16'hE160;
	assign factor_real[53] = 16'h0888;
	assign factor_imag[53] = 16'hE128;
	assign factor_real[54] = 16'h07C6;
	assign factor_imag[54] = 16'hE0F5;
	assign factor_real[55] = 16'h0702;
	assign factor_imag[55] = 16'hE0C7;
	assign factor_real[56] = 16'h063E;
	assign factor_imag[56] = 16'hE09D;
	assign factor_real[57] = 16'h0578;
	assign factor_imag[57] = 16'hE078;
	assign factor_real[58] = 16'h04B2;
	assign factor_imag[58] = 16'hE058;
	assign factor_real[59] = 16'h03EA;
	assign factor_imag[59] = 16'hE03D;
	assign factor_real[60] = 16'h0322;
	assign factor_imag[60] = 16'hE027;
	assign factor_real[61] = 16'h025A;
	assign factor_imag[61] = 16'hE016;
	assign factor_real[62] = 16'h0191;
	assign factor_imag[62] = 16'hE009;
	assign factor_real[63] = 16'h00C9;
	assign factor_imag[63] = 16'hE002;
	assign factor_real[64] = 16'h0000;
	assign factor_imag[64] = 16'hDFFF;
	assign factor_real[65] = 16'hFF36;
	assign factor_imag[65] = 16'hE002;
	assign factor_real[66] = 16'hFE6E;
	assign factor_imag[66] = 16'hE009;
	assign factor_real[67] = 16'hFDA5;
	assign factor_imag[67] = 16'hE016;
	assign factor_real[68] = 16'hFCDD;
	assign factor_imag[68] = 16'hE027;
	assign factor_real[69] = 16'hFC15;
	assign factor_imag[69] = 16'hE03D;
	assign factor_real[70] = 16'hFB4D;
	assign factor_imag[70] = 16'hE058;
	assign factor_real[71] = 16'hFA87;
	assign factor_imag[71] = 16'hE078;
	assign factor_real[72] = 16'hF9C1;
	assign factor_imag[72] = 16'hE09D;
	assign factor_real[73] = 16'hF8FD;
	assign factor_imag[73] = 16'hE0C7;
	assign factor_real[74] = 16'hF839;
	assign factor_imag[74] = 16'hE0F5;
	assign factor_real[75] = 16'hF777;
	assign factor_imag[75] = 16'hE128;
	assign factor_real[76] = 16'hF6B5;
	assign factor_imag[76] = 16'hE160;
	assign factor_real[77] = 16'hF5F6;
	assign factor_imag[77] = 16'hE19D;
	assign factor_real[78] = 16'hF538;
	assign factor_imag[78] = 16'hE1DE;
	assign factor_real[79] = 16'hF47B;
	assign factor_imag[79] = 16'hE224;
	assign factor_real[80] = 16'hF3C1;
	assign factor_imag[80] = 16'hE26F;
	assign factor_real[81] = 16'hF308;
	assign factor_imag[81] = 16'hE2BE;
	assign factor_real[82] = 16'hF251;
	assign factor_imag[82] = 16'hE312;
	assign factor_real[83] = 16'hF19C;
	assign factor_imag[83] = 16'hE36A;
	assign factor_real[84] = 16'hF0EA;
	assign factor_imag[84] = 16'hE3C7;
	assign factor_real[85] = 16'hF03A;
	assign factor_imag[85] = 16'hE428;
	assign factor_real[86] = 16'hEF8C;
	assign factor_imag[86] = 16'hE48D;
	assign factor_real[87] = 16'hEEE1;
	assign factor_imag[87] = 16'hE4F6;
	assign factor_real[88] = 16'hEE38;
	assign factor_imag[88] = 16'hE564;
	assign factor_real[89] = 16'hED92;
	assign factor_imag[89] = 16'hE5D6;
	assign factor_real[90] = 16'hECF0;
	assign factor_imag[90] = 16'hE64C;
	assign factor_real[91] = 16'hEC50;
	assign factor_imag[91] = 16'hE6C5;
	assign factor_real[92] = 16'hEBB3;
	assign factor_imag[92] = 16'hE743;
	assign factor_real[93] = 16'hEB19;
	assign factor_imag[93] = 16'hE7C4;
	assign factor_real[94] = 16'hEA82;
	assign factor_imag[94] = 16'hE84A;
	assign factor_real[95] = 16'hE9EF;
	assign factor_imag[95] = 16'hE8D2;
	assign factor_real[96] = 16'hE95F;
	assign factor_imag[96] = 16'hE95F;
	assign factor_real[97] = 16'hE8D2;
	assign factor_imag[97] = 16'hE9EF;
	assign factor_real[98] = 16'hE84A;
	assign factor_imag[98] = 16'hEA82;
	assign factor_real[99] = 16'hE7C4;
	assign factor_imag[99] = 16'hEB19;
	assign factor_real[100] = 16'hE743;
	assign factor_imag[100] = 16'hEBB3;
	assign factor_real[101] = 16'hE6C5;
	assign factor_imag[101] = 16'hEC50;
	assign factor_real[102] = 16'hE64C;
	assign factor_imag[102] = 16'hECF0;
	assign factor_real[103] = 16'hE5D6;
	assign factor_imag[103] = 16'hED92;
	assign factor_real[104] = 16'hE564;
	assign factor_imag[104] = 16'hEE38;
	assign factor_real[105] = 16'hE4F6;
	assign factor_imag[105] = 16'hEEE1;
	assign factor_real[106] = 16'hE48D;
	assign factor_imag[106] = 16'hEF8C;
	assign factor_real[107] = 16'hE428;
	assign factor_imag[107] = 16'hF03A;
	assign factor_real[108] = 16'hE3C7;
	assign factor_imag[108] = 16'hF0EA;
	assign factor_real[109] = 16'hE36A;
	assign factor_imag[109] = 16'hF19C;
	assign factor_real[110] = 16'hE312;
	assign factor_imag[110] = 16'hF251;
	assign factor_real[111] = 16'hE2BE;
	assign factor_imag[111] = 16'hF308;
	assign factor_real[112] = 16'hE26F;
	assign factor_imag[112] = 16'hF3C1;
	assign factor_real[113] = 16'hE224;
	assign factor_imag[113] = 16'hF47B;
	assign factor_real[114] = 16'hE1DE;
	assign factor_imag[114] = 16'hF538;
	assign factor_real[115] = 16'hE19D;
	assign factor_imag[115] = 16'hF5F6;
	assign factor_real[116] = 16'hE160;
	assign factor_imag[116] = 16'hF6B5;
	assign factor_real[117] = 16'hE128;
	assign factor_imag[117] = 16'hF777;
	assign factor_real[118] = 16'hE0F5;
	assign factor_imag[118] = 16'hF839;
	assign factor_real[119] = 16'hE0C7;
	assign factor_imag[119] = 16'hF8FD;
	assign factor_real[120] = 16'hE09D;
	assign factor_imag[120] = 16'hF9C1;
	assign factor_real[121] = 16'hE078;
	assign factor_imag[121] = 16'hFA87;
	assign factor_real[122] = 16'hE058;
	assign factor_imag[122] = 16'hFB4D;
	assign factor_real[123] = 16'hE03D;
	assign factor_imag[123] = 16'hFC15;
	assign factor_real[124] = 16'hE027;
	assign factor_imag[124] = 16'hFCDD;
	assign factor_real[125] = 16'hE016;
	assign factor_imag[125] = 16'hFDA5;
	assign factor_real[126] = 16'hE009;
	assign factor_imag[126] = 16'hFE6E;
	assign factor_real[127] = 16'hE002;
	assign factor_imag[127] = 16'hFF36;


    //生成蝶形单元
    genvar m,i,j;
    generate
        for (m = 0; m <= 7; m=m+1) begin:stage
            for (i = 0; i <= (1<<(7-m))-1 ; i=i+1) begin:group
                for (j = 0; j <= (1<<m)-1 ; j=j+1) begin:unit
                     butterfly butterfly_u(
                        .clk(clk),
                        .rst_n(rst_n),
                        .en(en_ctrl[m]),
                        .xp_real(x_re_mat[m][(i<<(m+1))+j]),
                        .xp_imag(x_im_mat[m][(i<<(m+1))+j]),
                        .xq_real(x_re_mat[m][(i<<(m+1))+j+(1<<m)]),
                        .xq_imag(x_im_mat[m][(i<<(m+1))+j+(1<<m)]),
                        .factor_real(factor_real[(1<<(7-m))*j]),
                        .factor_imag(factor_imag[(1<<(7-m))*j]),
                        .valid(en_ctrl[m+1]),
                        .yp_real(x_re_mat[m+1][(i<<(m+1))+j]),
                        .yp_imag(x_im_mat[m+1][(i<<(m+1))+j]),
                        .yq_real(x_re_mat[m+1][(i<<(m+1))+j+(1<<m)]),
                        .yq_imag(x_im_mat[m+1][(i<<(m+1))+j+(1<<m)])
                    );
                end
            end 
        end
    endgenerate
endmodule

module counter (
    input clk,
    input rst_n,
    input [8:0] thresh,
    input start,
    input valid,
    output reg not_zero,
    output reg full 
);
    //利用三段式状态机完成状态转换和输出
    reg [8:0] count;
    reg currentState;//低为开始，高为停止
    reg nextState;//低为开始，高为停止
    reg ifCount;//是否计数
    //描述当前状态寄存器的复位和变化
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            currentState <= 1'b1;
            ifCount <= 1'b0;
        end else begin
            currentState <= nextState;
        end
    end
    //描述下一状态的转移
    always @(currentState or start or full) begin
        case (currentState)
            1'b1 : begin
                if(start == 1'b1) begin
                    nextState = 1'b0;
                    ifCount = 1'b1; 
                end else begin 
                    nextState = 1'b1;
                end
            end
            1'b0 : begin
                if(full == 1'b1) begin
                    nextState = 1'b1;
                    ifCount = 1'b0;
                end else begin 
                    nextState = 1'b0;
                end
            end
            default : begin 
                //默认为停止
                nextState = 1'b1;
            end
        endcase
    end
    //状态输出
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            //复位
            count <= 1'b0;
            full <= 1'b0;
            not_zero <= 1'b0;
        end else if (count == thresh) begin
            //到头了
            count <= 1'b0;
            full <= 1'b1;
            not_zero <= 1'b0;
        end else if (valid == 1'b1 && ifCount == 1'b1) begin
            //没到头并且要继续计数
            count <= count + 1'b1;
            full <= 1'b0;
            not_zero <= 1'b1;
        end else begin
            //没到头但是不要继续计数
            count <= count;
            full <= 1'b0;
            not_zero <= 1'b0;
        end
    end
endmodule
module butterfly (
    //蝶形单元
    input clk,
    input rst_n,
    input en,
    input signed [15:0] xp_real,      //Xm(p)
    input signed [15:0] xp_imag,
    input signed [15:0] xq_real,      //Xm(q)
    input signed [15:0] xq_imag,
    input signed [15:0] factor_real,  //Wnr
    input signed [15:0] factor_imag,
    output valid,
    output signed [15:0] yp_real,     //Xm+1(p)
    output signed [15:0] yp_imag,
    output signed [15:0] yq_real,     //Xm+1(q)
    output signed [15:0] yq_imag
);
//DFT && IDFT 通用
    //控制寄存器
    reg [2:0] en_r;
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            en_r <= 1'b0;
        end else begin
            en_r <= {en_r[1:0],en};
        end
    end
    //计算Xm(q)的乘积项并使得Xm(p)基于Wnr量化
    reg signed [31:0] xq_wnr_real0;
    reg signed [31:0] xq_wnr_real1;
    reg signed [31:0] xq_wnr_imag0;
    reg signed [31:0] xq_wnr_imag1;
    reg signed [31:0] xp_real_d;
    reg signed [31:0] xp_imag_d;
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            xp_real_d <= 1'b0;
            xp_imag_d <= 1'b0;
            xq_wnr_real0 <= 1'b0;
            xq_wnr_real1 <= 1'b0;
            xq_wnr_imag0 <= 1'b0;
            xq_wnr_imag1 <= 1'b0;            
        end else if (en) begin
            xq_wnr_real0 <= xq_real * factor_real;
            xq_wnr_real1 <= xq_imag * factor_imag;
            xq_wnr_imag0 <= xq_real * factor_imag;
            xq_wnr_imag1 <= xq_imag * factor_real;
            //进行背书放大
            xp_real_d <= {{4{xp_real[15]}}, xp_real[14:0], 13'b0};
            xp_imag_d <= {{4{xp_imag[15]}}, xp_imag[14:0], 13'b0};
        end
    end
    //得到完整的Xm(q)
    reg signed [31:0] xp_real_d1;
    reg signed [31:0] xp_imag_d1;
    reg signed [31:0] xq_wnr_real;
    reg signed [31:0] xq_wnr_imag;
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            xq_wnr_real <= 1'b0;
            xq_wnr_imag <= 1'b0;
            xp_real_d1 <= 1'b0;
            xp_imag_d1 <= 1'b0;
        end
        else if (en_r[0]) begin
            xp_real_d1 <= xp_real_d;
            xp_imag_d1 <= xp_imag_d;
            //防溢
            xq_wnr_real <= xq_wnr_real0 - xq_wnr_real1;
            xq_wnr_imag <= xq_wnr_imag0 + xq_wnr_imag1;
        end
    end
    //结果
    reg signed [31:0] yp_real_r;
    reg signed [31:0] yp_imag_r;
    reg signed [31:0] yq_real_r;
    reg signed [31:0] yq_imag_r;
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            yp_real_r <= 1'b0;
            yp_imag_r <= 1'b0;
            yq_real_r <= 1'b0;
            yq_imag_r <= 1'b0;
        end else if (en_r[1]) begin
            yp_real_r <= xp_real_d1 + xq_wnr_real;
            yp_imag_r <= xp_imag_d1 + xq_wnr_imag;
            yq_real_r <= xp_real_d1 - xq_wnr_real;
            yq_imag_r <= xp_imag_d1 - xq_wnr_imag;
        end
    end
    //忽略低13位
    assign yp_real = {yp_real_r[31], yp_real_r[13+15:13]};
    assign yp_imag = {yp_imag_r[31], yp_imag_r[13+15:13]};
    assign yq_real = {yq_real_r[31], yq_real_r[13+15:13]};
    assign yq_imag = {yq_imag_r[31], yq_imag_r[13+15:13]};
    assign valid = en_r[2];
endmodule
/***********ACKNOWLEDGEMENT***********/
/*               UCAS                */
/*           www.runoob.com          */
/*             sasasatori            */
/* doi.org:10.5573 JSTS.2017.17.1.101*/
/*************************************/
//The Last Line