function [ data ] = demodulace( symboly, modul )

if(~exist('symboly'))
    %symboly = [[0.672 - 0.704i;-0.522 + 0.960i;-0.577 + 0.813i;-0.7007 + 0.773i;-0.867 - 1.168i;0.731 + 0.658i;]] ;
    symboly = [0.672 ;-0.522 ;-0.577 ;-0.7007 ;-0.867 ;- 1.168 ;0.731 ; 0.658] ;
    modul=1;
end


N = numel (symboly);

switch modul
    case 1 % BPSK
        for k=1:N
            if symboly(k) > 0
                symboly(k)=1;
            else
                symboly(k) = -1;
            end
        end
        data = (symboly + 1) / 2;
        
    case 2 % QPSK
        a = sqrt(2)*real (symboly);
        
        %         a(a>0) = 1
        %         a(a<=0) = -1
        for k=1:(N)
            if a(k)>0
                a(k) = 1;
            else
                a(k) = -1;
            end
        end
        
        b = sqrt(2)*imag (symboly);
        
        for k=1:(N)
            if b(k)>0
                b(k) = 1;
            else
                b(k) = -1;
            end
            
            
        end
        
        a = (a + 1) / 2;
        b = (b + 1) / 2;
        data = reshape([a b]',2*size(a,1), []);
        
end
end
   