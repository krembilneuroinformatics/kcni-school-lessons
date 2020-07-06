function tnueeg_2ndlevel_erpstats_anova_within( scndlvlroot, subjects )
%TNUEEG_2NDLEVEL_ERPSTATS_ANOVA_WITHIN Sets up the design for a repeated measures ANOVA on the 
%second level and estimates it.
%   IN:     scndlvlroot     - directory (string) for saving the SPM.mat
%           subjects        - cell struct with nSubjects entries and a substruct field 'scans' 
%                           (subjects(iSub).scans) specifying the paths and names of the images for 
%                           each subject in each condition. nConditions will be read from the number
%                           of scans in the first subject.
%   OUT:    --


%-- statistics in SPM -----------------------------------------------------------------------------%
spm('defaults', 'EEG');
spm_jobman('initcfg');

% create and run the job
job = tnueeg_getjob_2ndlevel_anova_within(scndlvlroot, subjects);
spm_jobman('run', job);

end