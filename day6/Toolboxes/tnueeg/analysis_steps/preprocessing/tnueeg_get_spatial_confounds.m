function [ D ] = tnueeg_get_spatial_confounds( D, options )
%TNUEEG_GET_SPATIAL_CONFOUNDS Computes spatial confounds based on artefacts
%   Computes spatial confounds for artefact events such as eye blinks.
%   IN:     D       - epoched EEG data set according to artefact events
%           options - the struct that holds all analysis options
%   OUT:    D       - epoched EEG data set (still acc. to artefacts) with 
%                   spatial confounds

S = [];
S.D = D; 
S.method = 'SVD';
S.timewin = [-500 500];
S.ncomp = options.preproc.eyeconfoundcomps;

D = spm_eeg_spatial_confounds(S); 

end

