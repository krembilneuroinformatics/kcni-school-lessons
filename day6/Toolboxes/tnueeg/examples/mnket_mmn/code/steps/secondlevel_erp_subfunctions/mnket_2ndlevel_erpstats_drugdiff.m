function mnket_2ndlevel_erpstats_drugdiff(options)
%MNKET_2NDLEVEL_ERPSTATS_DRUGDIFF Computes the second level contrast
%images for differences in the MMN effect between conditions in the MNKET
%study.
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
mnket_display_analysis_step_header('secondlevel erpstats drugdiff', ...
    'all', options.stats);

% name of the difference wave condition
conditionName = 'mmn';

% results file of first regressor
spmFile = fullfile(paths.erpfold, 'pairedT', conditionName, ...
            'SPM.mat');

try
    % check for previous statistics
    load(spmFile);
    disp(['Drug difference stats for difference waves of ' options.erp.type ...
        ' ERPs have been computed before.']);
    if options.stats.overwrite
        delete(spmFile);
        disp('Overwriting...');
        error('Continue to drug difference ERP step');
    else
        disp('Nothing is being done.');
    end
catch
    disp(['Computing Drug difference stats for difference waves of ' ...
        options.erp.type  ' ERPs...']);
    
    % make sure we have a results directory
    scndlvlroot = fullfile(paths.erpfold, 'pairedT', conditionName);
    if ~exist(scndlvlroot, 'dir')
        mkdir(scndlvlroot);
    end
    
    % smoothed images of averaged ERP data in each subject and each 
    % condition serve as input to 2nd level statistics, but here, we only 
    % indicate the subject-specific directories of the images
    sessions = {'placebo', 'ketamine'};
    nSubjects = numel(options.erp.subjectIDs);
    imagePaths = cell(nSubjects, 2);
    for sub = 1: nSubjects
        subID = char(options.erp.subjectIDs{sub});
        
        options.condition = 'placebo';
        details = mnket_subjects(subID, options);
        imagePaths{sub, 1} = details.convroot;
        
        options.condition = 'ketamine';
        details = mnket_subjects(subID, options);
        imagePaths{sub, 2} = details.convroot;
    end
    
    % compute the drug difference on the MMN on the second level
    tnueeg_2ndlevel_erpstats_groupdiff_paired(scndlvlroot, imagePaths, ...
        conditionName, sessions)
    disp(['Computed 2nd-level drug difference statistics for difference ' ...
        'waves of ' options.erp.type ' ERPs.']);
end
cd(options.workdir);

diary OFF
end



