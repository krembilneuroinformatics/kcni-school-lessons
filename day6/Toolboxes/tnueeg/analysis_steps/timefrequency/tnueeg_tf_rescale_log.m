function [ D ] = tnueeg_tf_rescale_log( D )
%TNUEEG_TF_RESCALE_LOG Rescales power values in a time x frequency EEG data to log scale.
%   IN:     D           - tf EEG data set from tf transformation step
%   OUT:    D           - rescaled tf EEG data set containing power per frequency with power on log
%                       scale

S.D         = D;
S.method	= 'Log';
S.prefix    = 'r';

D = spm_eeg_tf_rescale(S);

end