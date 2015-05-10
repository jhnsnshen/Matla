clear all;        %problém clear all je, že maže breakpointy ve funkcích
close all;
clc;

tic
%%%%%%%%% Zadání parametrù simulace
% Poèet pøenášených bitù
N=10^4; 

% Volba rozsahu SNR
SNR_od = 0;
SNR_do = 30;
SNR_A = SNR_od:2:SNR_do;
SNR_BR = 12;

% úroveò šumu na jednotlivých pøijímaèích v -dBW
PnA = 30;
PnR = 25;
PnB = 30;

% Volba modulace 1 - BPSK    2 - QPSK
modulace= 2;

% % Volba útlumu tras v dB (kladná hodnota)
% h_A = 8;
% h_B = 5;


% % Volba techniky pøenosu 1 - routování   2 - DF  3 - AF  4 - DNF
% NC = 4;

% Generování náhodných dat, c jako celkové
data_Ac = generace_dat (N);
data_Bc = generace_dat (N);

BER = zeros(numel(SNR_A),4,3);


for NC = 1:4     % parfor sem
    for t = 1:numel(SNR_A) % t udává aktuální šum na lince AR
        SNR_AR = SNR_A(t);
        BER1(NC,1:3) = vypocet(data_Ac, data_Bc, SNR_AR, SNR_BR, modulace, NC, PnA, PnR, PnB);
%         BER(t,NC,1:3) = vypocet(data_Ac, data_Bc, SNR_AR, SNR_BR, modulace, NC, PnA, PnR, PnB); % pracovní verze
        
        BER=[t;BER1]; % potøebuju pro parfor pøedávat pouze jednu promìnnou jako index

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
