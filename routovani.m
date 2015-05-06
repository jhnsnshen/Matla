function [ chyby_A, chyby_B ] = routovani( data_A, data_B, SNR_AR, SNR_BR, zvolmodul, PnA, PnR, PnB )
% Simulace klasick� v�m�ny dat

% Mapov�n� symbol�
symboly_AR = modul (data_A, zvolmodul);
symboly_BR = modul (data_B, zvolmodul);

% Modelov�n� kan�lu 
datasum_AR = model_kanalu (symboly_AR, SNR_AR, PnR);
datasum_BR = model_kanalu (symboly_BR, SNR_BR, PnR);


% Demodulace na Relayi a odesl�n� d�le  - data z A/B
datazA = demodulace (datasum_AR,zvolmodul);
datazB = demodulace (datasum_BR,zvolmodul);

symboly_RB = modul (datazA, zvolmodul);
symboly_RA = modul (datazB, zvolmodul);

% model kan�lu p�i druh�m p�enosu
datasum_RB = model_kanalu (symboly_RB, SNR_BR, PnB);
datasum_RA = model_kanalu (symboly_RA, SNR_AR, PnA);

% Demodulace na koncov�ch stanic�ch
datanaB = demodulace (datasum_RB, zvolmodul);
datanaA = demodulace (datasum_RA, zvolmodul);

% Porovn�n� dat s p�vodn�mi
chyby_A = sum(datanaB~=data_A);
chyby_B = sum(datanaA~=data_B);

end
