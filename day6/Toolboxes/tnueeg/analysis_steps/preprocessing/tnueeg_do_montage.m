function [ D ] = tnueeg_do_montage( D, mfile, options )
%TNUEEG_DO_MONTAGE Applies a montage to an EEG data set
%   Can be used to rereference your data or create new channels (e.g. EOG)
%   based on the available sensor data. To create the mfile, you need to do
%   the montage step manually for one subject and save the montage matrix.
%   IN:     D       - EEG data set
%           mfile   - an nchannels x nchannels matrix holding the montage
%           options - the struct that holds all analysis options
%   OUT:    D       - EEG data set with new montage

S = [];
S.D = D;
S.mode = 'write';
S.prefix = 'M';
S.montage = mfile;
S.keepothers = options.preproc.keepotherchannels;
S.keepsensors = 1;
S.updatehistory = 1;

D = spm_eeg_montage(S);

if ~options.preproc.keep 
    delete(S.D);
end

end

