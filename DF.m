function [ chyby_A, chyby_B, sloty ] = DF( data_A, data_B, h_A, h_B, SNR_AR, SNR_BR, kanal, zvolmodul )
% Metoda Decode and Forward

% Mapování symbolù
symboly_AR = modul (data_A, zvolmodul);
symboly_BR = modul (data_B, zvolmodul);

% Modelování kanálu vèetnì útlumu
datasum_AR = model_kanalu (symboly_AR,kanal, SNR_AR, h_A);
datasum_BR = model_kanalu (symboly_BR,kanal, SNR_BR, h_B);
   
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
datasum_RB = model_kanalu (symboly_R, kanal, SNR_BR, h_B);
datasum_RA = model_kanalu (symboly_R, kanal, SNR_AR, h_A);

% Demodulace na koncových stanicích
datanaB = demodulace (datasum_RB, zvolmodul);
datanaA = demodulace (datasum_RA, zvolmodul);


% Získání pùvodních dat pomocí XOR
vysledek_A = xor (data_B, datanaB);
vysledek_B = xor (data_A, datanaA);


% Porovnání dat s pùvodními
chyby_A = sum(vysledek_A~=data_A);
chyby_B = sum(vysledek_B~=data_B);

% použité timesloty
sloty = 3*numel(data_A);

% % Výpoèet BER
% BER_A = chyby_A / (numel(data_A));
% BER_B = chyby_B / (numel(data_B));

end
