function [ datasum ] = model_kanalu2( symboly1, h1, symboly2, h2, Pnoise )
    nuly (numel(symboly1),1) = 0+.01j;
%     nuly = zeros(numel(symboly1),1);
    sum = awgn (nuly, Pnoise);
    
    data1 = 10^(-abs(h1)/10) * symboly1;
    data2 = 10^(-abs(h2)/10) * symboly2;
    datasum = data1 + data2  + sum;
end