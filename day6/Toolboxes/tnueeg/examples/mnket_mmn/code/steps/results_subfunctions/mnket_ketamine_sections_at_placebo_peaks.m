function [] = mnket_ketamine_sections_at_placebo_peaks( options )
%MNKET_KETAMINE_SECTIONS_AT_PLACEBO_PEAKS
%   IN:     options - the struct that holds all analysis options
%   OUT:    --

% general analysis options
if nargin < 1
    options = mnket_set_analysis_options;
end

% paths and files
[~, paths] = mnket_subjects(options);

% record what we're doing
diary(paths.logfile);
mnket_display_analysis_step_header('Ketamine sections on Placebo peaks', ...
    'all', options.stats);

% names of the single-trial regressors
regressorNames = options.stats.regressors;

spmRootKet = fullfile(paths.statroot, 'ketamine');
spmRootPla = fullfile(paths.statroot, 'placebo');
secFolder = fullfile(spmRootKet, regressorNames{1}, 'secs_on_pla_peaks');

try
    % check for previous section overlay
    if exist(secFolder, 'dir')
        disp(['section overlays for regressors in ' options.stats.design ...
        ' design (ketamine on placebo peaks)' ...
        ' have been created before.']);
        if options.stats.overwrite
            disp('Overwriting...');
            error('Continue to sec overlay step');
        else
            disp('Nothing is being done.');
        end
    else
        mkdir(secFolder);
        error('Cannot find previous overlays');
    end
catch
    disp(['Creating sections for regressors in the ' ...
        'ketamine condition on placebo peak coordinates in the ' ...
        options.stats.design  ' design...']);
    
    % go through all regressors
    for iReg = 1: numel(regressorNames)
        secFolder = fullfile(spmRootKet, regressorNames{iReg}, ...
            'secs_on_pla_peaks');
        if ~exist(secFolder, 'dir')
            mkdir(secFolder);
        end

        % load the con structs and replace cluster info in ketamine with
        % cluster info from placebo
        list = dir(fullfile(spmRootPla, regressorNames{iReg}, ...
            ['con_*_' options.stats.pValueMode '.mat']));
        load(fullfile(spmRootPla, regressorNames{iReg}, list.name));
        
        con_pla = con;
        
        list2 = dir(fullfile(spmRootKet, regressorNames{iReg}, ...
            ['con_*_' options.stats.pValueMode '.mat']));
        load(fullfile(spmRootKet, regressorNames{iReg}, list2.name));
        
        con.clusters = con_pla.clusters;
        con.nClusters = con_pla.nClusters;

        % load the xSPM struct
        list3 = dir(fullfile(spmRootKet, regressorNames{iReg}, ...
            ['xSPM_*_' options.stats.pValueMode '.mat']));
        load(fullfile(spmRootKet, regressorNames{iReg}, list3.name));
        
        %-- plot all sections overlays -----------------------------------%
        cd(secFolder);
        tnueeg_overlay_sections_per_cluster(xSPM, con);

    end
end
cd(options.workdir);

diary OFF
end
