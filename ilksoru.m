close all;
fs = 1000; % Sampling frequency (Hz)
t = -1:1/fs:1; % Time vector
at = -1*(t >= -0.2) + 2*(t >= -0.1) - 2*(t >= 0.1) + 1*(t >= 0.2); % Message signal

% Frequency domain
N = length(t);
f = linspace(-fs/2, fs/2, N); % Frequency vector
af = fftshift(fft(at))/N; % FFT and normalization

Gf = pi/20 *(exp(((-2*pi*abs(f-20))/10)) + exp(((-2*pi*abs(f+20))/10)));

plot(f,abs(Gf)*N)
title("|Gf|")
xlabel("f (Hz)")
axis([-100 100 -0.01 1000])

