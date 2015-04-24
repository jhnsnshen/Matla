function [vystup] = bpsk ( vstup )
if(~exist('vstup'))
    vstup = [0 0 1 1 0 0 0].' ;
end 

    nuly=find(~vstup);  %nalezení nulových prvkù
    vstup(nuly)=-1;     %pøiøazení -1 nulovým prvkùm
    vystup = vstup;
end