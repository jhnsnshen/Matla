function [ vystup ] = qpsk( vstup)
if(~exist('vstup'))
    vstup = [1 1 0 1 0 0 1 0].' ;
end 


%p�evod na symboly QPSK

%rozd�lit vstupn� data do dvou vektor�, kter� pak zas slou��m
%funkce numel, size a zbavit se p�ed�v�n� d�lky

nuly=find(~vstup);  %nalezen� nulov�ch prvk�
vstup(nuly)=-1;     %p�i�azen� -1 nulov�m prvk�m

M=numel(vstup);

a=vstup(1:2:M-1);
b=vstup(2:2:M);


vystup=(1/sqrt(2))*(a+1i*b);


end