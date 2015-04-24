clear all;        %problém clear all je, že maže breakpointy ve funkcích
close all;
clc;

tic
%%%%%%%%% Zadání parametrù simulace
% Poèet pøenášených bitù
N=10^4; 

% Volba rozsahu SNR a rozdílu na trase BR
SNR_od = 2;
SNR_do = 16;
% SNR_do = SNR_od;  % manuálnì nastavený nulový rozsah SNR pro debugging
SNR_naB = 15;

SNR_A = SNR_od:1:SNR_do;

% Volba modulace 1 - BPSK    2 - QPSK
zvolmodul= 2;

% Volba útlumu tras v dB
h_A = -5;
h_B = -12;

% Volba typu kanálu 1 - AWGN   2 - Rayleighùv
kanal = 1;

% % Volba techniky pøenosu 1 - routování   2 - DF  3 - AF  4 - DNF
% NC = 4;

% Generování náhodných dat, c jako celkové
data_Ac = generace_dat (N);
data_Bc = generace_dat (N);

time_bez= zeros(1,4); % èas bez zohlednìní chyb, inicializace matice
BER = zeros(numel(SNR_A),4,3);

% Vždy se zvolí SNR z øady a pro nìj se vypoèítá BER
% % Volba techniky pøenosu 1 - routování   2 - DF  3 - AF  4 - DNF
% NC = 4;

for NC = 1:4      % parfor sem
    for t = 1:numel(SNR_A)
        SNR_AR = SNR_A(t);
%         SNR_BR = SNR_A(t) + SNR_naB;
        SNR_BR = SNR_naB;
        BER(t,NC,1:3)= vypocet(data_Ac, data_Bc, h_A, h_B, SNR_AR, SNR_BR, kanal, zvolmodul, NC);
        % time_bez - èas metody bez zohlednìní chybovosti
    end
    fprintf('dokonèena metoda %d\n', NC)
end

% BER = BER(:,:,3);
doba_prenosu = time_bez(:,:,3) .* (1 + BER(:,:,3)); % doba pro úspìšné pøenesení bitù
rychlost = 2*N ./ doba_prenosu; % Výpoèet rychlosti 

% Rychlost alternativnì podle Z.
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
ylabel('Normalizovaná rychlost');
% ylabel('BER [-]');
legend('routovani','DF','AF','DNF',4);

% figure()
% plot(SNR_A, rychlost-rych)

toc
