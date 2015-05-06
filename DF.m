function [ chyby_A, chyby_B ] = DF( data_A, data_B, SNR_AR, SNR_BR, zvolmodul, PnA, PnR, PnB )
% Metoda Decode and Forward

% Mapování symbolù
symboly_AR = modul (data_A, zvolmodul);
symboly_BR = modul (data_B, zvolmodul);

% Modelování kanálu vèetnì útlumu
datasum_AR = model_kanalu (symboly_AR, SNR_AR, PnR);
datasum_BR = model_kanalu (symboly_BR, SNR_BR, PnR);
   
% Demodulace na Relayi a odeslání dále  - data z A/B
datazA = demodulace (datasum_AR,zvolmodul);
datazB = demodulace (datasum_BR,zvolmodul);

% výstupem operace XOR je datový typ logical, pøiètením nuly se pøevede
% zpìt na double pro správnou interpretaci výsledkù
datanaR_log = xor( datazA, datazB);
datanaR = datanaR_log + 0;

% Symboly na R
symboly_R = modul (datanaR, zvolmodul);


% model kanálu pøi druhém pøenosu
datasum_RB = model_kanalu (symboly_R, SNR_BR, PnB);
datasum_RA = model_kanalu (symboly_R, SNR_AR, PnA);

% Demodulace na koncových stanicích
datanaB = demodulace (datasum_RB, zvolmodul);
datanaA = demodulace (datasum_RA, zvolmodul);


% Získání pùvodních dat pomocí XOR
vysledek_A = xor (data_B, datanaB);
vysledek_B = xor (data_A, datanaA);


% Porovnání dat s pùvodními
chyby_A = sum(vysledek_A~=data_A);
chyby_B = sum(vysledek_B~=data_B);


end
