clear variables;        % clear all ma�e breakpointy ve funkc�ch
close all;
clc;

tic
%%%%%%%%% Zad�n� parametr� simulace
% Po�et p�en�en�ch bit�
N=10^5;

% �rove� �umu - stejn� pro v�echny
Pn = 10^-6; % [W]

% % Volba rozsahu SNR v decibelech
SNR_od = 0;
SNR_do = 40;
SNR_A = SNR_od:.5:SNR_do;

% SNR_A = 60;
SNR_B = 5;

% P�epo�et SNR na �tlumy
SNR_Alin = 10.^(SNR_A/10);         
L_A = sqrt(SNR_Alin .* Pn);         
L_B = sqrt(10^(SNR_B/10) * Pn);


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
