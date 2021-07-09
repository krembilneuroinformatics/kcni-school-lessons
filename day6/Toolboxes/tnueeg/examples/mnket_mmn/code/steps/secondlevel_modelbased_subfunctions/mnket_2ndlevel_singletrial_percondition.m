function mnket_2ndlevel_singletrial_percondition(options)
%MNKET_2NDLEVEL_SINGLETRIAL_PERCONDITION Computes the second level contrast
%images for single-trial (modelbased) regressors in one condition of the 
%MNKET study.
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
mnket_display_analysis_step_header('secondlevel singletrial main', ...
    'all', options.stats);

% names of the single-trial regressors
regressorNames = options.stats.regressors;

% results file of first regressor
spmFile = fullfile(paths.statroot, options.condition, regressorNames{1}, ...
            'SPM.mat');

try
    % check for previous statistics
    load(spmFile);
    disp(['2nd level stats for regressors in ' options.stats.design ...
        ' design in condition ' options.condition ...
        ' have been computed before.']);
    if options.stats.overwrite
        delete(spmFile);
        disp('Overwriting...');
        error('Continue to 2nd level stats step');
    else
        disp('Nothing is being done.');
    end
catch
    disp(['Computing 2nd level stats for regressors for ' ...
        options.condition ' condition in the ' ...
        options.stats.design  ' design...']);
    
    % make sure we have a results directory
    if ~exist(paths.statroot, 'dir')
        mkdir(paths.statroot);
    end
    
    scndlvlroot = fullfile(paths.statroot, options.condition);
    if ~exist(scndlvlroot, 'dir')
        mkdir(scndlvlroot);
    end
    
    % beta images of 1st level regression for each regressor in each
    % subject serve as input to 2nd level statistics, but here, we only
    % indicate the subject-specific directory of the beta images
    nSubjects = numel(options.stats.subjectIDs);
    imagePaths = cell(nSubjects, 1);
    for sub = 1: nSubjects
        subID = char(options.stats.subjectIDs{sub});
        details = mnket_subjects(subID, options);
        imagePaths{sub, 1} = details.statroot;
    end
    
    % compute the effect of the single-trial regressors on the second level
    tnueeg_2ndlevel_singletrial_stats(scndlvlroot, imagePaths, ...
        regressorNames)
    disp(['Computed 2nd-level statistics for regressors for ' ...
        options.condition ' condition in the ' ...
        options.stats.design  ' design...']);
end
cd(options.workdir);

diary OFF
end



