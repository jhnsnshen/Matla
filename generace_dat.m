function [data] = generace_dat (N)
    % generov�n� N bit� dat
    data=round(rand(N,1));
end

%     nuly=find(~data);  %nalezen� nulov�ch prvk�
%     data(nuly)=-1;     %p�i�azen� -1 nulov�m prvk�m
    

    %vykreslen� konstela�n�ho diagramu
    % figure(2)
    % plot(symboly,'o')
    % grid on;
