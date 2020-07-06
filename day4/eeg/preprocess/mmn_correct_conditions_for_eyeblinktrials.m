function [ condlist ] = mmn_correct_conditions_for_eyeblinktrials( condlist, trialStatsFile )
%mmn_CORRECT_CONDITIONS_FOR_EYEBLINKTRIALS Removes eyeblink trials from the condition list
%   IN:     condlist        - list of condition labels before trial removal
%           trialStatsFile  - filename with path to the trial statistics summary for the given
%           subject
%   OUT:    condlist    - cell array with string condition labels for each trial, after trial removal

trialStats = getfield(load(trialStatsFile), 'trialStats');

condlist(trialStats.idxEyeartefacts.tone) = [];

end

