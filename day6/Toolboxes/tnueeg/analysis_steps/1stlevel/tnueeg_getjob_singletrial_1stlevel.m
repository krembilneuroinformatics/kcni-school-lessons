function job = tnueeg_getjob_singletrial_1stlevel( facdir, scans, design )
%TNUEEG_GETJOB_SINGLETRIAL_1STLEVEL Creates a job for running 1st level
%statistics for multiple regression of the EEG signal with single-trial
%(modelbased) regressors. 
%   IN:     facdir  - directory (string) for saving the SPM.mat
%           scans   - cell array list of image filenames, including paths
%           design  - a struct with one field per regressor, names of
%                   fields correspond to the names of the regressors and 
%                   fields contain the trial-by-trial values of the 
%                   regressors (vectors of length nTrials)
%   OUT:    job     - the job for the 1st level statistics that can be run
%                    using the spm_jobman

factors = fieldnames(design);

% job 1: factorial design
job{1}.spm.stats.factorial_design.dir = {facdir};
job{1}.spm.stats.factorial_design.des.mreg.scans = scans;

for i = 1: numel(factors)
    job{1}.spm.stats.factorial_design.des.mreg.mcov(i).c = design.(factors{i});
    job{1}.spm.stats.factorial_design.des.mreg.mcov(i).cname = factors{i};
    job{1}.spm.stats.factorial_design.des.mreg.mcov(i).iCC = 1;
end

job{1}.spm.stats.factorial_design.des.mreg.incint = 1;
job{1}.spm.stats.factorial_design.cov = ...
    struct('c', {}, 'cname', {}, 'iCFI', {}, 'iCC', {});
job{1}.spm.stats.factorial_design.masking.tm.tm_none = 1;
job{1}.spm.stats.factorial_design.masking.im = 1;
job{1}.spm.stats.factorial_design.masking.em = {''};
job{1}.spm.stats.factorial_design.globalc.g_omit = 1;
job{1}.spm.stats.factorial_design.globalm.gmsca.gmsca_no = 1;
job{1}.spm.stats.factorial_design.globalm.glonorm = 1;


% job 2: estimate factorial design
job{2}.spm.stats.fmri_est.spmmat(1) = ...
    cfg_dep('Factorial design specification: SPM.mat File', ...
    substruct('.','val', '{}',{1}, ...
            '.','val', '{}',{1}, ...
            '.','val', '{}',{1}), ...
            substruct('.','spmmat'));
job{2}.spm.stats.fmri_est.write_residuals = 0;
job{2}.spm.stats.fmri_est.method.Classical = 1;
job{3}.spm.stats.con.spmmat(1) = ...
    cfg_dep('Model estimation: SPM.mat File', ...
    substruct('.','val', '{}',{2}, ...
    '.','val', '{}',{1}, ...
    '.','val', '{}',{1}), ...
    substruct('.','spmmat'));


% job 3: specify contrasts
for i = 1:numel(factors)
    job{3}.spm.stats.con.consess{i}.fcon.name    = factors{i};
    job{3}.spm.stats.con.consess{i}.fcon.weights = zeros(1, numel(factors)+1);
    job{3}.spm.stats.con.consess{i}.fcon.weights(i+1) = 1;
    job{3}.spm.stats.con.consess{i}.fcon.sessrep = 'none';
end
job{3}.spm.stats.con.delete = 1;


% job 4: print results
job{4}.spm.stats.results.spmmat(1) = ...
    cfg_dep('Contrast Manager: SPM.mat File', ...
    substruct('.','val', '{}',{3}, ...
            '.','val', '{}',{1}, ...
            '.','val', '{}',{1}), ...
            substruct('.','spmmat'));

for i = 1: numel(factors)
    job{4}.spm.stats.results.conspec(i).titlestr = factors{i};
    job{4}.spm.stats.results.conspec(i).contrasts = i;
    job{4}.spm.stats.results.conspec(i).threshdesc = 'none';
    job{4}.spm.stats.results.conspec(i).thresh = 0.001;
    job{4}.spm.stats.results.conspec(i).extent = 0;
    job{4}.spm.stats.results.conspec(i).mask = struct('contrasts', {}, 'thresh', {}, 'mtype', {});
end

job{4}.spm.stats.results.units = 2;
job{4}.spm.stats.results.print = 'pdf';
job{4}.spm.stats.results.write.none = 1;

end

