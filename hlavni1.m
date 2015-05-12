clear all;        %problém clear all je, že maže breakpointy ve funkcích
close all;
clc;

tic
%%%%%%%%% Zadání parametrù simulace
% Poèet pøenášených bitù
N=10^4; 

% Volba rozsahu SNR a rozdílu na trase BR
SNR_od = 2;
SNR_do = 18;
SNR_A = SNR_od:2:SNR_do;

SNR_BR = 12;

% úroveò šumu na jednotlivých pøijímaèích v -dBW
% úroveò bude všude stejná
PnA = 15;
PnR = 18;
PnB = 20;

% Volba modulace 1 - BPSK    2 - QPSK
modul= 2;

% % Volba útlumu tras v dB (kladná hodnota)
% h_A = 8;
% h_B = 5;

% Generování náhodných dat, c jako celkové
data_Ac = generace_dat (N);
data_Bc = generace_dat (N);

BER = zeros(numel(SNR_A),4,3);


for NC = 1:4     % parfor here
    for t = 1:numel(SNR_A)
        SNR_AR = SNR_A(t);
        BER(t,NC,1:3) = vypocet(data_Ac, data_Bc, SNR_AR, SNR_BR, modul, NC, PnA, PnR, PnB);
    end
    fprintf('dokonèena metoda %d\n', NC)
end



% Rychlost
[a,b] = size(BER);
cas (1:a, 1) = .5;
cas (1:a, 2) = 2/3;
cas (1:a, 3:4) = 1;
rych = cas .* (1-BER(:, :, 3));

% vykreslování grafù 
figure()
plot(SNR_A, rych)
grid on
axis([SNR_A(1) SNR_A(end) 0 1])
xlabel('SNR(A) [dB]');
ylabel('Normalizovaná rychlost');
% ylabel('BER [-]');
legend('routovani','DF','AF','DNF',4);


toc
