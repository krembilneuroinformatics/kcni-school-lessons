function finaldesign = mmn_correct_regressors_for_EEG_artefacts( details, options )
%mmn_CORRECT_REGRESSORS_FOR_EEG_ARTEFACTS  Corrects modelbased regressors for EEG artefacts before
%applying the firstlevel statistics for one subject in the mmn study. 
%   IN:     details     - the struct that holds all subject-specific paths and filenames     
%   OUT:    finaldesign - the corrected design struct holding the vectors to be used in the 
%                       regression of the preprocessed EEG data

initialdesign   = getfield(load(details.design), 'design');
trialStats      = getfield(load(details.trialstats), 'trialStats');

design = initialdesign;
regressors = fieldnames(design);

switch options.preproc.eyeblinktreatment
    case 'reject'
        %-- Bad trials due to Eye blinks ----------------------------------------------------------%
        eyeblinktrials = trialStats.idxEyeartefacts.tone;
        % we subtract 1 because regressors don't have a value for the first EEG trial (first tone 
        % alone does not represent an observed transition, so there's no PE associated).
        eyeblinktrials = eyeblinktrials -1;

        % in case the first EEG trial was an EB trial, we remove that (now zero) entry from the 
        % correction vector (as the regressors anyway don't contain it).
        if eyeblinktrials(1) < 1 % that means it initially pointed to the first EEG trial
            eyeblinktrials(1) = []; % no need to correct for that - regressors anyway don't have it!
            firstTrialRemoved = 1;
        end

        % now we remove these entries from all regressors in our design
        for iReg = 1: numel(regressors)
            design.(regressors{iReg})(eyeblinktrials) = [];
        end     
        
        trialStats.removedTrials.eyeblinktrials = eyeblinktrials;
end

%-- Bad trials due to Artefacts -----------------------------------------------------------%
artefacttrials = trialStats.idxArtefacts;

% now we only need to worry if the 1st trial hasn't already been removed due to an eyeblink!
switch trialStats.firstTrial
    case 'eyeblink'
        % we don't need to act - artefact vector is already relative to the second tone.
    case 'artefact'
        % we subtract 1 because regressors don't have a value for the first EEG trial (first 
        % tone alone does not represent an observed transition, so there's no PE associated).
        artefacttrials = artefacttrials -1;
        artefacttrials(1) = []; % no need to correct - regressors anyway don't have this! 
    case 'removed'
        % we subtract 1 because regressors don't have a value for the first EEG trial (first 
        % tone alone does not represent an observed transition, so there's no PE associated).
        artefacttrials = artefacttrials -1;
end

% now we remove these entries from all regressors in our design
for iReg = 1: numel(regressors)
    design.(regressors{iReg})(artefacttrials) = [];
end

trialStats.removedTrials.artefacttrials = artefacttrials;

save(details.trialstats, 'trialStats');

%-- Compare numbers -------------------------------------------------------------------------------%
nInitial = length(initialdesign.(regressors{1}));
nFinal = length(design.(regressors{1}));
try
    nEyeblinks = length(eyeblinktrials);
catch
    nEyeblinks = 0;
end
nArtefacts = (nInitial - nEyeblinks) - nFinal;

switch trialStats.firstTrial
    case 'removed'
        if nFinal ~= trialStats.nTrialsFinal.all -1
            error('Final number of trials does not match the preprocessing output.');
        end
        if nArtefacts ~= trialStats.numArtefacts
            error('Number of additional artefacts does not match the preprocessing output.');
        end

    case 'artefact'
        if nFinal ~= trialStats.nTrialsFinal.all
            error('Final number of trials does not match the preprocessing output.');
        end
        if nArtefacts ~= trialStats.numArtefacts -1
            error('Number of additional artefacts does not match the preprocessing output.');
        end
    case 'eyeblink'
        if nFinal ~= trialStats.nTrialsFinal.all
            error('Final number of trials does not match the preprocessing output.');
        end
        if nArtefacts ~= trialStats.numArtefacts
            error('Number of additional artefacts does not match the preprocessing output.');
        end        
end

switch options.preproc.eyeblinktreatment
    case 'reject'
        switch trialStats.firstTrial
            case 'eyeblink'
                if nEyeblinks ~= trialStats.numEyeartefacts.all -1
                    error('Number of eye blink artefacts does not match the preprocessing output.');
                end
            case {'artefact', 'removed'}
                if nEyeblinks ~= trialStats.numEyeartefacts.all
                    error('Number of eye blink artefacts does not match the preprocessing output.');
                end
        end
end

finaldesign = design;

end

