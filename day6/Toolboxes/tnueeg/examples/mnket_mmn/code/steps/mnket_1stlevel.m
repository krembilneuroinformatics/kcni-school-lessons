function mnket_1stlevel(id, options)
%MNKET_1STLEVEL Computes the first level contrast images for modelbased 
%statistics for one subject from the MNKET study.
%   IN:     id      - subject identifier, e.g '0001'
%           options - the struct that holds all analysis options
%   OUT:    --

% general analysis options
if nargin < 2
    options = mnket_set_analysis_options;
end

% paths and files
[details, ~] = mnket_subjects(id, options);

% record what we're doing
diary(details.logfile);
mnket_display_analysis_step_header('firstlevel stats', id, options.stats);

try
    % check for previous statistics
    load(details.spmfile);
    disp(['1st level stats for subject ' id ' have been computed before.']);
    if options.stats.overwrite
        delete(details.spmfile);
        disp('Overwriting...');
        error('Continue to 1st level stats step');
    else
        disp('Nothing is being done.');
    end
catch
    disp(['Computing 1st level stats for subject ' id ' ...']);
    
    % first, correct the regressors for trials that were rejected during
    % preprocessing
    initialdesign   = getfield(load(details.design), 'design');
    design          = tnueeg_remove_bad_EEG_trials_from_regressors(...
                    details.prepfile, initialdesign);
    save(details.eegdesign, 'design');
    disp(['Corrected regressors for subject ' id]);
    
    % make sure we have a results directory
    facdir = details.statroot;
    if ~exist(facdir, 'dir')
        mkdir(facdir);
    end
    
    % smoothed images of final preprocessed EEG file serve as input for the
    % statistics - one image per trial, but here, we only indicate the path
    % to and basename of the images
    impath = details.smoofile{1};
    
    % compute the regression of the EEG signal onto our single-trial
    % regressors
    tnueeg_singletrial_1stlevel_stats(facdir, impath, design);
    disp(['Computed statistics for subject ' id]);
end
cd(options.workdir);

diary OFF
end



