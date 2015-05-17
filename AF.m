function [ chyby_A, chyby_B ] = AF ( data_A, data_B, L1, L2, zvolmodul, Pn )
% Amplify-and-Forward


% Mapování symbolù
symboly_AR = modul (data_A, zvolmodul);
symboly_BR = modul (data_B, zvolmodul);


% Modelování kanálu vèetnì útlumu
prijato_R = model_kanalu2 (symboly_AR, symboly_BR, L1, L2, Pn);



% Zesílení souètu signálù na jednotkovou úroveò
zesil = sqrt( 1 / (L1^2 + L2^2 + Pn^2));        %Poèítá zesílení pro výkony?
odesle_R = zesil * prijato_R;

% model kanálu pøi druhém pøenosu
datasum_RA = model_kanalu (odesle_R, L1, Pn);
datasum_RB = model_kanalu (odesle_R, L2, Pn);

% odeètení signálu u pøíjemce
datasum_A = (datasum_RA - L1^2 * symboly_AR)/L1;
datasum_B = (datasum_RB - L2^2 * symboly_BR)/L2;

% pokus o demodulaci
datanaA = demodulace (datasum_A, zvolmodul);
datanaB = demodulace (datasum_B, zvolmodul);

% Porovnání dat s pùvodními
chyby_A = sum(datanaB~=data_A);
chyby_B = sum(datanaA~=data_B);

end

