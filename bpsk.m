function [vystup] = bpsk ( vstup )
if(~exist('vstup'))
    vstup = [0 0 1 1 0 0 0].' ;
end 

    nuly=find(~vstup);  %nalezen� nulov�ch prvk�
    vstup(nuly)=-1;     %p�i�azen� -1 nulov�m prvk�m
    vystup = vstup;
end