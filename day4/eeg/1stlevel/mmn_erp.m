function D = mmn_erp(id, options, doPlot)
%mmn_ERP Computes ERPs for one subject from the mmn study.
%   IN:     id                  - subject identifier, e.g '0001'
%           doPlot (optional)   - 1 for plotting subject's ERP and saving a
%                               figure, 0 otherwise
%   OUT:    D                   - preprocessed data set

% plotting yes or no
if nargin < 3
    doPlot = 1;
end

% general analysis options
if nargin < 2
    options = mmn_set_analysis_options;
end

% paths and files
[details, ~] = mmn_subjects(id, options);

% prepare spm
spm('defaults', 'EEG');

% record what we're doing
diary(details.logfile);
mmn_display_analysis_step_header('ERP', id, options.erp);

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
    fprintf('\nAveraging subject %s ...\n\n', id);

    %-- preparation -------------------------------------------------------------------------------%
    % check destination folder
    if ~exist(details.erproot, 'dir')
        mkdir(details.erproot);
    end
    cd(details.erproot);

    % work on final preprocessed file
    switch options.conversion.mode
        case 'modelbased'
            % in the modelbased analysis, we have to remove the first EEG trial because the model 
            % only defines PEs starting from the 2nd tone (1st observed transition)            
                prepfile = mmn_remove_first_EEG_trial(details, options);
    end
    
    switch options.erp.type
       case {'lowhighEpsi2', 'lowhighEpsi3'}
           D = spm_eeg_load(details.prepfile_modelbased);
       otherwise
            D = spm_eeg_load(details.prepfile);
    end

    %-- redefinition ------------------------------------------------------------------------------%
    % get new condition names
    load(details.eegtones);
    switch options.erp.type
        case 'lowhighEpsi2'
            load(details.design);
            condlist = mmn_lowhighPE_conditions(design.epsilon2, ...
                '\epsilon_2', options);
            savefig([details.lowhighPEfigs '_epsi2.fig']);  
        case 'lowhighEpsi3'
            load(details.design);
            condlist = mmn_lowhighPE_conditions(design.epsilon3, ...
                '\epsilon_3', options);
            savefig([details.lowhighPEfigs '_epsi3.fig']);
    end

    switch options.preproc.eyeblinktreatment
        case 'reject'
            switch options.erp.type
                case 'tone'
                    % we already have only the trials that are still in D
                otherwise
                    condlist = mmn_correct_conditions_for_eyeblinktrials(condlist, details.trialstats);
            end
    end
    
    % redefine trials for averaging
    D = tnueeg_redefine_conditions(D, condlist);
    D = copy(D, details.redeffile);
    disp(['Redefined conditions for subject ' id]);

    %-- averaging ---------------------------------------------------------------------------------%
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

    %-- ERP plot ----------------------------------------------------------------------------------%
    chanlabel = options.erp.electrode;
    switch options.erp.type
        case {'roving', 'mmnad'}
            triallist = {'standard', 'Standard Tones', [0 0 1]; ...
                        'deviant', 'Deviant Tones', [1 0 0]};
        case {'lowhighEpsi2', 'lowhighEpsi3'}
            triallist = {'low', 'Lowest 10 %', [0 0 1]; ...
                        'high', 'Highest 10 %', [1 0 0]};
        case 'tone'
            triallist = {'tone', 'All tone events', [0 0 1]};
    end
    if doPlot
        h = tnueeg_plot_subject_ERPs(D, chanlabel, triallist);
        h.Children(2).Title.String = ['Subject ' id ': ' options.erp.type ' ERPs'];
        savefig(h, details.erpfigure);
        fprintf('\nSaved an ERP plot for subject %s\n\n', id);    
    end
    
    %-- difference waves --------------------------------------------------------------------------%
    switch options.erp.type
        case {'roving', 'mmnad'}
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
        case {'lowhighEpsi2', 'lowhighEpsi3'}
            % preparation for computing the difference wave
            % determine condition order within the D object
            idxLow = indtrial(D, 'low');
            idxHigh = indtrial(D, 'high');

            % set weights such that we substract standard trials from deviant
            % trials, give the new condition a name
            weights = zeros(1, ntrials(D));
            weights(idxHigh) = 1;
            weights(idxLow) = -1;
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
    end    
end

close all
cd(options.workdir);

diary OFF
end
