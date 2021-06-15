function [ecgData, ecgTime] = tnueeg_heartbeats_extract_ecg(D, evt, options)
%TNUEEG_HEARTBEATS_EXTRACT_ECG Extracts the ECG data from the EEG data set 
%for further processing and heart beat detection.
%   IN:     D
%           evt     - 
%           options - 
%   OUT:    ecgData - 
%           ecgTime -

% select all ECG data between first and last relevant EEG event
eegTime         = time(D);
firstTriggerIdx = indsample(D, evt.eegStart);
lastTriggerIdx  = indsample(D, evt.eegEnd);
ecgData         = D(options.hb.channel, firstTriggerIdx:lastTriggerIdx, 1);

% select eeg time between these times
ecgTime = eegTime(firstTriggerIdx: lastTriggerIdx);
% set the starting time to zero
ecgTime = ecgTime - evt.eegStart;
  
end
