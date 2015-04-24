clear all;        %probl�m clear all je, �e ma�e breakpointy ve funkc�ch
close all;
clc;

tic
%%%%%%%%% Zad�n� parametr� simulace
% Po�et p�en�en�ch bit�
N=10^4; 

% Volba rozsahu SNR a rozd�lu na trase BR
SNR_od = 2;
SNR_do = 16;
% SNR_do = SNR_od;  % manu�ln� nastaven� nulov� rozsah SNR pro debugging
SNR_naB = 15;

SNR_A = SNR_od:2:SNR_do;

% Volba modulace 1 - BPSK    2 - QPSK
zvolmodul= 2;

% Volba �tlumu tras
h_A = 1;
h_B = 1;

% Volba typu kan�lu 1 - AWGN   2 - Rayleigh�v
kanal = 1;

% % Volba techniky p�enosu 1 - routov�n�   2 - DF  3 - AF  4 - DNF
% NC = 4;

% Generov�n� n�hodn�ch dat, c jako celkov�
data_Ac = generace_dat (N);
data_Bc = generace_dat (N);

time_bez= zeros(1,4); % �as bez zohledn�n� chyb, inicializace matice
BER = zeros(numel(SNR_A),4,3);

% V�dy se zvol� SNR z �ady a pro n�j se vypo��t� BER
% % Volba techniky p�enosu 1 - routov�n�   2 - DF  3 - AF  4 - DNF
% NC = 4;

for NC = 1:4      % parfor sem
    for t = 1:numel(SNR_A)
        SNR_AR = SNR_A(t);
%         SNR_BR = SNR_A(t) + SNR_naB;
        SNR_BR = SNR_naB;
        [BER(t,NC,1:3), time_bez(t,NC,1:3)]= vypocet(data_Ac, data_Bc, h_A, h_B, SNR_AR, SNR_BR, kanal, zvolmodul, NC);
        % time_bez - �as metody bez zohledn�n� chybovosti
    end
    fprintf('dokon�ena metoda %d\n', NC)
end

% BER = BER(:,:,3);
doba_prenosu = time_bez(:,:,3) .* (1 + BER(:,:,3)); % doba pro �sp�n� p�enesen� bit�
rychlost = 2*N ./ doba_prenosu; % V�po�et rychlosti 

% Rychlost alternativn� podle Z.
[a,b] = size(BER);
cas (1:a, 1) = .5;
cas (1:a, 2) = 2/3;
cas (1:a, 3:4) = 1;
rych = cas .* (1-BER(:, :, 3));

figure()
plot(SNR_A, rych)

grid on
axis([SNR_A(1) SNR_A(end) 0 1])
xlabel('SNR(A) [dB]');
ylabel('Normalizovan� rychlost');
% ylabel('BER [-]');
legend('routovani','DF','AF','DNF',4);

% figure()
% plot(SNR_A, rychlost-rych)

toc
