function [ job ] = tnueeg_getjob_2ndlevel_anova_within(facdir, subjects)
%TNUEEG_GETJOB_2NDLEVEL_ANOVA_WITHIN Creates a job for running a within-subject ANOVA on the 2nd 
%level. No contrasts are predefined as these depend on the research question.
%   IN:     facdir      - directory (string) for saving the SPM.mat
%           subjects    - cell struct with nSubjects entries and a substruct field 'scans' 
%                       (subjects(iSub).scans) specifying the paths and names of the images for 
%                       each subject in each condition. nConditions will be read from the number
%                       of scans in the first subject.
%   OUT:    job         - the job for the 2nd level statistics that can be run using the spm_jobman

nSubjects = numel(subjects);
nConditions = numel(subjects(1).scans);

% job 1: factorial design
job{1}.spm.stats.factorial_design.dir = {facdir};

for iSub = 1: nSubjects
job{1}.spm.stats.factorial_design.des.anovaw.fsubject(iSub).scans = subjects(iSub).scans;
job{1}.spm.stats.factorial_design.des.anovaw.fsubject(iSub).conds = 1: nConditions;
end

job{1}.spm.stats.factorial_design.des.anovaw.dept = 1;
job{1}.spm.stats.factorial_design.des.anovaw.variance = 1;
job{1}.spm.stats.factorial_design.des.anovaw.gmsca = 0;
job{1}.spm.stats.factorial_design.des.anovaw.ancova = 0;

job{1}.spm.stats.factorial_design.cov = struct('c', {}, 'cname', {}, 'iCFI', {}, 'iCC', {});
job{1}.spm.stats.factorial_design.multi_cov = struct('files', {}, 'iCFI', {}, 'iCC', {});
job{1}.spm.stats.factorial_design.masking.tm.tm_none = 1;
job{1}.spm.stats.factorial_design.masking.im = 1;
job{1}.spm.stats.factorial_design.masking.em = {''};
job{1}.spm.stats.factorial_design.globalc.g_omit = 1;
job{1}.spm.stats.factorial_design.globalm.gmsca.gmsca_no = 1;
job{1}.spm.stats.factorial_design.globalm.glonorm = 1;

% job 2: estimate SPM
job{2}.spm.stats.fmri_est.spmmat(1) = cfg_dep('Factorial design specification: SPM.mat File', ...
    substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), ...
    substruct('.','spmmat'));
job{2}.spm.stats.fmri_est.write_residuals = 0;
job{2}.spm.stats.fmri_est.method.Classical = 1;