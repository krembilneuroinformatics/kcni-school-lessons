function [ Dtf, varargout ] = tnueeg_tf_transformation( D, options )
%TNUEEG_TF_TRANSFORMATION Transforms time x amplitude EEG data into time x frequency EEG data using
%Morlet wavelet transform. If indicated, saves the phase information in addition to power per 
%frequency.
%   IN:     D           - preprocessed data set with correct condition labels
%           options     - the struct that holds all analysis options
%   OUT:    Dtf         - tf-transformed EEG data set containing power per frequency
%           Dph         - if requested: tf-transformed EEG data set containing phase per frequency

S.D = D;

S.channels      = options.tf.channels;
S.frequencies   = options.tf.frequencies;
S.timewin       = options.tf.epochwin;
S.method        = 'morlet';

S.settings.ncycles      = options.tf.ncycles;
S.settings.timeres      = 0;
S.settings.subsample    = 1;

S.phase     = options.tf.phase;
S.prefix    = 'TF';

if S.phase
    [Dtf, Dph]      = spm_eeg_tf(S);
    varargout{1}    = Dph;
else
    Dtf = spm_eeg_tf(S);
end

end