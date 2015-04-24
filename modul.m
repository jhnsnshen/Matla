function [ symboly ] = modul( data, modulace )
% Mapování dat dle vybraného modulaèního schématu

    switch modulace
        case 1
            symboly = bpsk(data);
        case 2
            symboly = qpsk(data);
        otherwise
            symboly = bpsk(data);
    end

end

