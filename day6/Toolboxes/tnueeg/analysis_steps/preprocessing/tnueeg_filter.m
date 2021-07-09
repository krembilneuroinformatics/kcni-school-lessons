function [ D ] = tnueeg_filter( D, band, options )
%TNUEEG_FILTER Applies a Butterworth filter on continuous EEG data
%   IN:     D       - continuous EEG data set
%           band    - string (either 'high' or 'low')
%           options - the struct that holds all analysis options
%   OUT:    D       - filtered EEG data set

switch band
    case 'high'
        cutoff = options.preproc.highpassfreq;
    case 'low'
        cutoff = options.preproc.lowpassfreq;
end

S = [];
S.D = D;
S.type = 'butterworth';
S.band = band;
S.freq = cutoff;
S.dir = 'twopass';
S.order = 5;
S.prefix = 'f';

D = spm_eeg_filter(S);

if ~options.preproc.keep
    delete(S.D);
end

end

