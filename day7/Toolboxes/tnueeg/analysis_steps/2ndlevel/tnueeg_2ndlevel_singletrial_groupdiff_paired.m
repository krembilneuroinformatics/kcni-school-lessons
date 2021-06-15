function tnueeg_2ndlevel_singletrial_groupdiff_paired( scndlvlroot, imagePaths, regressors, conditions )
%TNUEEG_2NDLEVEL_SINGLETRIAL_GROUPDIFF_PAIRED Computes statistics for
%differences in the effects of single-trial (modelbased) regressors between
%conditions or time points in a within-subject design, using a paired t-test.
%   Computes an F-contrast per (modelbased) single-trial regressor on the
%   first level and saves the SPM.mat, the conimages and a results report
%   (pdf) per regressor in the factorial design directory.
%   IN:     factorialDesignDir  - directory (string) for saving the SPM.mat
%           betaImages          - cell array with paths of the beta images
%           regressors          - a cell array list of regressor names
%                               (strings)
%           conditions          - a 2x1 cell array list of condition names
%   OUT:    --

% how many subjects do we use
nSubjects = size(imagePaths, 1);

% prepare spm
spm('defaults', 'EEG');
spm_jobman('initcfg');

for reg = 1: numel(regressors)
    regressorName = char(regressors{reg});
    
    % open a new folder for each regressor
    factorialDesignDir = fullfile(scndlvlroot, regressorName);
    
    % collect the regressor's beta image from each subject
    %pairs = cell(nSubjects, 2);
    for sub = 1: nSubjects
        pairs(sub).scans{1, 1} = fullfile(imagePaths{sub, 1}, ['beta_000' num2str(reg+1) '.nii,1']);
        pairs(sub).scans{2, 1} = fullfile(imagePaths{sub, 2}, ['beta_000' num2str(reg+1) '.nii,1']);
    end
    
    % which groups are we comparing
    group1 = char(conditions{1});
    group2 = char(conditions{2});
    
    % create and run the job - one test per regressor
    job = tnueeg_getjob_2ndlevel_paired_ttest(factorialDesignDir, pairs, regressorName, group1, group2);
    spm_jobman('run', job);
end

end