function [ chyby_A, chyby_B ] = AF ( data_A, data_B, SNR_AR, SNR_BR, zvolmodul, PnA, PnR, PnB )
% Amplify-and-Forward

% v�po�et �tlum�
hAR = PnR-SNR_AR; % = -(SNR + PnR)
hBR = PnR-SNR_BR;
hRA = PnA-SNR_AR;
hRB = PnB-SNR_BR;

% Mapov�n� symbol�
symboly_AR = modul (data_A, zvolmodul);
symboly_BR = modul (data_B, zvolmodul);

% % Sou�et symbol� pro relay
% h_R = 1;
% signal_R = h_A*symboly_AR + h_B * symboly_BR;
% datasum_R = model_kanalu(signal_R, kanal,

% Modelov�n� kan�lu v�etn� �tlumu
prijato_R = model_kanalu2 (symboly_AR, hAR, symboly_BR, hBR, PnR);



% P��jem na Relayi, sou�et a zes�len� celkov�ho sign�lu
% prijato_R = datasum_AR + datasum_BR;

if (hAR >= hBR)
    odesle_R = prijato_R / 10^(-hBR/10);
elseif (hAR < hBR)
    odesle_R = prijato_R / 10^(-hAR/10);
else
    odesle_R = prijato_R / 10^(-hBR/10);
end
    

% model kan�lu p�i druh�m p�enosu
datasum_RA = model_kanalu (odesle_R, SNR_AR, PnA);
datasum_RB = model_kanalu (odesle_R, SNR_BR, PnB);

% ode�ten� sign�lu u p��jemce
datasum_A = datasum_RA - 10^(-hRA/10) * symboly_AR;
datasum_B = datasum_RB - 10^(-hRB/10) * symboly_BR;

% pokus o demodulaci
datanaA = demodulace (datasum_A, zvolmodul);
datanaB = demodulace (datasum_B, zvolmodul);

% Porovn�n� dat s p�vodn�mi
chyby_A = sum(datanaB~=data_A);
chyby_B = sum(datanaA~=data_B);

end

