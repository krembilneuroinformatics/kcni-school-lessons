function h = tnueeg_diagnostics_plot_hb_detection(ecgTime, ecgData, RpeakTimes, TpeakTimes, name)
%TNUEEG_DIAGNOSTICS_PLOT_HB_DETECTION Plots detected heartbeat events
%(R peaks or R and T peaks) onto the raw ECG signal used to detect them.
%   IN:     ecgTime     - time axis of ECG data
%           ecgData     - ECG data used for HB detection
%           RpeakTimes    - times of detected R peaks
%           TpeakTimes  - times of detected T peaks (optional)
%           name        - string indicating name of subject/data set

%-- check input ----------------------------------------------------------%
if nargin < 4
    name = '';
    TpeakTimes = [];
end

if nargin < 5 
    if ~isempty(TpeakTimes) && ischar(TpeakTimes)
        name = TpeakTimes;
        TpeakTimes = [];
    else
        name = '';
    end
end


%-- plot ECG events ------------------------------------------------------%
h = figure; hold on;

plot(ecgTime, ecgData, 'b');

RpeakAmplitudes = NaN(numel(RpeakTimes), 1);
for iRpeak = 1: numel(RpeakTimes)
    RpeakAmplitudes(iRpeak) = ecgData(ecgTime == RpeakTimes(iRpeak));
end
stem(RpeakTimes, RpeakAmplitudes, 'r');

if ~isempty(TpeakTimes)
    TpeakAmplitudes = NaN(numel(TpeakTimes), 1);
    for iTpeak = 1: numel(TpeakTimes)
        TpeakAmplitudes(iTpeak) = ecgData(ecgTime == TpeakTimes(iTpeak));
    end
    stem(TpeakTimes, TpeakAmplitudes, 'g');
    legend('ECG data', 'Fourier detected Rpeaks', 'Fourier detected Tpeaks');
else
    legend('ECG data', 'Fourier detected Rpeaks');
end

title(['Fourier detected heartbeat events for subject ' name ]);

end