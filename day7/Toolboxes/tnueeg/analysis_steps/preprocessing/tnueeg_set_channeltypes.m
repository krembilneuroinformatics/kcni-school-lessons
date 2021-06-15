function [ D ] = tnueeg_set_channeltypes( D, chandef, options )
%TNUEEG_SET_CHANNELTYPES Sets the type (EEG, EOG, ...) of channels
%   Use this function to tell SPM which channels in your dataset D are of
%   which type. 
%   IN:     D       - EEG data set
%           chandef - a struct that needs to contain the following:
%                     - one field per channeltype (e.g. chandef{1}.type = 'EOG')
%                     - all indices of sensors of that type (e.g. 
%                       chandef{1}.ind = [65 66])
%                     Possible channel types include: EEG, MEG, EOG, ECG, 
%                     EMG, LFP, REF, Other, ... (see spm_eeg_prep or GUI)
%           options - the struct that holds all analysis options
%   OUT:    D       - EEG data set with new channeltypes

S.task = 'settype';
if options.preproc.keep 
   S.save = 1;
end

for typ = 1: numel(chandef)
    S.D = D;
    S.type = chandef{typ}.type;
    S.ind = chandef{typ}.ind;

    D = spm_eeg_prep(S);
end

end

