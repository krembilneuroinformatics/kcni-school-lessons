function tnueeg_singletrial_1stlevel_stats( factorialDesignDir, betaImages, design )
%TNUEEG_SINGLETRIAL_1STLEVEL_STATS Computes 1st level statistics for
%multiple regression of the EEG signal with single-trial (modelbased)
%regressors.
%   Computes an F-contrast per (modelbased) single-trial regressor on the
%   first level and saves the SPM.mat, the conimages and a results report
%   (pdf) per regressor in the factorial design directory.
%   IN:     factorialDesignDir  - directory (string) for saving the SPM.mat
%           betaImages          - name and path (string) of the beta images
%           design              - a struct with one field per regressor, 
%                               names of fields correspond to the names of 
%                               the regressors and fields contain the 
%                               trial-by-trial values of the regressors
%   OUT:    --

% determine the names of the regressors
factors = fieldnames(design);

% collect the beta images
nTrials = numel(design.(factors{1}));
scans = cell(nTrials, 1);
for i = 1: nTrials
    scans{i, 1} = [betaImages num2str(i)];
end

% prepare spm
spm('defaults', 'EEG');
spm_jobman('initcfg');

% create and run the job
job = tnueeg_getjob_singletrial_1stlevel(factorialDesignDir, scans, design);
spm_jobman('run', job);

end