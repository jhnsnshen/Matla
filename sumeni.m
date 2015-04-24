function [ sum ] = sumeni(a, k )
%Generování Gaussova šumu. Do budoucna bude vstupní argumentem SNR
if(~exist('a'))
    a = 50;
    k = 10;
end 
% b=numel(a);
b=a;
sumy=(randn(b,1)+1i*randn(b,1))/k;
mean(sqrt(sumy.^2))

end