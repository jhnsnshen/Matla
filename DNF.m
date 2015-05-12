function [ chyby_A, chyby_B ] = DNF ( data_A, data_B, SNR_AR, SNR_BR, zvolmodul, PnA, PnR, PnB  )
% Technika Denoise and Forward

% výpoèet útlumù
hAR = PnR-SNR_AR; % = -(SNR + PnR)
hBR = PnR-SNR_BR;
% hRA = PnA-SNR_AR;
% hRB = PnB-SNR_BR;

% Mapování symbolù
symboly_AR = modul (data_A, zvolmodul);
symboly_BR = modul (data_B, zvolmodul);

% Modelování kanálu a spoleèného pøíjmu
datasum = model_kanalu2(symboly_AR, hAR, symboly_BR, hBR, PnR);

if (hAR <= hBR)
    prijato_R = datasum / 10^(-hBR/10);
else
    prijato_R = datasum / 10^(-hAR/10);
end

% Odhad pøijatých dat a pøevod na symboly
symboly_R = odhad (prijato_R, zvolmodul);

% Odeslání dále
datasum_RA = model_kanalu(symboly_R, SNR_AR, PnA);
datasum_RB = model_kanalu(symboly_R, SNR_BR, PnB);

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

