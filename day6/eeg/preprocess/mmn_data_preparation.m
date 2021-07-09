function mmn_data_preparation( id, options )
%mmn_DATA_PREPARATION Puts the tone sequences in place and format for
%modeling beliefs and subsequent EEG analysis for one subject from the
%mmn study
%   IN:     id          - subject identifier, e.g. '0001'
%           options     - the struct that holds all analysis options
%   OUT:    --

% general analysis options
if nargin < 2
    options = mmn_set_analysis_options;
end

% paths and files
[details, paths] = mmn_subjects(id, options);

% record what we're doing
diary(details.logfile);
mmn_display_analysis_step_header('data preparation', id, options.prepare);

% check destination folder
if ~exist(details.tonesroot, 'dir')
    mkdir(details.tonesroot);
end
    
try
    % check for previous preparation
    load(details.eegtones);
    disp(['Subject ' id ' has been prepared before.']);
    if options.prepare.overwrite
        clear tones;
        disp('Overwriting...');
        error('Continue to preparation script');
    else
        disp('Nothing is being done.');
    end
catch
    disp(['Preparing subject ' id ' ...']);
    
    %-- experimental tone sequences ---------------------------------------------------------------%
    % find the subject's tone sequence for this session
    tones = mmn_create_subject_tone_sequence(id, options, details, paths);
    if isempty(tones)
        error(['No stimulus data found for subject ' id ' in condition ' options.condition '!']);
    end

    % put the tone sequence in place and format for modeling beliefs
    save(details.tonesfile, 'tones');
    disp(['Placed tone sequence for subject ' id]);

    % put the tone sequence in place and format for analyzing EEG
    save(details.eegtones, 'tones');
    disp(['Placed EEG tone sequence for subject ' id]);
end

cd(options.workdir);

diary OFF
end