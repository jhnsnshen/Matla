function [ chyby_A, chyby_B ] = DF( data_A, data_B, L_A, L_B, zvolmodul, Pn )
% Metoda Decode and Forward

% Mapov�n� symbol�
symboly_AR = modul (data_A, zvolmodul);
symboly_BR = modul (data_B, zvolmodul);

% Modelov�n� kan�lu v�etn� �tlumu
datasum_AR = model_kanalu (symboly_AR, L_A, Pn);
datasum_BR = model_kanalu (symboly_BR, L_B, Pn);
   
% Demodulace na Relayi a odesl�n� d�le  - data z A/B
datazA = demodulace (datasum_AR,zvolmodul);
datazB = demodulace (datasum_BR,zvolmodul);

% v�stupem operace XOR je datov� typ logical, p�i�ten�m nuly se p�evede
% zp�t na double pro spr�vnou interpretaci v�sledk�
datanaR_log = xor( datazA, datazB);
datanaR = datanaR_log + 0;

% Symboly na R
symboly_R = modul (datanaR, zvolmodul);


% model kan�lu p�i druh�m p�enosu
datasum_RB = model_kanalu (symboly_R, L_B, Pn );
datasum_RA = model_kanalu (symboly_R, L_A, Pn);

% Demodulace na koncov�ch stanic�ch
datanaB = demodulace (datasum_RB, zvolmodul);
datanaA = demodulace (datasum_RA, zvolmodul);


% Z�sk�n� p�vodn�ch dat pomoc� XOR
vysledek_A = xor (data_B, datanaB);
vysledek_B = xor (data_A, datanaA);


% Porovn�n� dat s p�vodn�mi
chyby_A = sum(vysledek_A~=data_A);
chyby_B = sum(vysledek_B~=data_B);


end
