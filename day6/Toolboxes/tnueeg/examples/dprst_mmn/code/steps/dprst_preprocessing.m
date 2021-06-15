function D = dprst_preprocessing(id)
%DPRST_PREPROCESSING Preprocesses one subject from the DPRST study.
%   IN:     id  - subject identifier, e.g '0001'
%   OUT:    D   - preprocessed data set

% general analysis options
if nargin < 2
    options = dprst_set_analysis_options;
end

% paths and files
[details, paths] = dprst_subjects(id, options);

% record what we're doing
diary(details.logfile);
tnueeg_display_analysis_step_header('preprocessing', 'dprst', id, ...
    options.preproc);

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

    %-- preparation ------------------------------------------------------%
    spm('defaults', 'eeg');
    spm_jobman('initcfg');

    % convert .eeg file
    D = tnueeg_convert(details.rawfile);

    % set channel types (EEG, EOG)
    if ~exist(paths.channeldef, 'file')
        chandef = dprst_channel_definition(D, paths, options);
    else
        load(paths.channeldef);
    end
    D = tnueeg_set_channeltypes(D, chandef, options);

    % do montage (rereferencing, but keep EOG channel)
    if ~exist(paths.montage, 'file')
        error('Please create a montage file first.');
    end
    D = tnueeg_do_montage(D, paths.montage, options);
    
    %-- sensor locations -------------------------------------------------%
    % load digitized and corrected electrode positions
    D = tnueeg_sensor_locations(D, details.correlec);

    % transform into MRI space
    D = dprst_transform_locations(D, details.fiducialmat); 
    save(D);

    % project to 2D
    D = tnueeg_project_to_2D(D);

    %-- filtering --------------------------------------------------------%
    D = tnueeg_filter(D, 'high', options);
    D = tnueeg_downsample(D, options);
    D = tnueeg_filter(D, 'low', options);

    %-- eye blink detection ----------------------------------------------%
    Dm = tnueeg_mark_blink_artefacts(D, options);
    numEyeblinks = tnueeg_count_blink_artefacts(Dm);
    save(details.eyeblinks, 'numEyeblinks');
    savefig(details.eyeblinkfig1);
    
    Db = tnueeg_epoch_blinks(Dm, options);
    Db = tnueeg_get_spatial_confounds(Db, options);
    savefig(details.eyeblinkfig2);
    
    %-- experimental epoching --------------------------------------------%
    if ~exist(paths.trialdef, 'file')
        trialdef = dprst_trial_definition(paths, options);
    else
        load(paths.trialdef);
    end
    D = tnueeg_epoch_experimental(Dm, trialdef, options);
    
    %-- eye blink correction & headmodel ---------------------------------%
    D = tnueeg_add_spatial_confounds(D, Db, options);

    fid = load(details.fiducialmat);
    hmJob = tnueeg_headmodel_job(D, fid, details, options);
    spm_jobman('run', hmJob);  
    D = reload(D);

    D = tnueeg_correct_eyeblinks(D, options);

    hmJob = tnueeg_headmodel_job(D, fid, details, options);
    spm_jobman('run', hmJob);
    D = reload(D);
    
    %-- remaining artefact rejection -------------------------------------%
    D = tnueeg_reject_remaining_artefacts(D, options);
    
    %-- finish -----------------------------------------------------------%
    D = move(D, details.prepfilename);
    numArtefacts = tnueeg_count_artefacts(D, details);
    
    disp(['Detected ' num2str(numEyeblinks) ' eye blinks for subject ' id]);
    disp(['Rejected ' num2str(numArtefacts) ' bad trials for subject ' id]);
end

cd(options.workdir);

diary OFF
end
