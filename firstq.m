close all;
fs = 1000;
t = -10:1/fs:10; 
rt = cos(40*pi*t)./(1+100*t.^2);
plot(t,rt)
title("R(τ)")
xlabel("τ (sn)")
axis([-2 2 -1.1 1.1])
figure;
N = length(t);
f = linspace(-fs/2, fs/2, N); 
windowf = f(:,end);
gf = pi/20 * (exp((-2*pi*abs(f-20))/10)+exp((-2*pi*abs(f+20))/10));
plot(f, abs(gf));
axis([-40 40 -0.01 0.18]);

title("|G(f)|");
xlabel("f (Hz)");
ylabel("|G(f)|");

figure
powerbw(gf,f)
axis([-30 30 0 12])

figure;
enbw(gf,fs)

obw(gf,f)
axis([-50 50 -0.1 11])

