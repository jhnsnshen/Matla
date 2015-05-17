function [ chyby_A, chyby_B ] = DNF ( data_A, data_B, L_A, L_B, zvolmodul, Pn  )
% Technika Denoise and Forward


% Mapov�n� symbol�
symboly_AR = modul (data_A, zvolmodul);
symboly_BR = modul (data_B, zvolmodul);

% Modelov�n� kan�lu a spole�n�ho p��jmu
datasum = model_kanalu2(symboly_AR, symboly_BR, L_A, L_B, Pn);

% if (hAR <= hBR)                              % Toto bude pot�eba vymyslet
%     prijato_R = datasum / 10^(-hBR/10);
% else
%     prijato_R = datasum / 10^(-hAR/10);
% end

% Odhad p�ijat�ch dat a p�evod na symboly
symboly_R = odhad (prijato_R, zvolmodul);

% Odesl�n� d�le
datasum_RA = model_kanalu(symboly_R, L_A, Pn);
datasum_RB = model_kanalu(symboly_R, L_B, Pn);

% Demodulace na konci
prijato_A = demodulace ( datasum_RA, zvolmodul);
prijato_B = demodulace ( datasum_RB, zvolmodul);

% XORov�n� p�ijat�ch dat s odeslan�mi
datanaA = xor(prijato_A, data_A);
datanaB = xor(prijato_B, data_B);

% pro QPSK je pot�eba v�sledek negovat
if zvolmodul == 2
    datanaA = ~datanaA;
    datanaB = ~datanaB;
end

% p�evzato z DF
chyby_A = sum(datanaA~=data_B);
chyby_B = sum(datanaB~=data_A);


end

