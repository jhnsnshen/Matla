function [ chyby_A, chyby_B ] = AF ( data_A, data_B, L1, L2, zvolmodul, Pn )
% Amplify-and-Forward


% Mapov�n� symbol�
symboly_AR = modul (data_A, zvolmodul);
symboly_BR = modul (data_B, zvolmodul);


% Modelov�n� kan�lu v�etn� �tlumu
prijato_R = model_kanalu2 (symboly_AR, symboly_BR, L1, L2, Pn);



% Zes�len� sou�tu sign�l� na jednotkovou �rove�
zesil = sqrt( 1 / (L1^2 + L2^2 + Pn^2));        %Po��t� zes�len� pro v�kony?
odesle_R = zesil * prijato_R;

% model kan�lu p�i druh�m p�enosu
datasum_RA = model_kanalu (odesle_R, L1, Pn);
datasum_RB = model_kanalu (odesle_R, L2, Pn);

% ode�ten� sign�lu u p��jemce
datasum_A = (datasum_RA - L1^2 * symboly_AR)/L1;
datasum_B = (datasum_RB - L2^2 * symboly_BR)/L2;

% pokus o demodulaci
datanaA = demodulace (datasum_A, zvolmodul);
datanaB = demodulace (datasum_B, zvolmodul);

% Porovn�n� dat s p�vodn�mi
chyby_A = sum(datanaB~=data_A);
chyby_B = sum(datanaA~=data_B);

end

