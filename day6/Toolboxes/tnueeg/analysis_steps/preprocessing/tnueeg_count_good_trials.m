function nTrials = tnueeg_count_good_trials( D )
%TNUEEG_COUNT_GOOD_TRIALS Counts good trials in an EEG data set
%   This function counts the number of remaining good trials in a preprocessed EEG data set after 
%   artefact rejection, both overall and per condition in D.
%   IN:     D               - EEG data set after artefact rejection
%           details         - the struct that holds all paths and filenames
%   OUT:    numGoodTrials   - struct with number of good trials in D

numTrials = size(D, 3);
numBadTrials = numel(badtrials(D));
nTrials.all = numTrials - numBadTrials;

conLabels = condlist(D);
for iCon = 1: numel(conLabels)
    nTrials.(conLabels{iCon}) = numel(indtrial(D, conLabels{iCon}, 'GOOD'));
end

end