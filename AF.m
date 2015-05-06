function [ chyby_A, chyby_B ] = AF ( data_A, data_B, SNR_AR, SNR_BR, zvolmodul, PnA, PnR, PnB )
% Amplify-and-Forward

% výpoèet útlumù
hAR = PnR-SNR_AR; % = -(SNR + PnR)
hBR = PnR-SNR_BR;
hRA = PnA-SNR_AR;
hRB = PnB-SNR_BR;

% Mapování symbolù
symboly_AR = modul (data_A, zvolmodul);
symboly_BR = modul (data_B, zvolmodul);

% % Souèet symbolù pro relay
% h_R = 1;
% signal_R = h_A*symboly_AR + h_B * symboly_BR;
% datasum_R = model_kanalu(signal_R, kanal,

% Modelování kanálu vèetnì útlumu
prijato_R = model_kanalu2 (symboly_AR, hAR, symboly_BR, hBR, PnR);



% Pøíjem na Relayi, souèet a zesílení celkového signálu
% prijato_R = datasum_AR + datasum_BR;

if (hAR >= hBR)
    odesle_R = prijato_R / 10^(-hBR/10);
elseif (hAR < hBR)
    odesle_R = prijato_R / 10^(-hAR/10);
else
    odesle_R = prijato_R / 10^(-hBR/10);
end
    

% model kanálu pøi druhém pøenosu
datasum_RA = model_kanalu (odesle_R, SNR_AR, PnA);
datasum_RB = model_kanalu (odesle_R, SNR_BR, PnB);

% odeètení signálu u pøíjemce
datasum_A = datasum_RA - 10^(-hRA/10) * symboly_AR;
datasum_B = datasum_RB - 10^(-hRB/10) * symboly_BR;

% pokus o demodulaci
datanaA = demodulace (datasum_A, zvolmodul);
datanaB = demodulace (datasum_B, zvolmodul);

% Porovnání dat s pùvodními
chyby_A = sum(datanaB~=data_A);
chyby_B = sum(datanaA~=data_B);

end

