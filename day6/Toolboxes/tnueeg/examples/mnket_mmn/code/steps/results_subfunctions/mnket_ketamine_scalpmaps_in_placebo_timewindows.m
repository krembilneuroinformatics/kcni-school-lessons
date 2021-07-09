function [] = mnket_ketamine_scalpmaps_in_placebo_timewindows( options )
%MNKET_KETAMINE_SCALPMAPS_IN_PLACEBO_TIMEWINDOWS
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
mnket_display_analysis_step_header(...
    'Ketamine scalpmaps in Placebo timewindows', ...
    'all', options.stats);

% names of the single-trial regressors
regressorNames = options.stats.regressors;

spmRootKet = fullfile(paths.statroot, 'ketamine');
spmRootPla = fullfile(paths.statroot, 'placebo');
scmFolder = fullfile(spmRootKet, regressorNames{1}, 'smaps_in_pla_twindows');

try
    % check for previous section overlay
    if exist(scmFolder, 'dir')
        disp(['scalpmaps for regressors in ' options.stats.design ...
        ' design (ketamine in placebo times)' ...
        ' have been created before.']);
        if options.stats.overwrite
            disp('Overwriting...');
            error('Continue to scalpmap step');
        else
            disp('Nothing is being done.');
        end
    else
        error('Cannot find previous scalpmaps');
    end
catch
    disp(['Creating scalpmaps for regressors in the ' ...
        'ketamine condition in placebo timewindows in the ' ...
        options.stats.design  ' design...']);
    
    % go through all regressors
    for iReg = 1: numel(regressorNames)
        
        scmFolder = fullfile(spmRootKet, regressorNames{iReg}, ...
            'smaps_in_pla_twindows');
        if ~exist(scmFolder, 'dir')
            mkdir(scmFolder)
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
        configs = mnket_configure_scalpmaps(con, options, [0 65]);
        cd(scmFolder);
        tnueeg_scalpmaps_per_cluster( con, configs );

    end
end
cd(options.workdir);

diary OFF
end
