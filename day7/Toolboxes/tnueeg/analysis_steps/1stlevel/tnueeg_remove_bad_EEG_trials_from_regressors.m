function corrDesign = tnueeg_remove_bad_EEG_trials_from_regressors( prepfile, design )
%TNUEEG_REMOVE_BAD_EEG_TRIALS_FROM_REGRESSORS Removes trials that were
%rejected during preprocessing of EEG data from the regressors that will be
%used in the statistics step of a (modelbased) single-trial EEG analysis.
%   IN:     prepfile            - name and path (string) of the final 
%                               preprocessed EEG data set
%           design              - a struct with one field per regressor, 
%                               names of fields correspond to the names of 
%                               the regressors and fields contain the 
%                               trial-by-trial values of the regressors
%   OUT:    corrDesign              - a struct with one field per regressor, 
%                               names of fields correspond to the names of 
%                               the regressors and fields contain the 
%                               trial-by-trial values of the regressors

% determine bad trials after preprocessing of EEG data
D = spm_eeg_load(prepfile);
bt = badtrials(D);
disp(['Found ' num2str(numel(bt)) ' bad trials in final preprocessed file.']);

% determine names of regressors and number of trials before removal
fns = fieldnames(design);
nTrialsInit = numel(design.(char(fns(1))));
disp(['Initial regressors contain ' num2str(nTrialsInit) ' trials.']);

% remove bad trials from regressors
corrDesign = design;
for i = 1: numel(fns)
    fn = char(fns(i));
    corrDesign.(fn)(bt) = [];
end

% determine number of trials after removal
nTrialsCorr = numel(corrDesign.(char(fns(1))));
disp(['Corrected regressors contain ' num2str(nTrialsCorr) ' trials.']);


end