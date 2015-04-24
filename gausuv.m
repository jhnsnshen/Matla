function [vystup]=gausuv (data,sigsum)
% H = comm.AWGNChannel('NoiseMethod','Signal to noise ratio (SNR)','SNR',sigsum); %,'BitsPerSymbol',2);
% vystup = step (H,data);

vystup = awgn(data, sigsum, 'measured');
end


