close all;
clc;
% % 测试一：1-256
% xr = 1:256;
% xi = 1i*(1:256);
% x = xr + xi;

% 采样等参数
Fs = 1000;                    % 采样频率 (Hz)
T = 1/Fs;                     % 采样周期 (秒)
L = 256;                      % 信号长度 (点数)
t = (0:L-1)*T;                % 时间向量


% % 测试二：单个正弦信号
% f = 50;                       % 频率 (Hz)
% A = 1;                        % 幅度
% % 生成正弦信号
% x = A*sin(2*pi*f*t);

% 测试三：两个正弦信号混频,含噪声
% 50 Hz + 120 Hz 正弦波
S = 0.7*sin(2*pi*50*t) + sin(2*pi*120*t);
% 添加一些随机噪声到信号中
x = S + 1*randn(size(t));

% 绘制原始信号
figure;
plot(t, x);
title('原始输入信号');
xlabel('时间 (秒)');
ylabel('幅度');

% 绘制结果对比图
fftMatlab = fft(x,256);
fftCus = cusFFTModel(x,13);
figure;
plot(1:256, abs(fftMatlab), 'k:h', 'DisplayName', 'MatlabFFT');
hold on;
plot(1:256, abs(fftCus), 'm-..', 'DisplayName', 'CusFFTModel');
xlabel('频率索引');
ylabel('幅值');
legend show;
title('幅值频谱(自定义FFT与内置fft比较)');
grid on;

% 计算双边频谱P2/P4和单边频谱P1/P3
% 自带的fft
P2 = abs(fftMatlab/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
% 自创的FFT
P4 = abs(fftCus/L);
P3 = P4(1:L/2+1);
P3(2:end-1) = 2*P3(2:end-1);
% 定义频率域f
f_axis = Fs*(0:(L/2))/L;

% 绘制单边幅值频谱
figure;
plot(f_axis, P1, 'k:h', 'DisplayName', 'MatlabFFT');
hold on;
plot(f_axis, P3 , 'm-..', 'DisplayName', 'CusFFTModel');
title('单边幅值频谱(自定义FFT与内置fft比较)');
xlabel('频率 (Hz)');
ylabel('|P(f)|');
legend show;
grid on;

%绘制误差
figure;
plot(f_axis, abs(abs(P1)-abs(P3)));
title('单边幅值频谱误差(自定义FFT与内置fft比较)');
xlabel('频率 (Hz)');
ylabel('|ΔP(f)|');
mean(abs(abs(P1)-abs(P3)))
