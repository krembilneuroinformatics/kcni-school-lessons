function [ job ] = tnueeg_getjob_2ndlevel_fullfactorial(facdir, factors, cells)
%TNUEEG_GETJOB_2NDLEVEL_PAIRED_TTEST Creates a job for running a paired
%t-test on the 2nd level for testing differences in the effect of the
%factorName across groups, drug conditions or time points.
%   IN:     facdir      - directory (string) for saving the SPM.mat
%           factors     - cell array of dimension 4 x nFactors specifying the name, number of
%                       levels, dependency and (un)equal variance assumption for each factor
%           cells       - struct with nCells entries and substruct fields specifying the factor
%                       levels and the corresponding image files (scans) for each cell of the design
%   OUT:    job         - the job for the 2nd level statistics that can be run using the spm_jobman


nFactors = size(factors, 2);
nCells = numel(cells);

% job 1: factorial design
job{1}.spm.stats.factorial_design.dir = {facdir};

for iFac = 1: nFactors
    job{1}.spm.stats.factorial_design.des.fd.fact(iFac).name = factors{1, iFac};
    job{1}.spm.stats.factorial_design.des.fd.fact(iFac).levels = factors{2, iFac};
    job{1}.spm.stats.factorial_design.des.fd.fact(iFac).dept = factors{3, iFac};
    job{1}.spm.stats.factorial_design.des.fd.fact(iFac).variance = factors{4, iFac};
    job{1}.spm.stats.factorial_design.des.fd.fact(iFac).gmsca = 0;
    job{1}.spm.stats.factorial_design.des.fd.fact(iFac).ancova = 0;
end

for iCell = 1: nCells
    job{1}.spm.stats.factorial_design.des.fd.icell(iCell).levels = cells(iCell).levels;
    job{1}.spm.stats.factorial_design.des.fd.icell(iCell).scans = cells(iCell).scans;
end

job{1}.spm.stats.factorial_design.des.fd.contrasts = 1;
job{1}.spm.stats.factorial_design.cov = struct('c', {}, 'cname', {}, 'iCFI', {}, 'iCC', {});
job{1}.spm.stats.factorial_design.multi_cov = struct('files', {}, 'iCFI', {}, 'iCC', {});
job{1}.spm.stats.factorial_design.masking.tm.tm_none = 1;
job{1}.spm.stats.factorial_design.masking.im = 1;
job{1}.spm.stats.factorial_design.masking.em = {''};
job{1}.spm.stats.factorial_design.globalc.g_omit = 1;
job{1}.spm.stats.factorial_design.globalm.gmsca.gmsca_no = 1;
job{1}.spm.stats.factorial_design.globalm.glonorm = 1;

% job 2: estimate factorial design
job{2}.spm.stats.fmri_est.spmmat(1) = cfg_dep('Factorial design specification: SPM.mat File', ...
    substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), ...
    substruct('.','spmmat'));
job{2}.spm.stats.fmri_est.write_residuals = 0;
job{2}.spm.stats.fmri_est.method.Classical = 1;

% job 3: print results
job{3}.spm.stats.results.spmmat(1) = cfg_dep('Contrast Manager: SPM.mat File', ...
    substruct('.','val', '{}',{2}, '.','val', '{}',{1}, '.','val', '{}',{1}), ...
    substruct('.','spmmat'));

for iFac = 1: nFactors        
    job{3}.spm.stats.results.conspec(iFac).titlestr = ['Main Effect of ' factors{1, iFac}];
    job{3}.spm.stats.results.conspec(iFac).contrasts = iFac + 1;
    job{3}.spm.stats.results.conspec(iFac).threshdesc = 'none';
    job{3}.spm.stats.results.conspec(iFac).thresh = 0.001;
    job{3}.spm.stats.results.conspec(iFac).extent = 0;
    job{3}.spm.stats.results.conspec(iFac).mask = ...
        struct('contrasts', {}, 'thresh', {}, 'mtype', {});
end

job{3}.spm.stats.results.units = 2;
job{3}.spm.stats.results.print = 'pdf';
job{3}.spm.stats.results.write.none = 1;

