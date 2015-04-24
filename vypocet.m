function [ BER, through ] = vypocet( data_Ac, data_Bc, h_A, h_B, SNR_AR, SNR_BR, kanal, zvolmodul, NC )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

BER_A = 0;
BER_B = 0;
cas = 0;
%%%%%%%%%% Samotné øešení

% Rozsekání bitù na pakety   bude potøeba asi ošetøit poslední paket, pokud
% nemá 50 bitù
R = 50;  % délka paketu v bitech
r = floor (numel(data_Ac)/R); % urèení poètu paketù
for s=1:r
    
    data_A = data_Ac((R*(s-1)+1):R*s);
    data_B = data_Bc((R*(s-1)+1):R*s);

    
    
    %% Techniky Network codingu
    switch NC
        case 1 % Routování
            [chybaA,chybaB, sloty] = routovani(data_A, data_B, h_A, h_B, SNR_AR, SNR_BR, kanal, zvolmodul );
            
        case 2 % Decode and Forward
            [chybaA,chybaB, sloty] = DF(data_A, data_B, h_A, h_B, SNR_AR, SNR_BR, kanal, zvolmodul );
            
        case 3 % Amplify and Forward
            [chybaA,chybaB, sloty] = AF(data_A, data_B, h_A, h_B, SNR_AR, SNR_BR, kanal, zvolmodul );
            
        case 4 % Denoise and Forward
            [chybaA,chybaB, sloty] = DNF(data_A, data_B, h_A, h_B, SNR_AR, SNR_BR, kanal, zvolmodul );

    end
    
    
    %     find(demod_A-data_A);
    %     chyby_A = sum(demod_A~=data_A);
    %     chyby_B = sum(demod_B~=data_B);
    
    % Vyhodnocení chybovosti
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

