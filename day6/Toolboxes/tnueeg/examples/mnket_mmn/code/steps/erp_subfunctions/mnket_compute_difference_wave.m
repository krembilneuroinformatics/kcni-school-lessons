function D = mnket_compute_difference_wave(id, options)
%MNKET_COMPUTE_DIFFERENCE_WAVE Computes difference wave for one subject 
%from the MNKET study.
%   IN:     id                  - subject identifier, e.g '0001'
%   OUT:    D                   - data set with condition 'mmn'

% general analysis options
if nargin < 2
    options = mnket_set_analysis_options;
end

% paths and files
[details, ~] = mnket_subjects(id, options);

% record what we're doing
diary(details.logfile);
mnket_display_analysis_step_header('diffwave', id, options.erp);

try
    % check for previous ERP analyses
    D = spm_eeg_load(details.difffile);
    disp(['Difference wave has been computed for subject ' id ' before.']);
    if options.erp.overwrite
        clear D;
        disp('Overwriting...');
        error('Continue to DiffWave script');
    else
        disp('Nothing is being done.');
    end
catch
    disp(['Computing difference wave for subject ' id ' ...']);
    
    % load the dataset that contains the (averaged) conditions we want to
    % contrast
    try
        D = spm_eeg_load(details.erpfile);
    catch
        disp(['Could not find ' details.erpfile]);
        error('No averaged subject file')
    end

    % determine condition order within the D object
    idxDeviants = indtrial(D, 'deviant');
    idxStandards = indtrial(D, 'standard');
    
    % set weights such that we substract standard trials from deviant
    % trials, give the new condition a name
    weights = zeros(1, ntrials(D));
    weights(idxDeviants) = 1;
    weights(idxStandards) = -1;
    condlabel = {'mmn'};
    
    % sanity check for logfile
    disp('Difference wave will be computed using:');
    disp(weights);
    disp('as weights on these conditions:');
    disp(condlist(D));

    % compute the actual contrast
    D = tnueeg_contrast_over_epochs(D, weights, condlabel, options);
    copy(D, details.difffile);    
    disp(['Computed the difference wave for subject ' id]);
end

cd(options.workdir);

diary OFF
end