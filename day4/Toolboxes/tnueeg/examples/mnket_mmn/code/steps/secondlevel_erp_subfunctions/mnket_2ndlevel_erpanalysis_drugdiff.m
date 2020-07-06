function mnket_2ndlevel_erpanalysis_drugdiff(options)
%MNKET_2NDLEVEL_ERPANALYSIS_DRUGDIFF Computes the second level contrast
%images for ERP effects in one condition in the MNKET study.
%   IN:     options - the struct that holds all analysis options
%   OUT:    --

% general analysis options
if nargin < 1
    options = mnket_set_analysis_options;
end

% paths and files
[~, paths] = mnket_subjects(options);

% record what we're doing
diary(paths.logfile);
mnket_display_analysis_step_header('secondlevel erpanalysis drugdiff', ...
    'all', options.erp);

try
    % check for previous drugdifference erpanalysis
    load(paths.diffgafile);
    disp(['Drug differences in ' options.erp.type ' ERPs have been ' ...
        'computed before.']);
    if options.erp.overwrite
        clear diff;
        disp('Overwriting...');
        error('Continue to drug difference step');
    else
        disp('Nothing is being done.');
    end
catch
    disp(['Computing drug differences in ' options.erp.type  ' ERPs...']);
    
    % make sure we have a results directory
    GAroot = fullfile(paths.erpfold, 'drugdiff');
    if ~exist(GAroot, 'dir')
        mkdir(GAroot);
    end
    
    % data from both conditions serve as input for drug differences in
    % difference waves
    cd(options.workdir);
    options.condition = 'placebo';
    [~, paths] = mnket_subjects(options);
    pla = load(paths.erpgafile);
    options.condition = 'ketamine';
    [~, paths] = mnket_subjects(options);
    ket = load(paths.erpgafile);
    
    % compute the difference waves condition-wise
    diff.time = pla.ga.time;
    diff.electrode = pla.ga.electrode;
    diff.nsubjects = size(pla.ga.standard.data, 1);
    
    diffwaves = pla.ga.deviant.data - pla.ga.standard.data;
    diff.placebo.mean = mean(diffwaves);
    diff.placebo.sd  = std(diffwaves);
    diff.placebo.error  = std(diffwaves)/sqrt(diff.nsubjects);
    diff.placebo.data = diffwaves;
    
    diffwaves = ket.ga.deviant.data - ket.ga.standard.data;
    diff.ketamine.mean = mean(diffwaves);
    diff.ketamine.sd  = std(diffwaves);
    diff.ketamine.error  = std(diffwaves)/sqrt(diff.nsubjects);
    diff.ketamine.data = diffwaves;
    
    save(paths.diffgafile, 'diff');

    disp(['Computed drug differences in ' options.erp.type ' ERPs.']);
end
cd(options.workdir);

diary OFF
end



