close all;
clc;
% compare the VerilogHDL FFT with the MATLAB's FFT
% N =  256
% generate the Wnr
% modeling designed VerilogHDL FFT and compare
for r = 0:127
    Wnr_factor = cos(2*pi*r/256) + 1i*sin(-2*pi*r/256);
    Wnr_integer = floor(Wnr_factor * 8192);
   
    if (real(Wnr_integer) < 0)
        Wnr_real = bitcmp(abs(real(Wnr_integer)),'uint16'); %思路见python代码
    else
        Wnr_real = real(Wnr_integer);
    end
    if (imag(Wnr_integer) < 0)
        Wnr_imag = bitcmp(abs(imag(Wnr_integer)),'uint16');
    else
        Wnr_imag = imag(Wnr_integer);
    end
    %abs1 = abs(imag(Wnr_integer))
    %ccc = dec2bin(abs(imag(Wnr_integer)))
    %bbb = dec2bin(bitcmp(abs(imag(Wnr_integer)),'uint16'))
    %aaa = dec2hex(Wnr_imag)
    Wnr(r+1) = Wnr_real + 1i * Wnr_imag;
end
xr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127, 128, 129, 130, 131, 132, 133, 134, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 145, 146, 147, 148, 149, 150, 151, 152, 153, 154, 155, 156, 157, 158, 159, 160, 161, 162, 163, 164, 165, 166, 167, 168, 169, 170, 171, 172, 173, 174, 175, 176, 177, 178, 179, 180, 181, 182, 183, 184, 185, 186, 187, 188, 189, 190, 191, 192, 193, 194, 195, 196, 197, 198, 199, 200, 201, 202, 203, 204, 205, 206, 207, 208, 209, 210, 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222, 223, 224, 225, 226, 227, 228, 229, 230, 231, 232, 233, 234, 235, 236, 237, 238, 239, 240, 241, 242, 243, 244, 245, 246, 247, 248, 249, 250, 251, 252, 253, 254, 255, 256];
xi =[1i, 2i, 3i, 4i, 5i, 6i, 7i, 8i, 9i, 10i, 11i, 12i, 13i, 14i, 15i, 16i, 17i, 18i, 19i, 20i, 21i, 22i, 23i, 24i, 25i, 26i, 27i, 28i, 29i, 30i, 31i, 32i, 33i, 34i, 35i, 36i, 37i, 38i, 39i, 40i, 41i, 42i, 43i, 44i, 45i, 46i, 47i, 48i, 49i, 50i, 51i, 52i, 53i, 54i, 55i, 56i, 57i, 58i, 59i, 60i, 61i, 62i, 63i, 64i, 65i, 66i, 67i, 68i, 69i, 70i, 71i, 72i, 73i, 74i, 75i, 76i, 77i, 78i, 79i, 80i, 81i, 82i, 83i, 84i, 85i, 86i, 87i, 88i, 89i, 90i, 91i, 92i, 93i, 94i, 95i, 96i, 97i, 98i, 99i, 100i, 101i, 102i, 103i, 104i, 105i, 106i, 107i, 108i, 109i, 110i, 111i, 112i, 113i, 114i, 115i, 116i, 117i, 118i, 119i, 120i, 121i, 122i, 123i, 124i, 125i, 126i, 127i, 128i, 129i, 130i, 131i, 132i, 133i, 134i, 135i, 136i, 137i, 138i, 139i, 140i, 141i, 142i, 143i, 144i, 145i, 146i, 147i, 148i, 149i, 150i, 151i, 152i, 153i, 154i, 155i, 156i, 157i, 158i, 159i, 160i, 161i, 162i, 163i, 164i, 165i, 166i, 167i, 168i, 169i, 170i, 171i, 172i, 173i, 174i, 175i, 176i, 177i, 178i, 179i, 180i, 181i, 182i, 183i, 184i, 185i, 186i, 187i, 188i, 189i, 190i, 191i, 192i, 193i, 194i, 195i, 196i, 197i, 198i, 199i, 200i, 201i, 202i, 203i, 204i, 205i, 206i, 207i, 208i, 209i, 210i, 211i, 212i, 213i, 214i, 215i, 216i, 217i, 218i, 219i, 220i, 221i, 222i, 223i, 224i, 225i, 226i, 227i, 228i, 229i, 230i, 231i, 232i, 233i, 234i, 235i, 236i, 237i, 238i, 239i, 240i, 241i, 242i, 243i, 244i, 245i, 246i, 247i, 248i, 249i, 250i, 251i, 252i, 253i, 254i, 255i, 256i];
x = xr + xi;
xMat = zeros(9,256);
xMat(1,:) = bitInvert(x);
%stage,256点数的FFT共8阶
for m = 0:7
    %group，每一阶的组数不一样，对于256点FFT，第m阶有2^(7-m)组
    %对于第m阶，相邻两个组的第一个数据的索引之间的间隔为2^(m+1)
    %也就是说，在第m阶，每组的第一个数据的索引为i*2^(m+1)
    %以上所述不包括最后一组，但由于循环的特性，可忽略不计
    for i = 0:((bitshift(1, 7 - m)) - 1)
        %unit，每一组内的单元数不一样，第m阶中，各个组内有2^(m)个单元
        %每个单元中成对的两个数据之间的跨度为2^(m)（如第2阶，0和4是一对）
        %这里的k表示的是每组内的第几（k）个单元，因此k的大小直接关联Wnr的值（W_{2^(m+1)}^{k}）
        for k = 0:((bitshift(1, m)) - 1)
            [xMat(m + 2, bitshift(i, m + 1) + k + 1), ...
             xMat(m + 2, bitshift(i, m + 1) + k + bitshift(1, m) + 1)] ...
            = butterflyUnit(...
              xMat(m + 1, bitshift(i, m + 1) + k + 1),...
              xMat(m + 1, bitshift(i, m + 1) + k + bitshift(1, m) + 1),...
              Wnr(bitshift(k, 7 - m) + 1));
              %Wnr(bitshift(1, (7 - m)) * k + 1));
        end
    end
