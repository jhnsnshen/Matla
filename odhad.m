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

%         (data (abs(real(data))) >= 1 && data (abs(imag(data)) >= 1)) = r*(1+i); % PH
%         (data (abs(real(data))) > 1 && data (abs(imag(data)) < 1)) = r*(1-i);   % PD
%         (data (abs(real(data))) < 1 && data (abs(imag(data)) < 1)) = r*(1-i);   % LD
%         (data (abs(real(data))) > 1 && data (abs(imag(data)) > 1)) = r*(1-i);   % LH      





%         a = data (abs(real(data)) >= 1);
%         b = data (abs(imag(data)) >= 1);
%         
%         kv1 = a .* b;
%         kv2 = and (~a,b);
%         kv3 = and (~a,~b);
%         kv4 = and (a,~b);
%         
%         data (kv1) = r (1+1i);
%         data (kv2) = r (-1+1i);
%         data (kv3) = r (-1-1i);
%         data (kv4) = r (1-1i);
