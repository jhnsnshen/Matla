function [ vystup ] = odhad( data, zvolmodul )
% Oddìlenì pro BPSK / QPSK

r=1/sqrt(2);

switch zvolmodul
    case 1
        data (abs(data)>=1) = -1;
        data (abs(data)<1) = 1;
    case 2
        data ((abs(real(data)) >= 1) & (abs(imag(data)) >= 1)) = (1+1i); % PH
        data ((abs(real(data)) < 1) & (abs(imag(data)) > 1)) = (-1+1i);  % LH
        data ((abs(real(data)) < 1) & (abs(imag(data)) < 1)) = (-1-1i);  % LD
        data ((abs(real(data)) > 1) & (abs(imag(data)) < 1)) = (1-1i);   % PD

end

vystup = r * data;
end

