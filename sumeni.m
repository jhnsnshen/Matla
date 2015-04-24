function [ sum ] = sumeni(a, k )
%Generov�n� Gaussova �umu. Do budoucna bude vstupn� argumentem SNR
if(~exist('a'))
    a = 50;
    k = 10;
end 
% b=numel(a);
b=a;
sumy=(randn(b,1)+1i*randn(b,1))/k;
mean(sqrt(sumy.^2))

end