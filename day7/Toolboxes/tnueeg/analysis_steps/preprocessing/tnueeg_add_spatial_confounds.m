function [ D ] = tnueeg_add_spatial_confounds( D, Da, options )
%TNUEEG_ADD_SPATIAL_CONFOUNDS Adds spatial confounds to an EEG data set
%   This function adds spatial confounds that have been computed for 
%   artefact events (e.g. eyeblinks) in the epoched data set Da to the
%   epoched data set D.
%   IN:     D       - epoched EEG data set (acc. to exp. trials)
%           Da      - epoched EEG data set (acc. to artefacts)
%           options - the struct that holds all analysis options
%   OUT:    D       - EEG data set with spatial confounds

S = [];
S.D = D; 
S.method = 'SPMEEG';
S.conffile = fullfile(Da);  

D = spm_eeg_spatial_confounds(S);

if ~options.preproc.keep
    delete(Da);
end

end

