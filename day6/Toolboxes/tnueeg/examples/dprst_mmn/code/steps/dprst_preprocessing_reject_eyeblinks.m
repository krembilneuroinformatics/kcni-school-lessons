function D = dprst_preprocessing_reject_eyeblinks(id, options)
%DPRST_PREPROCESSING Preprocesses one subject from the DPRST study.
%   IN:     id      - subject identifier, e.g '0001'
%           optionally:
%           options - the struct that holds all analysis options
%   OUT:    D       - preprocessed data set

% general analysis options
if nargin < 2
    options = dprst_set_analysis_options;
end

% paths and files
[details, paths] = dprst_subjects(id, options);

% record what we're doing
diary(details.logfile);
tnueeg_display_analysis_step_header('preprocessing', 'dprst', id, options.preproc);

% check destination folder
if ~exist(details.preproot, 'dir')
    mkdir(details.preproot);
end
cd(details.preproot);

try
    % check for previous preprocessing
    D = spm_eeg_load(details.prepfile);
    disp(['Subject ' id ' has been preprocessed before.']);
    if options.preproc.overwrite
        clear D;
        disp('Overwriting...');
        error('Continue to preprocessing script');
    else
        disp('Nothing is being done.');
    end
catch
    disp(['Preprocessing subject ' id ' ...']);

    %-- preparation -------------------------------------------------------------------------------%
    spm('defaults', 'eeg');
    spm_jobman('initcfg');

    % convert .eeg file
    D = tnueeg_convert(details.rawfile);
    fprintf('\nConversion done.\n\n');

    % set channel types (EEG, EOG)
    if ~exist(paths.channeldef, 'file')
        chandef = dprst_channel_definition(D, paths, options);
    else
        load(paths.channeldef);
    end
    D = tnueeg_set_channeltypes(D, chandef, options);
    fprintf('\nChanneltypes done.\n\n');

    % do montage (rereferencing, but keep EOG channel)
    if ~exist(paths.montage, 'file')
        error('Please create a montage file first.');
    end
    D = tnueeg_do_montage(D, paths.montage, options);
    fprintf('\nMontage done.\n\n');
    
    %-- sensor locations --------------------------------------------------------------------------%
    % load digitized and corrected electrode positions
    D = tnueeg_sensor_locations(D, details.correlec);
    fprintf('\nSensor locations done.\n\n');

    % transform into MRI space
    D = dprst_transform_locations(D, details.fiducialmat); 
    save(D);
    fprintf('\nLocation transformation done.\n\n');

    % project to 2D
    D = tnueeg_project_to_2D(D);
    fprintf('\n2D Projection done.\n\n');

    %-- filtering ---------------------------------------------------------------------------------%
    D = tnueeg_filter(D, 'high', options);
    D = tnueeg_downsample(D, options);
    D = tnueeg_filter(D, 'low', options);
    fprintf('\nFilters & Downsampling done.\n\n');

    %-- eye blink detection -----------------------------------------------------------------------%
    [Dm, trialStats.numEyeblinks] = tnueeg_eyeblink_detection_spm(D, options);
    savefig(details.eyeblinkfig);
    fprintf('\nEye blink detection done.\n\n');
    
    %-- eye blink rejection -----------------------------------------------------------------------%
    if ~exist(paths.trialdef, 'file')
        trialdef = dprst_trial_definition(paths, options);
    else
        load(paths.trialdef);
    end
    [Dc, ~, trialStats.numEyeartefacts, trialStats.idxEyeartefacts, trialStats.nTrialsNoBlinks, fh] = ...
        tnueeg_eyeblink_rejection_on_continuous_eeg(Dm, trialdef, options);
    savefig(fh, details.overlapfig)
    fprintf('\nEye blink rejection done.\n\n');
        
    %-- experimental epoching ---------------------------------------------------------------------%
    D = tnueeg_epoch_experimental(Dc, trialdef, options);
    fprintf('\nExperimental epoching done.\n\n');
    
    %-- headmodel ---------------------------------------------------------------------------------%
    fid     = load(details.fiducialmat);
    hmJob   = tnueeg_headmodel_job(D, fid, details, options);
    spm_jobman('run', hmJob);  
    D       = reload(D);
    fprintf('\nHeadmodel done.\n\n');
    
    %-- final artefact rejection ------------------------------------------------------------------%
    %D               = tnueeg_eyeblink_rejection_on_epochs_tnu(D, idxEyeartefacts);
    [D, trialStats.numArtefacts, trialStats.idxArtefacts, trialStats.badChannels] = ...
        tnueeg_artefact_rejection_threshold(D, options);
    fprintf('\nArtefact rejection done.\n\n');
    
    %-- finish ------------------------------------------------------------------------------------%
    D = move(D, details.prepfilename);
    trialStats.nTrialsFinal = tnueeg_count_good_trials(D);
    save(details.trialstats, 'trialStats');
    
    disp('   ');
    disp(['Detected ' num2str(trialStats.numEyeblinks) ' eye blinks for subject ' id]);
    disp(['Excluded ' num2str(trialStats.numEyeartefacts.all) ' trials due to eye blinks.']);
    disp(['Rejected ' num2str(trialStats.numArtefacts) ' additional bad trials.']);
    disp(['Marked ' num2str(trialStats.badChannels.numBadChannels) ' channels as bad.']);
    disp([num2str(trialStats.nTrialsFinal.all) ' remaining good trials in D.']);
    fprintf('\nPreprocessing done: subject %s in task DPRST-MMN.\n', id);
    disp('   ');
    disp('*----------------------------------------------------*');
    disp('   ');
end

cd(options.workdir);
close all

diary OFF
end
