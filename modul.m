function [ symboly ] = modul( data, modulace )
% Mapov�n� dat dle vybran�ho modula�n�ho sch�matu

    switch modulace
        case 1
            symboly = bpsk(data);
        case 2
            symboly = qpsk(data);
        otherwise
            symboly = bpsk(data);
    end

end

