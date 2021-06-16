function D = mnket_erp(id, options, doPlot)
%MNKET_ERP Computes ERPs for one subject from the MNKET study.
%   IN:     id                  - subject identifier, e.g '0001'
%           doPlot (optional)   - 1 for plotting subject's ERP and saving a
%                               figure, 0 otherwise
%   OUT:    D                   - preprocessed data set

% plotting yes or no
if nargin < 3
    doPlot = 0;
end

% general analysis options
if nargin < 2
    options = mnket_set_analysis_options;
end

% paths and files
[details, ~] = mnket_subjects(id, options);

% record what we're doing
diary(details.logfile);
mnket_display_analysis_step_header('ERP', id, options.erp);

try
    % check for previous ERP analyses
    D = spm_eeg_load(details.difffile);
    disp(['Subject ' id ' has been averaged before.']);
    if options.erp.overwrite
        clear D;
        disp('Overwriting...');
        error('Continue to ERP script');
    else
        disp('Nothing is being done.');
    end
catch
    disp(['Averaging subject ' id ' ...']);

    % check destination folder
    if ~exist(details.erproot, 'dir')
        mkdir(details.erproot);
    end
    cd(details.erproot);

    % make sure the tone sequence for this subject is in place
    %[~] = mnket_find_subject_tones(id, options, details, paths);

    % work on final preprocessed file
    D = spm_eeg_load(details.prepfile);

    % get new condition names
    load(details.eegtones);
    switch options.erp.type
        case 'tone'
            % conditions stay the same
            condlist = [];
        case 'roving'
            condlist = mnket_roving_conditions(tones);
        case 'mmnad'
            condlist = mnket_mmnad_conditions(tones);
        case 'memory'
            condlist = mnket_memory_conditions(tones);
        case 'repetitions'
            condlist = mnket_repetitions_conditions(tones);
    end

    % redefine trials for averaging
    D = tnueeg_redefine_conditions(D, condlist);
    D = copy(D, details.condfile);
    disp(['Redefined conditions for subject ' id]);

    % do the averaging
    D = tnueeg_average(D, options);
    D = copy(D, details.avgfile);
    disp(['Averaged over trials for subject ' id]);

    % in case of robust filtering: re-apply the low-pass filter
    switch options.erp.averaging
        case 'r'
            % make sure we don't delete ERP files during filtering
            options.preproc.keep = 1;
            D = tnueeg_filter(D, 'low', options);
            disp(['Re-applied the low-pass filter for subject ' id]);
        case 's'
            % do nothing
    end
    D = copy(D, details.erpfile);

    % preparation for computing the difference wave
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
    disp(conditions(D));

    % compute the actual contrast
    D = tnueeg_contrast_over_epochs(D, weights, condlabel, options);
    copy(D, details.difffile);
    disp(['Computed the difference wave for subject ' id]);
    
    
    %% not implemented properly yet
    %{
    % plot the ERPs for this subject
    if doPlot
        h = tnueeg_plot_subject_ERPs(D, chanlabel, triallist);
        savefigure(details.erpfigure, 'h');
        disp(['Saved an ERP plot for subject ' id]);    
    end
    %}
    %%
end

cd(options.workdir);

diary OFF
end
