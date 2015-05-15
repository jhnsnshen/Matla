function [ datasum ] = model_kanalu2( symboly1, symboly2, L1, L2, Pn )
    nuly (numel(symboly1),1) = (1+1j)*1e-6;
    sumik = awgn(nuly, 1/Pn, 1, 'linear');
    
    
    data1 = L1 .* symboly1;
    data2 = L2 .* symboly2;
    datasum = data1 + data2  + sumik;
end