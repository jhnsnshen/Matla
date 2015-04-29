function [ chyby_A, chyby_B ] = DNF ( data_A, data_B, h_A, h_B, SNR_AR, SNR_BR, kanal, zvolmodul )
% Technika Denoise and Forward

% Mapování symbolù
symboly_AR = modul (data_A, zvolmodul);
symboly_BR = modul (data_B, zvolmodul);

% Modelování kanálu vèetnì útlumu
datasum_AR = model_kanalu (symboly_AR,kanal, SNR_AR, h_A);
datasum_BR = model_kanalu (symboly_BR,kanal, SNR_BR, h_B);

% Pøíjem na Relayi, souèet a zesílení celkového signálu
prijato_R = datasum_AR/10^(-h_A/10) + datasum_BR/10^(-h_B/10);
symboly_R = odhad (prijato_R, zvolmodul);

% Odeslání dále
datasum_RA = model_kanalu(symboly_R, kanal, SNR_AR, h_A);
datasum_RB = model_kanalu(symboly_R, kanal, SNR_BR, h_B);

% Demodulace na konci
prijato_A = demodulace ( datasum_RA, zvolmodul);
prijato_B = demodulace ( datasum_RB, zvolmodul);

% XORování pøijatých dat s odeslanými
datanaA = xor(prijato_A, data_A);
datanaB = xor(prijato_B, data_B);

% pro QPSK je potøeba výsledek negovat
if zvolmodul == 2
    datanaA = ~datanaA;
    datanaB = ~datanaB;
end

% pøevzato z DF
chyby_A = sum(datanaA~=data_B);
chyby_B = sum(datanaB~=data_A);


end

