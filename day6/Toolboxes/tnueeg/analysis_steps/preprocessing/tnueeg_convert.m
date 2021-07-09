function [ D ] = tnueeg_convert( filename )
%TNUEEG_CONVERT Converts a raw EEG dataset to mat-format for SPM
%   IN:     filename    - name of raw EEG data file incl. path
%   OUT:    D           - EEG data set in SPM for EEG format

D = spm_eeg_convert(filename);

end

