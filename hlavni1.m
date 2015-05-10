clear all;        %probl�m clear all je, �e ma�e breakpointy ve funkc�ch
close all;
clc;

tic
%%%%%%%%% Zad�n� parametr� simulace
% Po�et p�en�en�ch bit�
N=10^4; 

% Volba rozsahu SNR
SNR_od = 0;
SNR_do = 30;
SNR_A = SNR_od:2:SNR_do;
SNR_BR = 12;

% �rove� �umu na jednotliv�ch p�ij�ma��ch v -dBW
PnA = 30;
PnR = 25;
PnB = 30;

% Volba modulace 1 - BPSK    2 - QPSK
modulace= 2;

% % Volba �tlumu tras v dB (kladn� hodnota)
% h_A = 8;
% h_B = 5;


% % Volba techniky p�enosu 1 - routov�n�   2 - DF  3 - AF  4 - DNF
% NC = 4;

% Generov�n� n�hodn�ch dat, c jako celkov�
data_Ac = generace_dat (N);
data_Bc = generace_dat (N);

BER = zeros(numel(SNR_A),4,3);


for NC = 1:4     % parfor sem
    for t = 1:numel(SNR_A) % t ud�v� aktu�ln� �um na lince AR
        SNR_AR = SNR_A(t);
        BER1(NC,1:3) = vypocet(data_Ac, data_Bc, SNR_AR, SNR_BR, modulace, NC, PnA, PnR, PnB);
%         BER(t,NC,1:3) = vypocet(data_Ac, data_Bc, SNR_AR, SNR_BR, modulace, NC, PnA, PnR, PnB); % pracovn� verze
        
        BER=[t;BER1]; % pot�ebuju pro parfor p�ed�vat pouze jednu prom�nnou jako index

    end
    fprintf('dokon�ena metoda %d\n', NC)
end



% Rychlost
[a,b] = size(BER);
cas (1:a, 1) = .5;
cas (1:a, 2) = 2/3;
cas (1:a, 3:4) = 1;
rych = cas .* (1-BER(:, :, 3));

% vykreslov�n� graf�
figure()
plot(SNR_A, rych)
grid on
axis([SNR_A(1) SNR_A(end) 0 1])
xlabel('SNR(A) [dB]');
ylabel('Normalizovan� rychlost');
% ylabel('BER [-]');
legend('routovani','DF','AF','DNF',4);


toc
