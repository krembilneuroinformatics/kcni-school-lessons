function [idxTPeak] = detectTpeak(idxRPeak, ecg, samplingrate)

idxTPeak = [];
durwindow1 = 0.05; % this is in s; no. of samples depends on sampling rate (Hz)
durwindow2 = 0.4; % this is in s; no. of samples depends on sampling rate (Hz)
window1 = ceil(durwindow1 * samplingrate); % no. of samples
window2 = ceil(durwindow2 * samplingrate); % no. of samples


for iPeaks = 1:length(idxRPeak)-1
       [val, idx] = max(ecg(idxRPeak(iPeaks)+ window1: idxRPeak(iPeaks+1)-window2));
       idxTPeak(iPeaks) = idx + window1 -1 + idxRPeak(iPeaks);
end
    
figure, hold on, plot(ecg);
plot(idxTPeak, ecg(idxTPeak),'ro')
plot(idxRPeak, ecg(idxRPeak),'go')

end