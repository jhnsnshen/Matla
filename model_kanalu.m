function [ datasum ] = model_kanalu( symboly, kanal, SNR, Pnoise )
    nuly (numel(symboly),1) = 1+1j;
    sum = awgn (nuly, -Pnoise, 0);
    h = -SNR - Pnoise;
    datasum = 10^(-h/10) * symboly + sum;
    

%     switch kanal
%         case 1 % AWGN
%             datasum = gausuv (10^(-h/10) * symboly, SNR);
%         case 2 % Rayleighùv kanál
%             datasum = rayleigh (symboly, SNR);
%     end

end