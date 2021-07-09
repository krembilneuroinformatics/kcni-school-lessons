function [ RpeakTimes, TpeakTimes ] = hbcnt_hb_detection_fourier( id )

global OPTIONS
details = hbcnt_subjects(id);

load(details.eegevents);
load(details.ecgfilemat);

% detection
[RpeakIdx, ~] = RPeakDetection(ecgData, OPTIONS.hb.samplingRate);
[TpeakIdx] = detectTpeak(RpeakIdx, ecgData, OPTIONS.hb.samplingRate);

RpeakTimes = ecgTime(RpeakIdx);
TpeakTimes = ecgTime(TpeakIdx);

% plot
h = figure; hold on;
plot(ecgTime, ecgData, 'b');
stem(RpeakTimes, ecgData(RpeakIdx), 'r');
stem(TpeakTimes, ecgData(TpeakIdx), 'g');
legend('ECG data', 'Fourier detected Rpeaks', 'Fourier detected Tpeaks');
title(['Fourier detected Rpeaks for subject ' id ]);
savefig(h, details.hbdetectfig);

% to use HBs as EEG events
RpeakTimes = RpeakTimes + evt.eegStart;
TpeakTimes = TpeakTimes + evt.eegStart;

% save both
hbTimes = RpeakTimes;
save([details.preproot 'HBs_Rfourier.mat'], 'hbTimes');
hbTimes = TpeakTimes;
save([details.preproot 'HBs_Twave.mat'], 'hbTimes');

end