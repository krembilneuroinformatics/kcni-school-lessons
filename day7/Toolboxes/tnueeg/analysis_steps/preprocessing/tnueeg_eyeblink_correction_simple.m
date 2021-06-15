function [ D ] = tnueeg_eyeblink_correction_simple( D, options )
%TNUEEG_EYEBLINK_CORRECTION_SIMPLE Corrects EEG signal in all epochs
%based on the scalp distribution of previously detected major eyeblinks.
%   This function applies a precursor of the Berg & Scherg (1994) eye blink correction 
%   algorithm to an epoched EEG data set with spatial confounds for eye 
%   blinks. In this version, the brain sources will not be taken into 
%   account - a simple projection of the estimated eye sources (based 
%   solely on the eye confounds matrix) will be subtracted from the EEG 
%   signal in each epoch. 
%   IN:     D       - EEG data set with spatial confounds for eye blinks
%           options - the struct that holds all analysis options
%   OUT:    D       - corrected EEG data set

S = [];
S.D = D;
S.correction = 'SSP';
S.prefix = 'c';

D = spm_eeg_correct_sensor_data(S);

if ~options.preproc.keep
    S.D = reload(S.D);
    delete(fullfile(S.D.path, S.D.inv{1}.gainmat));
    delete(S.D);
end


end

