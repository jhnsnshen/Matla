function [ vystup ] = qpsk( vstup)
if(~exist('vstup'))
    vstup = [1 1 0 1 0 0 1 0].' ;
end 


%pøevod na symboly QPSK

%rozdìlit vstupní data do dvou vektorù, které pak zas slouèím
%funkce numel, size a zbavit se pøedávání délky

nuly=find(~vstup);  %nalezení nulových prvkù
vstup(nuly)=-1;     %pøiøazení -1 nulovým prvkùm

M=numel(vstup);

a=vstup(1:2:M-1);
b=vstup(2:2:M);


vystup=(1/sqrt(2))*(a+1i*b);


end