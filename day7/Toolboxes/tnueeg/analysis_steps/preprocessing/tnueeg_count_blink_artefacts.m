function numEyeblinks = tnueeg_count_blink_artefacts( D )
%TNUEEG_COUNT_BLINK_ARTEFACTS Counts number of detected eye blinks
%   This function counts the number of detected eye blinks in an EEG
%   data set for later use in computing artefact statistics.
%   IN:     D               - EEG data set after eye blink detection
%   OUT:    numEyeblinks    - number of detected eye blinks in D

ev = events(D);
numEyeblinks = 0;

for i = 1: numel(ev)
    if strcmp(ev(i).type, 'artefact_eyeblink')
        numEyeblinks = numEyeblinks + 1;
    end
end


end