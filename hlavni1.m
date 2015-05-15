clear all;        %probl�m clear all je, �e ma�e breakpointy ve funkc�ch
close all;
clc;

tic
%%%%%%%%% Zad�n� parametr� simulace
% Po�et p�en�en�ch bit�
N=10^4; 

% �rove� �umu - stejn� pro v�echny
Pn = 10^-4; % [W]

% Volba rozsahu SNR a rozd�lu na trase BR
SNR_od = 0;
SNR_do = 18;
SNR_A = SNR_od:2:SNR_do;

SNR_BR = 12;

% P�epo�et SNR na �tlumy
SNR_Alin = 10.^(SNR_A/10);
L_A = sqrt(SNR_Alin.*Pn^2);
L_B = sqrt(10^(SNR_BR/10) * Pn^2);


% Volba modulace 1 - BPSK    2 - QPSK
modul= 2;


% Generov�n� n�hodn�ch dat, c jako celkov�
data_Ac = generace_dat (N);
data_Bc = generace_dat (N);

BER = zeros(numel(L_A),4,3);


for NC = 1:3     % parfor here
    for t = 1:numel(L_A)
        L_a = L_A(t);
        BER(t,NC,1:3) = vypocet(data_Ac, data_Bc, L_a, L_B, modul, NC, Pn);
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
