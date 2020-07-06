function [ job ] = tnueeg_getjob_2ndlevel_paired_ttest(facdir, pairs, factorName, label1, label2)
%TNUEEG_GETJOB_2NDLEVEL_PAIRED_TTEST Creates a job for running a paired
%t-test on the 2nd level for testing differences in the effect of the
%factorName across groups, drug conditions or time points.
%   IN:     facdir      - directory (string) for saving the SPM.mat
%           pairs       - cell array list of image filenames, including paths
%           regressor   - string with name of the regressor
%   OUT:    job         - the job for the 2nd level statistics that can be
%                       run using the spm_jobman

% job 1: factorial design
job{1}.spm.stats.factorial_design.dir = {facdir};

job{1}.spm.stats.factorial_design.des.pt.pair = pairs;
job{1}.spm.stats.factorial_design.des.pt.gmsca = 0;
job{1}.spm.stats.factorial_design.des.pt.ancova = 0;

job{1}.spm.stats.factorial_design.cov = ...
    struct('c', {}, 'cname', {}, 'iCFI', {}, 'iCC', {});
job{1}.spm.stats.factorial_design.multi_cov = ...
    struct('files', {}, 'iCFI', {}, 'iCC', {});
job{1}.spm.stats.factorial_design.masking.tm.tm_none = 1;
job{1}.spm.stats.factorial_design.masking.im = 1;
job{1}.spm.stats.factorial_design.masking.em = {''};
job{1}.spm.stats.factorial_design.globalc.g_omit = 1;
job{1}.spm.stats.factorial_design.globalm.gmsca.gmsca_no = 1;
job{1}.spm.stats.factorial_design.globalm.glonorm = 1;

% job 2: estimate factorial design
job{2}.spm.stats.fmri_est.spmmat(1) = ...
    cfg_dep('Factorial design specification: SPM.mat File', ...
    substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), ...
    substruct('.','spmmat'));
job{2}.spm.stats.fmri_est.write_residuals = 0;
job{2}.spm.stats.fmri_est.method.Classical = 1;

% job 3: specify contrasts
job{3}.spm.stats.con.spmmat(1) = ...
    cfg_dep('Model estimation: SPM.mat File', ...
    substruct('.','val', '{}',{2}, '.','val', '{}',{1}, '.','val', '{}',{1}), ...
    substruct('.','spmmat'));
job{3}.spm.stats.con.consess{1}.tcon.name = [factorName ': ' label1 ' > ' label2];
job{3}.spm.stats.con.consess{1}.tcon.weights = [1 -1];
job{3}.spm.stats.con.consess{1}.tcon.sessrep = 'none';
job{3}.spm.stats.con.consess{2}.tcon.name = [factorName ': ' label1 ' < ' label2];
job{3}.spm.stats.con.consess{2}.tcon.weights = [-1 1];
job{3}.spm.stats.con.consess{2}.tcon.sessrep = 'none';
job{3}.spm.stats.con.delete = 0;

% job 4: print results
job{4}.spm.stats.results.spmmat(1) = ...
    cfg_dep('Contrast Manager: SPM.mat File', ...
    substruct('.','val', '{}',{3}, ...
            '.','val', '{}',{1}, ...
            '.','val', '{}',{1}), ...
            substruct('.','spmmat'));

job{4}.spm.stats.results.conspec(1).titlestr = '';
job{4}.spm.stats.results.conspec(1).contrasts = 1;
job{4}.spm.stats.results.conspec(1).threshdesc = 'none';
job{4}.spm.stats.results.conspec(1).thresh = 0.001;
job{4}.spm.stats.results.conspec(1).extent = 0;
job{4}.spm.stats.results.conspec(1).mask = ...
    struct('contrasts', {}, 'thresh', {}, 'mtype', {});

job{4}.spm.stats.results.conspec(2).titlestr = '';
job{4}.spm.stats.results.conspec(2).contrasts = 2;
job{4}.spm.stats.results.conspec(2).threshdesc = 'none';
job{4}.spm.stats.results.conspec(2).thresh = 0.001;
job{4}.spm.stats.results.conspec(2).extent = 0;
job{4}.spm.stats.results.conspec(2).mask = ...
    struct('contrasts', {}, 'thresh', {}, 'mtype', {});

job{4}.spm.stats.results.units = 2;
job{4}.spm.stats.results.print = 'pdf';
job{4}.spm.stats.results.write.none = 1;


end