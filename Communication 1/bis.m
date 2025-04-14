close all;
fs = 5000; % Sampling frequency (Hz)
t = -1:1/fs:1; % Time vector
at = -1*(t >= -0.2) + 2*(t >= -0.1) - 2*(t >= 0.1) + 1*(t >= 0.2); % Message signal

% Plot a(t)
subplot(2,2,1);
plot(t, at);
axis([-1 1 -2 2]);
title("a(t)");
xlabel("t (s)");
ylabel("a(t)");

% Frequency domain
N = length(t);
f = linspace(-fs/2, fs/2, N); % Frequency vector
af = fftshift(fft(at))/N; % FFT and normalization

subplot(2,2,2);
plot(f, abs(af));
title("|A(f)|");
xlabel("f (Hz)");
ylabel("|A(f)|");

% Bandpass Filter
b = 5; % Filter bandwidth (Hz)
hf = abs(f) <= b;

subplot(2,2,3);
plot(f, hf);
title("H(f)");
xlabel("f (Hz)");
axis([-50 50 -0.1 1.1]);

% Filtered signal in time domain
xf = hf .* af;
xt = ifft(ifftshift(xf)) * N; % Inverse FFT

subplot(2,2,4);
plot(t, real(xt));
title("Filtered Signal x(t)");
xlabel("t (s)");

% AM Modulation
carrier_freq = 100; % Carrier frequency (Hz)
carrier = cos(2*pi*carrier_freq*t);
xct = 5 * carrier .* (1 + 0.4 * real(xt));

figure;
plot(t, xct);
title("AM Signal xc(t)");
xlabel("t (s)");
axis([-0.1 0.1 -10 10]);
