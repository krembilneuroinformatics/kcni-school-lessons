function [ D ] = tnueeg_reject_eyeblink_artefacts( D, options )
%TNUEEG_REJECT_EYEBLINK_ARTEFACTS Detects and rejects trials with eyeblinks
%as detected by simple thresholding of the EOG channel.
%   This function calls on a simple artefact detection routine (channel
%   thresholding) in SPM and rejects the trials that were marked as bad
%   (amplitude exceeding S.methods.settings.threshold).
%   Channels with a proportion of more than S.badchantresh bad trials are
%   marked as bad channels.
%   IN:     D       - epoched EEG data set
%           options - the struct that holds all analysis options
%   OUT:    D       - epoched EEG data set with flags for bad trials


S.D = D;
S.mode = 'reject';
S.badchanthresh = options.preproc.eyebadchanthresh;

S.methods.settings.whatevents.artefacts = 1;
S.methods.channels = {'EOG'};
S.methods.fun = 'events';
S.append = 1; 
% 1: if other artefact detection has already been applied, 
% this routine will add the new bad trials and channels to the dataset
% 0: previous bad trials & channels will be discarded
S.prefix = 'a';

D = spm_eeg_artefact(S);

if ~options.preproc.keep
    delete(S.D);
end


end

