function [vystup]=gausuv (data,sigsum)

vystup = awgn(data, sigsum, 'measured');
end


