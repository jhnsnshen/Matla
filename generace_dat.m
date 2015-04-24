function [data] = generace_dat (N)
    % generování N bitù dat
    data=round(rand(N,1));
end

%     nuly=find(~data);  %nalezení nulových prvkù
%     data(nuly)=-1;     %pøiøazení -1 nulovým prvkùm
    

    %vykreslení konstelaèního diagramu
    % figure(2)
    % plot(symboly,'o')
    % grid on;
