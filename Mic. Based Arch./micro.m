clear; close all;

%% 1) Parametreler
FS = 700;        % Örnekleme frekansı [Hz]
f  = 165;        % Öğrenci frekansı [Hz]
N  = FS;         % Bir saniyedeki örnek sayısı
t  = (0:N-1)/FS; % Zaman vektörü (1 s)

%% 2) İki sinüzoid üretimi: f/2 ve f
x1 = cos(2*pi*(f/2)*t);  % Bozucu sinüs (82.5 Hz)
x2 = cos(2*pi*f*t);      % İstediğimiz sinüs (165 Hz)
x  = x1 + x2;            % Toplam işaret

%% 3) 0–255 aralığına ölçekle ve tam sayıya yuvarla
x_scaled = round(127.5*(x/max(abs(x))) + 127.5);

%% 4) HPF filtresi tasarımı (elliptik)
Rp = 1;    % Pass-band ripple [dB]
Rs = 20;   % Stop-band attenuation [dB]
Wp = (f/2)/(FS/2);    % Normalize edilmiş geçiş kenarı
Ws = Wp * 0.8;        % Normalize edilmiş stop-band kenarı

[n, Wn] = ellipord(Wp, Ws, Rp, Rs);
[b, a] = ellip(n, Rp, Rs, Wn, 'high');

%% 5) Filtreyi uygula ve FFT ile kontrol et
y     = filter(b, a, double(x_scaled));
Nfft  = 1024;
Xf    = abs(fft(x_scaled, Nfft));
Yf    = abs(fft(y,       Nfft));
fAxis = (0:Nfft-1)*(FS/Nfft);

%% 6) Sonuçları çizdir
figure;
subplot(2,1,1);
plot(fAxis, Xf);
xlim([0 FS/2]);
title('Giriş Spektrumu');
xlabel('Frekans (Hz)');
ylabel('|X(f)|');

subplot(2,1,2);
plot(fAxis, Yf);
xlim([0 FS/2]);
title('Çıkış Spektrumu (HPF sonrası)');
xlabel('Frekans (Hz)');
ylabel('|Y(f)|');