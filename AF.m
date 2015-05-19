function [ chyby_A, chyby_B ] = AF ( data_A, data_B, L1, L2, zvolmodul, Pn )
% Amplify-and-Forward


% Mapov�n� symbol�
symboly_AR = modul (data_A, zvolmodul);
symboly_BR = modul (data_B, zvolmodul);


% Modelov�n� kan�lu v�etn� �tlumu
prijato_R = model_kanalu2 (symboly_AR, symboly_BR, L1, L2, Pn);
% prijato_R = model_kanalu2 (symboly_AR, symboly_BR, 0, L2, Pn);


% Zes�len� sou�tu sign�l� na jednotkovou �rove�
zesil = sqrt( 1 / (L1^2 + L2^2 + Pn));        % Po��t� zes�len� pro v�kony nebo amplitudy?
odesle_R = zesil * prijato_R;

% model kan�lu p�i druh�m p�enosu
prijato_A = model_kanalu (odesle_R, L1, Pn);
prijato_B = model_kanalu (odesle_R, L2, Pn);   



% % Pro hled�n� chyby jsem to rozd�lil na jednotliv� operace
% �tlum trasy
utlumA = L1^2 * zesil;
utlumB = L2^2 * zesil;

% Ode��tan� sign�l
odecti_A = symboly_AR * utlumA;
odecti_B = symboly_BR * utlumB;

% Rozd�l sign�l�
rozdil_A = prijato_A - odecti_A;
rozdil_B = prijato_B - odecti_B;

% Zes�len� pro demodulaci
datasum_A = rozdil_A / L1;
datasum_B = rozdil_B / L2;


% % Vykreslov�n� konstela�n�ch diagram� na koncov�ch jednotk�ch
% figure(1)
% plot(real(prijato_A), imag(prijato_A),'.', real(odecti_A), imag(odecti_A),'o', real(rozdil_A), imag(rozdil_A),'*')
% legend('P�ijato','Ode�te se','po ode�ten�')
% title('Chyby B - p�ijato na A');
% 
% figure(2)
% plot(real(prijato_B), imag(prijato_B),'.', real(odecti_B), imag(odecti_B),'o', real(rozdil_B), imag(rozdil_B),'*')
% legend('P�ijato','Ode��tan�','po ode�ten�')
% title('Chyby A - p�ijato na B');


% P�vodn� �e�en� 
% % ode�ten� sign�lu u p��jemce
% datasum_A = (prijato_A - L1^2 * symboly_AR)/L1;        
% datasum_B = (prijato_B - L2^2 * symboly_BR)/L2;


% pokus o demodulaci
datanaA = demodulace (datasum_A, zvolmodul);
datanaB = demodulace (datasum_B, zvolmodul);

% Porovn�n� dat s p�vodn�mi
chyby_A = sum(datanaB~=data_A);
chyby_B = sum(datanaA~=data_B);

end

