function [ datasum ] = model_kanalu( symboly, SNR, Pnoise )
    nuly (numel(symboly),1) = (1+1j)*1e-3;
    sum = awgn (nuly, Pnoise);
    h = Pnoise - SNR;
    data = 10^(-h/10) * symboly;
    datasum = data + sum;
   

%     switch kanal
%         case 1 % AWGN
%             datasum = gausuv (10^(-h/10) * symboly, SNR);
%         case 2 % Rayleighùv kanál
%             datasum = rayleigh (symboly, SNR);
%     end

end