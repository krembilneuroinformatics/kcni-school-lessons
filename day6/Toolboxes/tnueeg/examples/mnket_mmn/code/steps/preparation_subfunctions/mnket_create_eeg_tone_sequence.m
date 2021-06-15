function [ tones ] = mnket_create_eeg_tone_sequence( id, options, details )
%MNKET_CREATE_EEG_TONE_SEQUENCE Returns the corrected tone sequence for EEG
%analysis of one subject from the MNKET study, and saves the sequence.
%   IN:     id      - subject identifier string, e.g. '0001'
%           options - the struct that holds all analysis options
%           details - the struct that holds all subject-specific paths and
%                   filenames
%   OUT:    tones   - vector of tones (numbers 1:7) for subject id

load(details.tonesfile);
        
switch id
    case {'4534'}
        switch options.condition
            case {'ketamine'}
                tones(1: 29) = [];
        end
end

if isempty(tones)
    error(['No stimulus data found for subject ' id '!']);
end

save(details.eegtones, 'tones');

end

