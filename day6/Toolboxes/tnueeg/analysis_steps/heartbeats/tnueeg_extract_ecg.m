function [ecgData, ecgTime] = hbcnt_extract_ecg(D, evt, details, options)
%HBCNT_EXTRACT_ECG Extracts the ECG data from the EEG data set for further
%processing and heart beat detection.

% select all ECG data between first and last relevant EEG event
eegTime = time(D);
firstTriggerIdx = indsample(D, evt.eegStart);
lastTriggerIdx = indsample(D, evt.eegEnd);
ecgData = D(options.hb.channel, firstTriggerIdx:lastTriggerIdx, 1);

% in case subject has a reversed ECG
switch details.ecgflag
    case 'reversed'
        ecgData = -ecgData;
end

% select eeg time between these times
ecgTime = eegTime(firstTriggerIdx: lastTriggerIdx);
% set the starting time to zero
ecgTime = ecgTime - evt.eegStart;
  
% save ecg and corresponding time in matlab file
save(details.ecgfilemat, 'ecgData', 'ecgTime');

end
