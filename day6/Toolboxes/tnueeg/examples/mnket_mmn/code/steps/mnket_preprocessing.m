function D = mnket_preprocessing(id, options)
%MNKET_PREPROCESSING Preprocesses one subject from the MNKET study.
%   IN:     id  - subject identifier, e.g '0001'
%   OUT:    D   - preprocessed data set

% general analysis options
if nargin < 2
    options = mnket_set_analysis_options;
end

% paths and files
[details, paths] = mnket_subjects(id, options);

% record what we're doing
diary(details.logfile);
mnket_display_analysis_step_header('preprocessing', id, options.preproc);

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
    
    % preparation
    spm('defaults', 'eeg');

    % convert bdf
    D = tnueeg_convert(details.rawfile);
    
    % set channel types (EEG, EOG)
    if ~exist(paths.channeldef, 'file')
        chandef = mnket_channel_definition(paths);
    else
        load(paths.channeldef);
    end
    D = tnueeg_set_channeltypes(D, chandef, options);

    % do montage (rereference to average reference, 
    % and create EOG channels)
    if ~exist(paths.montage, 'file')
        error('Please create a montage file first.');
    end
    D = tnueeg_do_montage(D, paths.montage, options);
    
    % filter & downsample
    D = tnueeg_filter(D, 'high', options);
    D = tnueeg_downsample(D, options);
    D = tnueeg_filter(D, 'low', options);        
    
    % epoch according to trial definition
    if ~exist(paths.trialdef, 'file')
        trialdef = mnket_trial_definition(options, paths);
    else
        load(paths.trialdef);
    end
    D = tnueeg_epoch_experimental(D, trialdef, options);
    
    % reject remaining artefacts
    D = tnueeg_reject_remaining_artefacts(D, options);
    
    % finish
    D = move(D, details.prepname);
    numArtefacts = tnueeg_count_artefacts(D, details);
    disp(['Marked ' num2str(numArtefacts) ' trials as bad for subject ' id]);
end

cd(options.workdir);

diary OFF
end
