function [ datasum ] = model_kanalu2( symboly1, h1, symboly2, h2, Pnoise )
    nuly (numel(symboly1),1) = 1+1j;
%     nuly = zeros(numel(symboly1),1);
    sum = awgn (nuly, -Pnoise);
    
    datasum = 10^(-h1/10) * symboly1 + 10^(-h2/10) * symboly2 + sum;
end