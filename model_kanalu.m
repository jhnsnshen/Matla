function [ datasum ] = model_kanalu( symboly, kanal, SNR, h )
    switch kanal
        case 1 % AWGN
            datasum = gausuv (h*symboly, SNR);
        case 2 % Rayleigh�v kan�l
            datasum = rayleigh (symboly, SNR);
    end

end

