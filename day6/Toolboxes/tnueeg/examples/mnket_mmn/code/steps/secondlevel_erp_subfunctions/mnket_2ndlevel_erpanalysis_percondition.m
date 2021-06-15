function mnket_2ndlevel_erpanalysis_percondition(options)
%MNKET_2NDLEVEL_ERPANALYSIS_PERCONDITION Computes the grandaverages of ERPs
%in one condition in the MNKET study.
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
mnket_display_analysis_step_header('secondlevel erpanalysis main', ...
    'all', options.erp);

try
    % check for previous erpanalysis
    load(paths.erpgafile);
    disp(['Grand averages of ' options.erp.type ' ERPs have been ' ...
        'computed before.']);
    if options.erp.overwrite
        clear ga;
        disp('Overwriting...');
        error('Continue to grand average step');
    else
        disp('Nothing is being done.');
    end
catch
    disp(['Computing grand averages of ' options.erp.type  ' ERPs...']);
    
    % make sure we have a results directory
    GAroot = fullfile(paths.erpfold, options.condition, 'GA');
    if ~exist(GAroot, 'dir')
        mkdir(GAroot);
    end
    
    % averaged ERP data in one condition in each subject
    % serve as input to 2nd level grand averages 
    nSubjects = numel(options.erp.subjectIDs);
    erpfiles = cell(nSubjects, 1);
    for sub = 1: nSubjects
        subID = char(options.erp.subjectIDs{sub});
        details = mnket_subjects(subID, options);
        erpfiles{sub, 1} = details.erpfile;
    end
    
    % compute the grand averages and variance estimates for one electrode
    ga = tnueeg_grandmean_with_error(erpfiles, options.erp.electrode, 1);
    save(paths.erpgafile, 'ga');

    % compute the grand averages for all electrodes using SPM
    D = tnueeg_grandmean_spm(erpfiles, paths.spmganame);
    copy(D, paths.spmgafile);
    disp(['Computed grand averages of ' options.erp.type ' ERPs '...
        'in condition ' options.condition]);
end
cd(options.workdir);

diary OFF
end



