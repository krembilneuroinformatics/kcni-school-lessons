function [ trialdef ] = mmn_trial_definition( options, paths )
%mmn_TRIAL_DEFINITION Trial definition for mmn MMN EEG data sets
%   IN:     options     - struct that holds all analysis options
%           paths       - struct that holds all general paths
%   OUT:    trialdef    - struct with labels, types and values of triggers

switch options.preproc.trialdef
    case 'tone'
        trialdef.labels = repmat({'tone'}, [1 11]);
        trialdef.types = repmat({'STATUS'}, [1 11]);
        trialdef.values = 1: 11;
    case 'MMN'
        trialdef.labels = {'deviant', 'standard'};
        trialdef.types = repmat({'STATUS'}, [1 2]);
        trialdef.values = [1 6];
end

save(paths.trialdef, 'trialdef');

end

