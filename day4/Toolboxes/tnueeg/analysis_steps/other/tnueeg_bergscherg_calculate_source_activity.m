function srcAct = tnueeg_bergscherg_calculate_source_activity(D, invMat)
%TNUEEG_BERGSCHERG_CALCULATE_SOURCE_ACTIVITY Calculates the trialwise source
%waveforms of artifact/confounding sources, given the channel data and the
%inverse of the lead field matrix for these sources.
%   IN:     D       - M/EEG data set (epoched or continuous)
%           invMat  - the inverse of the projection matrix from sources to
%                   channels (invMat: nSources x nChannels)
%   OUT:    srcAct  - (trialwise) source waveforms

nTrials = D.ntrials;
nSamples = D.nsamples;
chanind = indchantype(D, 'EEG', 'GOOD');
nSources = size(invMat, 1);

srcAct = NaN(nSources, nSamples, nTrials);

% calculate source activity
for iTrial = 1: nTrials
    srcAct(:, :, iTrial) = invMat * squeeze(D(chanind, :, iTrial));                    
end

end