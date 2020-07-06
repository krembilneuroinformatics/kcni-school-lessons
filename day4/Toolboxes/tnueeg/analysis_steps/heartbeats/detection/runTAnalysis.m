function runTAnalysis(D)

myTime = time(D);
ecg = D(65,:,1);
samplingrate = 500;

% Find RPeaks
[idxRPeak, peaks2] = RPeakDetection(ecg, samplingrate);

% Find TPeaks
[idxTPeak] = detectTpeak(idxRPeak, ecg, samplingrate);

% Find RtoT
[diffRT] = calcTtoR(idxRPeak(1:end-1), idxTPeak, myTime);

% plot
plotRTECG(idxTPeak, ecg)