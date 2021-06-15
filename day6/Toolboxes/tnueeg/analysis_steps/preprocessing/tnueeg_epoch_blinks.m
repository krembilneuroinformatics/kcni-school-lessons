function [ D ] = tnueeg_epoch_blinks( D, options )
%TNUEEG_EPOCH_BLINKS Epochs EEG data with respect to eye blink event
%   Cuts the EEG data into 1000 ms epochs around each eye blink event.
%   IN:     D       - continuous EEG data set with marked blink events
%           options - the struct that holds all analysis options
%   OUT:    D       - epoched EEG data set according to eye blink events

S = [];
S.D = D;
S.timewin = [-500 500];

S.trialdef.conditionlabel = 'eyeblink';
S.trialdef.eventtype = 'artefact_eyeblink';
S.trialdef.eventvalue = char(options.preproc.eyeblinkchannels);
S.trialdef.trlshift = 0;
S.bc = 0;
S.prefix = 'EB';
S.eventpadding = 0;

D = spm_eeg_epochs(S); 

if ~options.preproc.keep
    delete(S.D);
end


end