end
% fft
fftMatlab = fft(x,256);
plot(1:256, abs(fftMatlab))
hold on
plot(1:256, abs(xMat(9,:)), 'r')

function [yp, yq] = butterflyUnit(xp, xq, factor)
%蝶形单元
    yp = floor((xp + xq * factor)/8192);
    yq = floor((xp - xq * factor)/8192);
%    yp = (xp + xq * factor);
%    yq = (xp - xq * factor);
%     yp0 = xp + xq * factor;
%     yq0 = xp - xq * factor;
%     if(real(yp0) < 0)
%         yp_real = -bitshift(abs(real(yp0)),-13);
%     else
%         yp_real = bitshift(abs(real(yp0)),-13);
%     end
%     if(imag(yp0) < 0)
%         yp_imag = -bitshift(abs(imag(yp0)),-13);
%     else
%         yp_imag = bitshift(abs(imag(yp0)),-13);
%     end
%     if(real(yq0) < 0)
%         yq_real = -bitshift(abs(real(yq0)),-13);
%     else
%         yq_real = bitshift(abs(real(yq0)),-13);
%     end
%     if(imag(yq0) < 0)
%         yq_imag = -bitshift(abs(imag(yq0)),-13);
%     else
%         yq_imag = bitshift(abs(imag(yq0)),-13);
%     end
% 
%     yp = yp_real + 1i * yp_imag;
%     yq = yq_real + 1i * yq_imag;
end
function res = bitInvert(input)
	res(1) =  input(1);
	res(2) =  input(129);
	res(3) =  input(65);
	res(4) =  input(193);
	res(5) =  input(33);
	res(6) =  input(161);
	res(7) =  input(97);
	res(8) =  input(225);
	res(9) =  input(17);
	res(10) =  input(145);
	res(11) =  input(81);
	res(12) =  input(209);
	res(13) =  input(49);
	res(14) =  input(177);
	res(15) =  input(113);
	res(16) =  input(241);
	res(17) =  input(9);
	res(18) =  input(137);
	res(19) =  input(73);
	res(20) =  input(201);
	res(21) =  input(41);
	res(22) =  input(169);
	res(23) =  input(105);
	res(24) =  input(233);
	res(25) =  input(25);
	res(26) =  input(153);
	res(27) =  input(89);
	res(28) =  input(217);
	res(29) =  input(57);
	res(30) =  input(185);
	res(31) =  input(121);
	res(32) =  input(249);
	res(33) =  input(5);
	res(34) =  input(133);
	res(35) =  input(69);
	res(36) =  input(197);
	res(37) =  input(37);
	res(38) =  input(165);
	res(39) =  input(101);
	res(40) =  input(229);
	res(41) =  input(21);
	res(42) =  input(149);
	res(43) =  input(85);
	res(44) =  input(213);
	res(45) =  input(53);
	res(46) =  input(181);
	res(47) =  input(117);
	res(48) =  input(245);
	res(49) =  input(13);
	res(50) =  input(141);
	res(51) =  input(77);
	res(52) =  input(205);
	res(53) =  input(45);
	res(54) =  input(173);
	res(55) =  input(109);
	res(56) =  input(237);
	res(57) =  input(29);
	res(58) =  input(157);
	res(59) =  input(93);
	res(60) =  input(221);
	res(61) =  input(61);
	res(62) =  input(189);
	res(63) =  input(125);
	res(64) =  input(253);
	res(65) =  input(3);
	res(66) =  input(131);
	res(67) =  input(67);
	res(68) =  input(195);
	res(69) =  input(35);
	res(70) =  input(163);
	res(71) =  input(99);
	res(72) =  input(227);
	res(73) =  input(19);
	res(74) =  input(147);
	res(75) =  input(83);
	res(76) =  input(211);
	res(77) =  input(51);
	res(78) =  input(179);
	res(79) =  input(115);
	res(80) =  input(243);
	res(81) =  input(11);
	res(82) =  input(139);
	res(83) =  input(75);
	res(84) =  input(203);
	res(85) =  input(43);
	res(86) =  input(171);
	res(87) =  input(107);
	res(88) =  input(235);
	res(89) =  input(27);
	res(90) =  input(155);
	res(91) =  input(91);
	res(92) =  input(219);
	res(93) =  input(59);
	res(94) =  input(187);
	res(95) =  input(123);
	res(96) =  input(251);
	res(97) =  input(7);
	res(98) =  input(135);
	res(99) =  input(71);
	res(100) =  input(199);
	res(101) =  input(39);
	res(102) =  input(167);
	res(103) =  input(103);
	res(104) =  input(231);
	res(105) =  input(23);
	res(106) =  input(151);
	res(107) =  input(87);
	res(108) =  input(215);
	res(109) =  input(55);
	res(110) =  input(183);
	res(111) =  input(119);
	res(112) =  input(247);
	res(113) =  input(15);
	res(114) =  input(143);
	res(115) =  input(79);
	res(116) =  input(207);
	res(117) =  input(47);
	res(118) =  input(175);
	res(119) =  input(111);
	res(120) =  input(239);
	res(121) =  input(31);
	res(122) =  input(159);
	res(123) =  input(95);
	res(124) =  input(223);
	res(125) =  input(63);
	res(126) =  input(191);
	res(127) =  input(127);
	res(128) =  input(255);
	res(129) =  input(2);
	res(130) =  input(130);
	res(131) =  input(66);
	res(132) =  input(194);
	res(133) =  input(34);
	res(134) =  input(162);
	res(135) =  input(98);
	res(136) =  input(226);
	res(137) =  input(18);
	res(138) =  input(146);
	res(139) =  input(82);
	res(140) =  input(210);
	res(141) =  input(50);
	res(142) =  input(178);
	res(143) =  input(114);
	res(144) =  input(242);
	res(145) =  input(10);
	res(146) =  input(138);
	res(147) =  input(74);
	res(148) =  input(202);
	res(149) =  input(42);
	res(150) =  input(170);
	res(151) =  input(106);
	res(152) =  input(234);
	res(153) =  input(26);
	res(154) =  input(154);
	res(155) =  input(90);
	res(156) =  input(218);
	res(157) =  input(58);
	res(158) =  input(186);
	res(159) =  input(122);
	res(160) =  input(250);
	res(161) =  input(6);
	res(162) =  input(134);
	res(163) =  input(70);
	res(164) =  input(198);
	res(165) =  input(38);
	res(166) =  input(166);
	res(167) =  input(102);
	res(168) =  input(230);
	res(169) =  input(22);
	res(170) =  input(150);
	res(171) =  input(86);
	res(172) =  input(214);
	res(173) =  input(54);
	res(174) =  input(182);
	res(175) =  input(118);
	res(176) =  input(246);
	res(177) =  input(14);
	res(178) =  input(142);
	res(179) =  input(78);
	res(180) =  input(206);
	res(181) =  input(46);
	res(182) =  input(174);
	res(183) =  input(110);
	res(184) =  input(238);
	res(185) =  input(30);
	res(186) =  input(158);
	res(187) =  input(94);
	res(188) =  input(222);
	res(189) =  input(62);
	res(190) =  input(190);
	res(191) =  input(126);
	res(192) =  input(254);
	res(193) =  input(4);
	res(194) =  input(132);
	res(195) =  input(68);
	res(196) =  input(196);
	res(197) =  input(36);
	res(198) =  input(164);
	res(199) =  input(100);
	res(200) =  input(228);
	res(201) =  input(20);
	res(202) =  input(148);
	res(203) =  input(84);
	res(204) =  input(212);
	res(205) =  input(52);
	res(206) =  input(180);
	res(207) =  input(116);
	res(208) =  input(244);
	res(209) =  input(12);
	res(210) =  input(140);
	res(211) =  input(76);
	res(212) =  input(204);
	res(213) =  input(44);
	res(214) =  input(172);
	res(215) =  input(108);
	res(216) =  input(236);
	res(217) =  input(28);
	res(218) =  input(156);
	res(219) =  input(92);
	res(220) =  input(220);
	res(221) =  input(60);
	res(222) =  input(188);
	res(223) =  input(124);
	res(224) =  input(252);
	res(225) =  input(8);
	res(226) =  input(136);
	res(227) =  input(72);
	res(228) =  input(200);
	res(229) =  input(40);
	res(230) =  input(168);
	res(231) =  input(104);
	res(232) =  input(232);
	res(233) =  input(24);
	res(234) =  input(152);
	res(235) =  input(88);
	res(236) =  input(216);
	res(237) =  input(56);
	res(238) =  input(184);
	res(239) =  input(120);
	res(240) =  input(248);
	res(241) =  input(16);
	res(242) =  input(144);
	res(243) =  input(80);
	res(244) =  input(208);
	res(245) =  input(48);
	res(246) =  input(176);
	res(247) =  input(112);
	res(248) =  input(240);
	res(249) =  input(32);
	res(250) =  input(160);
	res(251) =  input(96);
	res(252) =  input(224);
	res(253) =  input(64);
	res(254) =  input(192);
	res(255) =  input(128);
	res(256) =  input(256);
end