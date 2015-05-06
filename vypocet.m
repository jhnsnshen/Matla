function [ BER ] = vypocet( data_Ac, data_Bc, SNR_AR, SNR_BR, kanal, zvolmodul, NC, PnA, PnR, PnB )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

BER_A = 0;
BER_B = 0;
cas = 0;
%%%%%%%%%% Samotné øešení

% Rozsekání bitù na pakety
% nekompletní paket bude zahozený
R = 50;  % délka paketu v bitech
r = floor (numel(data_Ac)/R); % urèení poètu paketù
for s=1:r
    
    data_A = data_Ac((R*(s-1)+1):R*s);
    data_B = data_Bc((R*(s-1)+1):R*s);

    
    
    %% Techniky Network codingu
    switch NC
        case 1 % Routování
            [chybaA,chybaB] = routovani(data_A, data_B, SNR_AR, SNR_BR, zvolmodul, PnA, PnR, PnB );
            
        case 2 % Decode and Forward
            [chybaA,chybaB] = DF(data_A, data_B, SNR_AR, SNR_BR, zvolmodul, PnA, PnR, PnB );
            
        case 3 % Amplify and Forward
            [chybaA,chybaB] = AF(data_A, data_B, SNR_AR, SNR_BR, zvolmodul, PnA, PnR, PnB );
            
        case 4 % Denoise and Forward
            [chybaA,chybaB] = DNF(data_A, data_B, SNR_AR, SNR_BR, kanal, zvolmodul, PnA, PnR, PnB );

    end
    
    
    % Vyhodnocení chybovosti
    BER_A = BER_A + chybaA;
    BER_B = BER_B + chybaB;

end

BER_A = BER_A / numel (data_Ac);
BER_B = BER_B / numel (data_Bc);


BER = [BER_A BER_B (BER_A+BER_B)];


end

