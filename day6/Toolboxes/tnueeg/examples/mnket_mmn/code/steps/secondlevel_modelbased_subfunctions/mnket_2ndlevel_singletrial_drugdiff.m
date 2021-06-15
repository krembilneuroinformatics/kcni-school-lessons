function mnket_2ndlevel_singletrial_drugdiff(options)
%MNKET_2NDLEVEL_SINGLETRIAL_DRUGDIFF Computes the second level contrast
%images for differences in the effects of single-trial (modelbased) 
% regressors between drug conditions (placebo, ketamine) in the MNKET study.
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
mnket_display_analysis_step_header('secondlevel drugdiff', ...
    'all', options.stats);

% names of the single-trial regressors
regressorNames = options.stats.regressors;

% results file of first regressor
spmFile = fullfile(paths.diffroot, 'pairedT', regressorNames{1}, ...
            'SPM.mat');

try
    % check for previous statistics
    load(spmFile);
    disp(['Drug difference stats for regressors in ' options.stats.design ...
        ' design have been computed before.']);
    if options.stats.overwrite
        delete(spmFile);
        disp('Overwriting...');
        error('Continue to drug difference stats step');
    else
        disp('Nothing is being done.');
    end
catch
    disp(['Computing Drug difference stats for regressors in the ' ...
        options.stats.design  ' design...']);
    
    % make sure we have a results directory
    scndlvlroot = paths.diffroot;
    if ~exist(scndlvlroot, 'dir')
        mkdir(scndlvlroot);
    end
    
    % beta images of 1st level regression for each regressor in each
    % subject and each condition serve as input to 2nd level statistics, 
    % but here, we only indicate the subject-specific directories of the 
    % beta images
    conditions = {'placebo', 'ketamine'};
    nSubjects = numel(options.stats.subjectIDs);
    imagePaths = cell(nSubjects, 2);
    for sub = 1: nSubjects
        subID = char(options.stats.subjectIDs{sub});
        
        options.condition = 'placebo';
        details = mnket_subjects(subID, options);
        imagePaths{sub, 1} = details.statroot;
        
        options.condition = 'ketamine';
        details = mnket_subjects(subID, options);
        imagePaths{sub, 2} = details.statroot;
    end
    
    % compute the effect of the single-trial regressors on the second level
    tnueeg_2ndlevel_singletrial_groupdiff_paired(scndlvlroot, imagePaths, ...
        regressorNames, conditions)
    disp(['Computed 2nd-level drug difference statistics for regressors ' ...
        'in the ' options.stats.design ' design.']);
end
cd(options.workdir);

diary OFF
end



