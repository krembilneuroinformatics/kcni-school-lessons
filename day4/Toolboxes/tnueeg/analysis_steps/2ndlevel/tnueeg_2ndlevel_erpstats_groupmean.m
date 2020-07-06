function tnueeg_2ndlevel_erpstats_groupmean( scndlvlroot, imagePaths, factorName )
%TNUEEG_2NDLEVEL_ERPSTATS_GROUPMEAN Computes 2nd level statistics for a classical
%ERP analysis using a one-sample t-test.
%   Computes a one-sample t-test on the second level and saves the SPM.mat,
%   the conimages and a results report (pdf) in the scndlvlroot.
%   IN:     scndlvlroot     - directory (string) for saving the SPM.mat
%           imagePaths      - cell array of paths (strings) of the images
%           factorName      - a string with the name of the condition or
%                           factor (needs to be the same as the condition 
%                           name in the smoothed images)
%   OUT:    --

% how many subjects do we use
nSubjects = numel(imagePaths);

% prepare spm
spm('defaults', 'EEG');
spm_jobman('initcfg');

% collect the smoothed image from each subject
scans = cell(nSubjects, 1);
for sub = 1: nSubjects
    scans{sub, 1} = fullfile(imagePaths{sub}, ...
        ['smoothed_condition_' factorName '.nii,1']);
end
    
% create and run the job
job = tnueeg_getjob_2ndlevel_onesample_ttest(scndlvlroot, scans, factorName);
spm_jobman('run', job);

end