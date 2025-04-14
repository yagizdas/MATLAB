close all;
fs = 1000;
t = -10:1/fs:10; 
at = -1*(t >= -0.2) + 2*(t >= -0.1) - 2*(t >= 0.1) + 1*(t >= 0.2); % Message signal

subplot(2,2,1);
plot(t, at);
axis([-1 1 -2 2]);
title("a(t)");
xlabel("t (s)");
ylabel("a(t)");

N = length(t);
f = linspace(-fs/2, fs/2, N); 
af = fftshift(fft(at))/N; 

subplot(2,2,2);
plot(f, abs(af));
title("|A(f)|");
xlabel("f (Hz)");
ylabel("|A(f)|");

%BGS Oluşturma Kısmı
%b 5 ve 30'a ayarlanarak değiştirilebilir.
b = 12; 
hf = abs(f) <= b;

subplot(2,2,3);
plot(f, hf);
title("H(f)");
xlabel("f (Hz)");
ylabel("H(f)")
axis([-50 50 -0.1 1.1]);

xf = hf .* af;
xt = ifft(ifftshift(xf)) * N; 

subplot(2,2,4);
plot(t, real(xt));
title("x(t)");
xlabel("t (s)");
ylabel("x(t)")
axis([-0.5 0.5 -1.8 1.8])

carrier_freq = 100; 
m = 0.4;
carrier = 5 * cos(2*pi*carrier_freq*t);
xct = carrier .* (1 + m * real(xt));

figure;
subplot(2,2,1)
plot(f,abs(xf));
axis([-50 50 -0.001 0.015])
title("|X(f)|")
xlabel("f (Hz)")
ylabel("|X(f)|")
subplot(2,2,2);
plot(t, xct);
title("xc(t) Klasik GM Modülasyonu");
xlabel("t (s)");
ylabel("xc(t)")
axis([-1 1 -10 10]);
subplot(2,2,3);
xct_cyb = carrier .* (real(xt));
plot(t,xct_cyb)
title("xc(t) ÇYB Modülasyonu")
xlabel("t (s)")
ylabel("xcÇYB(t)")
axis([-1 1 -10 10])
subplot(2,2,4)
plot(t,carrier)
title("Carrier Signal")
axis([-0.1 0.1 -10 10 ])
xlabel("t (sn)")
ylabel("Taşıyıcı")
figure;
subplot(2,2,1);
xcf = fftshift(fft(xct))/N; 
plot(f,abs(xcf))
axis([60 140 -0.01 0.1])
title("|Xc(f)|" ,"\fontsize{9}(Pozitif düzlemdeki elementine yakınlaştırılmış)")
xlabel("f (Hz)")
ylabel("|Xc(f)|")
subplot(2,2,2)
xcf = fftshift(fft(xct))/N; 
plot(f,abs(xcf))
title("|Xc(f)|")
ylabel("|Xc(f)|")
axis([-140 140 -0.01 3])
xlabel("f (Hz)")

subplot(2,2,3)
xcf_cyb = fftshift(fft(xct_cyb))/N; 
plot(f,abs(xcf_cyb))
title("|XcÇYB(f)|","\fontsize{9}(Pozitif düzlemdeki elemanına yakınlaştırılmış)")
xlabel("f (Hz)")
ylabel("|XcÇYB(f)|")
axis([60 140 -0.01 0.05])

subplot(2,2,4)
xcf_cyb = fftshift(fft(xct_cyb))/N; 
plot(f,abs(xcf_cyb))
title("|XcÇYB(f)|")
xlabel("f (Hz)")
ylabel("|XcÇYB(f)|")
axis([-160 160 -0.0 0.05 ])
