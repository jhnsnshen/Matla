function [ chyby_A, chyby_B] = AF ( data_A, data_B, h_A, h_B, SNR_AR, SNR_BR, kanal, zvolmodul )
% Amplify-and-Forward

% Mapování symbolù
symboly_AR = modul (data_A, zvolmodul);
symboly_BR = modul (data_B, zvolmodul);

% % Souèet symbolù pro relay
% h_R = 1;
% signal_R = h_A*symboly_AR + h_B * symboly_BR;
% datasum_R = model_kanalu(signal_R, kanal,

% Modelování kanálu vèetnì útlumu
% nelze modelovat šum spoleènì, protože každý z kanálù má odlišné SNR
datasum_AR = model_kanalu (symboly_AR,kanal, SNR_AR, h_A);
datasum_BR = model_kanalu (symboly_BR,kanal, SNR_BR, h_B);

% Pøíjem na Relayi, souèet a zesílení celkového signálu
prijato_R = datasum_AR + datasum_BR;

if (h_A > h_B)
    odesle_R = prijato_R / h_B;
elseif (h_A < h_B)
    odesle_R = prijato_R / h_A;
else
    odesle_R = prijato_R / h_B;
end
    

% model kanálu pøi druhém pøenosu
datasum_RB = model_kanalu (odesle_R, kanal, SNR_BR, h_B);
datasum_RA = model_kanalu (odesle_R, kanal, SNR_AR, h_A);

% odeètení signálu u pøíjemce
datasum_A = datasum_RA - h_A * symboly_AR;
datasum_B = datasum_RB - h_B * symboly_BR;

% pokus o demodulaci
datanaA = demodulace (datasum_A, zvolmodul);
datanaB = demodulace (datasum_B, zvolmodul);

% Porovnání dat s pùvodními
chyby_A = sum(datanaB~=data_A);
chyby_B = sum(datanaA~=data_B);
end

