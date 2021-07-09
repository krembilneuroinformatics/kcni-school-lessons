function [ D ] = tnueeg_correct_eyeblinks( D, options )
%TNUEEG_CORRECT_EYEBLINKS Corrects EEG signal in trials with eye blinks
%   This function applies the Berg & Scherg (1994) eye blink correction 
%   algorithm to an epoched EEG data set with spatial confounds for eye 
%   blinks.
%   IN:     D       - EEG data set with spatial confounds for eye blinks
%           options - the struct that holds all analysis options
%   OUT:    D       - corrected EEG data set

S = [];
S.D = D;
S.correction = 'Berg';
S.prefix = 'c';

D = spm_eeg_correct_sensor_data(S);

if ~options.preproc.keep
    S.D = reload(S.D);
    delete(fullfile(S.D.path, S.D.inv{1}.gainmat));
    delete(S.D);
end


end

