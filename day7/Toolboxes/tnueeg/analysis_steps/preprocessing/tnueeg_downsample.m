function [ D ] = tnueeg_downsample( D, options )
%TNUEEG_DOWNSAMPLE Downsamples continuous EEG data for data reduction
%   Downsampling can introduce high frequency noise in your data. It is
%   advised to (re-)apply the low-pass filter after downsampling.
%   IN:     D       - continuous EEG data set
%           options - the struct that holds all analysis options
%   OUT:    D       - downsampled EEG data set

S = [];
S.D = D;
S.fsample_new = options.preproc.downsamplefreq;
S.prefix = 'd';

D = spm_eeg_downsample(S);

if ~options.preproc.keep
    delete(S.D);
end

end

