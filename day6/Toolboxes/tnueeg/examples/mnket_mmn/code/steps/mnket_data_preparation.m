function mnket_data_preparation( id, options )
%MNKET_DATA_PREPARATION Puts the tone sequences in place and format for
%modeling beliefs and subsequent EEG analysis for one subject from the
%MNKET study
%   IN:     id  - subject identifier, e.g. '0001'
%   OUT:    --

% general analysis options
if nargin < 2
    options = mnket_set_analysis_options;
end

% paths and files
[details, paths] = mnket_subjects(id, options);

% record what we're doing
diary(details.logfile);
mnket_display_analysis_step_header('data preparation', id, options.prepare);

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

    % find the subject's tone sequence for this session
    tones = mnket_create_model_tone_sequence(id, options, details, paths);
    if isempty(tones)
        error(['No stimulus data found for subject ' id ...
            ' in condition ' options.condition '!']);
    end

    % put the tone sequence in place and format for modeling beliefs
    save(details.tonesfile, 'tones');
    disp(['Placed model tone sequence for subject ' id ...
        ' in condition ' options.condition]);

    % We have a special case for subject MMN_4534: EEG recording
    % started later than audio stimulation, therefore we have to skip the
    % first 29 tones of the sequence for EEG analysis.
    switch id
        case {'4534'}
            switch options.condition
                case {'ketamine'}
                    tones(1: 29) = [];
            end
    end

    % put the tone sequence in place and format for analyzing EEG
    save(details.eegtones, 'tones');
    disp(['Placed EEG tone sequence for subject ' id ...
        ' in condition ' options.condition]);
end

cd(options.workdir);

diary OFF
end

