function [ chyby_A, chyby_B] = routovani( data_A, data_B, h_A, h_B, SNR_AR, SNR_BR, kanal, zvolmodul )
% Simulace klasick� v�m�ny dat

% Mapov�n� symbol�
symboly_AR = modul (data_A, zvolmodul);
symboly_BR = modul (data_B, zvolmodul);

% Modelov�n� kan�lu v�etn� �tlumu
datasum_AR = model_kanalu (symboly_AR,kanal, SNR_AR, h_A);
datasum_BR = model_kanalu (symboly_BR,kanal, SNR_BR, h_B);


% Demodulace na Relayi a odesl�n� d�le  - data z A/B
datazA = demodulace (datasum_AR,zvolmodul);
datazB = demodulace (datasum_BR,zvolmodul);

symboly_RB = modul (datazA, zvolmodul);
symboly_RA = modul (datazB, zvolmodul);

% model kan�lu p�i druh�m p�enosu
datasum_RB = model_kanalu (symboly_RB, kanal, SNR_BR, h_B);
datasum_RA = model_kanalu (symboly_RA, kanal, SNR_AR, h_A);

% Demodulace na koncov�ch stanic�ch
datanaB = demodulace (datasum_RB, zvolmodul);
datanaA = demodulace (datasum_RA, zvolmodul);

% Porovn�n� dat s p�vodn�mi
chyby_A = sum(datanaB~=data_A);
chyby_B = sum(datanaA~=data_B);

% % V�po�et BER
% BER_A = chyby_A/(numel(data_A));
% BER_B = chyby_B/(numel(data_B));

end
