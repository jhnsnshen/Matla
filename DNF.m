function [ chyby_A, chyby_B, sloty ] = DNF ( data_A, data_B, h_A, h_B, SNR_AR, SNR_BR, kanal, zvolmodul )
% Technika Denoise and Forward

% Mapov�n� symbol�
symboly_AR = modul (data_A, zvolmodul);
symboly_BR = modul (data_B, zvolmodul);

% Modelov�n� kan�lu v�etn� �tlumu
datasum_AR = model_kanalu (symboly_AR,kanal, SNR_AR, h_A);
datasum_BR = model_kanalu (symboly_BR,kanal, SNR_BR, h_B);

% P��jem na Relayi, sou�et a zes�len� celkov�ho sign�lu
prijato_R = datasum_AR/h_A + datasum_BR/h_B;
symboly_R = odhad (prijato_R, zvolmodul);

% Odesl�n� d�le
datasum_RA = model_kanalu(symboly_R, kanal, SNR_AR, h_A);
datasum_RB = model_kanalu(symboly_R, kanal, SNR_BR, h_B);

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

% pou�it� timesloty
sloty = 2*numel(data_A);

end

