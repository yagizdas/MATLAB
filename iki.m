close all;
fs = 10000;
t = 0:1/fs:2; 
at = -1*(t >= -0.2) + 2*(t >= -0.1) - 2*(t >= 0.1) + 1*(t >= 0.2); % Message signal
N = length(t);
f = linspace(-fs/2, fs/2, N); 

xt = sin(2*pi*(1+0.6*t).*t);
figure;

xintegral = cumtrapz(t,xt);
fc = 40;
kf = 40*pi;
Ac = 1;
carrier = 2*pi*fc;
xct = Ac*cos(carrier*t + kf*xintegral);
subplot(2,1,1)
plot(t,xct);
axis([0,1,-2,2]);
xlabel("t(s)")
title("xc(t)")

subplot(2,1,2)
xcf = fftshift(fft(xct));
plot(f,abs(xcf)/N)
axis([-45,45,0,0.15])
xlabel("f(Hz)")
title("|Xc(f)|")