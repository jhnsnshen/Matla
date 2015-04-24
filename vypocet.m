function [ BER, through ] = vypocet( data_Ac, data_Bc, h_A, h_B, SNR_AR, SNR_BR, kanal, zvolmodul, NC )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

BER_A = 0;
BER_B = 0;
cas = 0;
%%%%%%%%%% Samotn� �e�en�

% Rozsek�n� bit� na pakety   bude pot�eba asi o�et�it posledn� paket, pokud
% nem� 50 bit�
R = 100;  % d�lka paketu v bitech
r = floor (numel(data_Ac)/R); % ur�en� po�tu paket�
for s=1:r
    
    data_A = data_Ac((R*(s-1)+1):R*s);
    data_B = data_Bc((R*(s-1)+1):R*s);

    
    
    %% Techniky Network codingu
    switch NC
        case 1 % Routov�n�
            [chybaA,chybaB] = routovani(data_A, data_B, h_A, h_B, SNR_AR, SNR_BR, kanal, zvolmodul );
            
        case 2 % Decode and Forward
            [chybaA,chybaB] = DF(data_A, data_B, h_A, h_B, SNR_AR, SNR_BR, kanal, zvolmodul );
            
        case 3 % Amplify and Forward
            [chybaA,chybaB] = AF(data_A, data_B, h_A, h_B, SNR_AR, SNR_BR, kanal, zvolmodul );
            
        case 4 % Denoise and Forward
            [chybaA,chybaB] = DNF(data_A, data_B, h_A, h_B, SNR_AR, SNR_BR, kanal, zvolmodul );

    end
    
    
    %     find(demod_A-data_A);
    %     chyby_A = sum(demod_A~=data_A);
    %     chyby_B = sum(demod_B~=data_B);
    
    % Vyhodnocen� chybovosti
    BER_A = BER_A + chybaA;
    BER_B = BER_B + chybaB;
    
    % propustnost
    cas = cas + sloty;
    
    
end

BER_A = BER_A / numel (data_Ac);
BER_B = BER_B / numel (data_Bc);


BER = [BER_A BER_B (BER_A+BER_B)];
through = cas;

end

