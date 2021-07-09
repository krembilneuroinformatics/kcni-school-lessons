function [ trialdef ] = dprst_trial_definition( paths, options )
%DPRST_TRIAL_DEFINTION Trial definition for DPRST MMN EEG data sets
%   IN:     paths       - struct with general paths and files
%           options     - struct with analysis options
%   OUT:    trialdef    - struct with labels, types and values of triggers

switch options.preproc.trialdef
    case 'tone'
        trialdef.labels = {'tone', 'tone', 'tone', 'tone', 'tone', 'tone'};
        trialdef.types  = repmat({'Stimulus'}, [1 6]);
        trialdef.values = {'S 11', 'S 12', 'S 13', 'S 21', 'S 22', 'S 23'};        
    case 'oddball'
        trialdef.labels = {'standard', 'standard', 'deviant', 'deviant'};
        trialdef.types  = repmat({'Stimulus'}, [1 6]);
        trialdef.values = {'S 11', 'S 21', 'S 12', 'S 22'};
end

save(paths.trialdef, 'trialdef');

end

