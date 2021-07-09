function [ fileName ] = mmn_remove_first_EEG_trial( details, options )
%mmn_REMOVE_FIRST_EEG_TRIAL Removes the first trial of a preprocessed, epoched EEG data set from
%the mmn study. 
%   This function checks whether the first trial has already been marked as bad by the artefact
%   rejection routines from the preprocessing step. If not, it marks the first trial as bad, such
%   that it won't be included in the statistics which will run on the images after conversion. This
%   is an important step in the modelbased analysis, as the model only defines PEs for observed
%   transitions, and the first transition is only observed as the presentation of the second tone.

D = spm_eeg_load(details.prepfile);
eeg.idxArtefacts = badtrials(D);
trialStats = getfield(load(details.trialstats), 'trialStats');
if trialStats.idxArtefacts ~= eeg.idxArtefacts
    error('Trial Stats and EEG file do not agree on the bad trial indices!');
end

switch options.preproc.eyeblinktreatment
    case 'reject'
        if trialStats.idxEyeartefacts.tone(1) == 1
            % first EEG trial has been removed already, so we don't have to do anything
            % (but to save this information for later work on the regressors).
            trialStats.firstTrial = 'eyeblink';
            fprintf(['\nModelbased analysis for %s: Trial 1 was anyway removed due to' ...
                ' eyeblinks, nothing needs to be done here.'], details.subjectname);
        else
            % then we need to check the other artefacts
            if trialStats.idxArtefacts(1) == 1
                % first EEG trial has been removed already, so we don't have to do anything
                % (but to save this information for later work on the regressors).
                trialStats.firstTrial = 'artefact';
                fprintf(['\nModelbased analysis for %s: Trial 1 was anyway removed due to' ...
                    ' artefacts, nothing needs to be done here.'], details.subjectname);
            else
                % if we've made it up to here, the first EEG trial is still in there, so we have to 
                % mark it as bad to remove it from the first level statistics
                bt = [1 eeg.idxArtefacts];
                D = badtrials(D, bt, ones(1, numel(bt)));
                trialStats.firstTrial = 'removed';         
                fprintf('\nModelbased analysis for %s: Excluded EEG trial 1.', details.subjectname);
            end
        end
    case 'ssp'
        % here we didn't exclude EBs, so we only need to check the other artefacts
        if trialStats.idxArtefacts(1) == 1
            % first EEG trial has been removed already, so we don't have to do anything
            % (but to save this information for later work on the regressors).
            trialStats.firstTrial = 'artefact';
            fprintf(['\nModelbased analysis for %s: Trial 1 was anyway removed due to' ...
                ' artefacts, nothing needs to be done here.'], details.subjectname);
        else
            % if we've made it up to here, the first EEG trial is still in there, so we have to mark
            % it as bad to remove it from the first level statistics
            bt = [1 eeg.idxArtefacts];
            D = badtrials(D, bt, ones(1, numel(bt)));
            trialStats.firstTrial = 'removed';         
            fprintf('\nModelbased analysis for %s: Excluded EEG trial 1.', details.subjectname);
        end
end

save(details.trialstats, 'trialStats');
D = copy(D, details.prepfile_modelbased);
fileName = fullfile(D);
fprintf('\nCorrection for first EEG trial in modelbased analysis: Done.\n\n');

end

