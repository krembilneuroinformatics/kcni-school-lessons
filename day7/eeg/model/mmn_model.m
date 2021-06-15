function design = mmn_model(id, options)
%mmn_MODEL Simulates the beliefs of one subject from the mmn study and saves the trajectories
%for modelbased analysis of EEG data.
%   IN:     id          - subject identifier, e.g '0001'
%           optionally:
%           options     - the struct that holds all analysis options
%   OUT:    design      - the design file which holds the modelbased regressors for this subject

% general analysis options
if nargin < 2
    options = mmn_set_analysis_options;
end

% paths and files
details = mmn_subjects(id, options);

% record what we're doing
diary(details.logfile);
tnueeg_display_analysis_step_header('model', 'mmn', id, options.model);

% check destination folder
if ~exist(details.modelroot, 'dir')
    mkdir(details.modelroot);
end

try
    % check for previous preprocessing
    load(details.design);
    disp(['Subject ' id ' has been modeled before.']);
    if options.model.overwrite
        clear design;
        disp('Overwriting...');
        error('Continue to modeling step.');
    else
        disp('Nothing is being done.');
    end
catch
    disp(['Modeling subject ' id ' ...']);
    
    %-- simulate beliefs --------------------------------------------------------------------------%
    tones = getfield(load(details.tonesfile), 'tones');
    sim = mmn_simulate_beliefs(tones);
    save(details.simfilepre, 'sim');
    fprintf('\nSimulation done.\n\n');
    
    %-- calculate trial-by-trial PEs --------------------------------------------------------------%
    sim = mmn_calculate_regressors(sim);
    save(details.simfilepost, 'sim');
    fprintf('\nPE calculation done.\n\n');
    
    %-- create design files for EEG analysis ------------------------------------------------------%
    design = mmn_create_design_file(sim, options.stats.design);

    save(details.design, 'design');
    fprintf('\nDesign file has been created.\n\n');
    
    fprintf('\nModeling done: subject %s', id);
    disp('   ');
    disp('*----------------------------------------------------*');
    disp('   ');
    
end

cd(options.workdir);
close all

diary OFF
end
