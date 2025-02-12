close all;
clc;
% 通过建模，比较设计的VerilogHDL 256N FFT和MATLAB自带的FFT函数之间的差别
% N = 256
% 生成Wnr
ZoomPar = 13;%13 is 8192
Wnr = zeros(1,128);
for r = 0:127
    Wnr_factor = cos(2*pi*r/256) + 1i*sin(-2*pi*r/256);
    Wnr_integer = round(Wnr_factor*2^(ZoomPar));
    % 处理实部（补码修正）
    if real(Wnr_integer) < 0
        Wnr_real = typecast(int16(real(Wnr_integer)), 'int16');
    else
        Wnr_real = real(Wnr_integer);
    end
    % 处理虚部（同上）
    if imag(Wnr_integer) < 0
        Wnr_imag = typecast(int16(imag(Wnr_integer)), 'int16');
    else
        Wnr_imag = imag(Wnr_integer);
    end
    %测试打印
%     if r == 64
%         Wnr_imag
%     end
    Wnr(r+1) = double(Wnr_real) + 1i * double(Wnr_imag);
end
xr = 1:256;
xi = 1i*(1:256);
%xr = ones(1,256);
%xi = 1i*ones(1,256);
x = xr + xi;
xMat = zeros(9,256);
% 使用内置函数生成位反转
xMat(1,:) = x(bitrevorder(0:255)+1);
%stage,256点数的FFT共8阶
for m = 0:7
    %group，每一阶的组数不一样，对于256点FFT，第m阶有2^(7-m)组
    %对于第m阶，相邻两个组的第一个数据的索引之间的间隔为2^(m+1)
    %也就是说，在第m阶，每组的第一个数据的索引为i*2^(m+1)
    %以上所述不包括最后一组，但由于循环的特性，可忽略不计
    for i = 0:(2^(7-m) - 1)
        %unit，每一组内的单元数不一样，第m阶中，各个组内有2^(m)个单元
        %每个单元中成对的两个数据之间的跨度为2^(m)（如第2阶，0和4是一对）
        %这里的k表示的是每组内的第几（k）个单元，因此k的大小直接关联Wnr的值（W_{2^(m+1)}^{k}）
        for k = 0:(2^m - 1)
            [xMat(m + 2, bitshift(i, m + 1) + k + 1), ...
             xMat(m + 2, bitshift(i, m + 1) + k + bitshift(1, m) + 1)] ...
            = butterflyUnit(...
              xMat(m + 1, bitshift(i, m + 1) + k + 1),...
              xMat(m + 1, bitshift(i, m + 1) + k + bitshift(1, m) + 1),...
              Wnr(bitshift(k, 7 - m) + 1), ...
              ZoomPar);
        end
    end
end
% 绘制结果对比图
figure;
plot(1:256, abs(fftMatlab), 'k:h', 'DisplayName', 'MatlabFFT');
hold on;
plot(1:256, abs(xMat(9,:)), 'm-..', 'DisplayName', 'Verilog256PointFFTModel');
xlabel('Frequency Index');
ylabel('Magnitude');
legend show;
title('Comparison of MatlabFFT and Verilog256PointFFTModel Implementations');
grid on;
function [yp, yq] = butterflyUnit(xp, xq, factor, ZoomPar)
%蝶形单元
    yp = round((xp * 2^(ZoomPar) + xq * factor)*(2^(-ZoomPar)));
    yq = round((xp * 2^(ZoomPar) - xq * factor)*(2^(-ZoomPar)));
end