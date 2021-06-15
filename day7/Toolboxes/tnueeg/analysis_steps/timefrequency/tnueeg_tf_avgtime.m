function [ D ] = tnueeg_tf_avgtime( D, options )
%TNUEEG_TF_AVGTIME Averages a TF EEG dataset over peristimulus time to get a spectrum dataset.
%   IN:     D           - TF-transformed (rescaled) data set with correct condition labels
%           options     - the struct that holds all analysis options
%   OUT:    D           - spectrum EEG dataset containing power per frequency per trial

S.D         = D;
S.timewin	= options.tf.avgtimewin;
S.prefix    = 'S';

D = spm_eeg_avgtime(S);

end