function [ datasum ] = model_kanalu( symboly, L, Pn )
    nuly (numel(symboly),1) = (1+1j)*1e-6;
    sumik = awgn(nuly, 1/Pn, 1, 'linear');
    datasum = L * symboly + sumik;


%     nuly (numel(symboly),1) = (1+1j)*1e-3;
%     sum = awgn (nuly, Pnoise);
%     h = Pnoise - SNR;
%     data = 10^(-h/10) * symboly;
%     datasum = data + sum;
%    

end