function [ numArtefacts, badChannels ] = tnueeg_count_artefacts( D )
%TNUEEG_COUNT_ARTEFACTS Counts bad trials in an EEG data set
%   This function counts the number of bad trials in a preprocessed EEG
%   data set and saves this number into a subject-specific file in the
%   preprocessing folder for later use in computing artefact statistics.
%   IN:     D               - EEG data set after artefact rejection
%   OUT:    numArtefacts    - number of bad trials in D
%           badChannels     - struct with number and names of bad channels in D

numArtefacts = numel(badtrials(D));

badChannels.numBadChannels = numel(badchannels(D));
badChannels.badChannelNames = badchannels(D);

end