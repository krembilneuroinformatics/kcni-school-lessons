function [ RpeakTimes, TpeakTimes ] = tnueeg_heartbeats_hb_detection_fourier( ecgData, ecgTime, options )
%TNUEEG_HEARTBEATS_HB_DETECTION_FOURIER Detects R and T peak events in
%(noisy) ECG signal using the detection toolbox.
%   IN:     ecgData     - signal from the ECG channel
%           ecgTime     - the corresponding time axis
%           options     - the struct that holds all analysis options
%   OUT:    RpeakTimes  - peak times of R peaks (within-ECG time)
%           TpeakTimes  - peak times of T waves (within-ECG time)

%-- detection ------------------------------------------------------------%
[RpeakIdx, ~]   = RPeakDetection(ecgData, options.hb.samplingRate);
[TpeakIdx]      = detectTpeak(RpeakIdx, ecgData, options.hb.samplingRate);

RpeakTimes = ecgTime(RpeakIdx);
TpeakTimes = ecgTime(TpeakIdx);

end

