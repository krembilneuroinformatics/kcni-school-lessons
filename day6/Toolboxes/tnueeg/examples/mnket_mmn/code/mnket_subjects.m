function [ details, paths ] = mnket_subjects( id, options )
%MNKET_SUBJECTS Function that sets all filenames and paths
%   IN:     EITHER (for quering both general and subject-specific paths:
%           id                  - the subject number as a string, e.g. '0001'
%           options (optional)  - the struct that holds all analysis options
%           OR (for only quering general paths & files):
%           options - the struct that holds all analysis options 
%   OUT:    details     - a struct that holds all filenames and paths for
%                       the subject with subject number id
%           paths       - a struct that holds all paths and config files
%                       that are not subject-specific

%-- check input ----------------------------------------------------------%
if isstruct(id)
    options = id;
    id = 'dummy';
elseif ischar(id) && nargin < 2
    options = mnket_set_analysis_options;
end

%-- subject-specific paths and files -------------------------------------%
% raw file names
switch options.condition
    case 'placebo'
        rawsuffix = '_1_pla';
    case 'ketamine'
        rawsuffix = '_1_ket';
end

% names
details.subrawname  = ['TNU_MNKET_' id];
details.subproname  = ['MMN_' id];

details.filrawname  = [details.subproname rawsuffix];
details.prepname    = [details.subproname '_' options.preproc.trialdef ...
                        '_prep'];
details.mergname    = [details.subproname '_' options.erp.type ...
                        '_merged'];
details.erpname     = [options.erp.addfilter options.erp.averaging ...
                        'm' details.subproname];

% directories
details.rawroot     = fullfile(options.workdir, 'data', 'raw', ...
                        details.subrawname, 'eegdata');
details.proroot     = fullfile(options.workdir, 'data', 'pro', ...
                        'subjects', options.condition, details.subproname);

details.modelroot   = fullfile(details.proroot, 'model');                    
details.preproot    = fullfile(details.proroot, 'spm_prep', ...
                        options.preproc.trialdef);
details.statroot    = fullfile(details.proroot, 'spm_stats', ...
                        options.stats.design);
details.erproot     = fullfile(details.proroot, 'spm_erp', ...
                        options.erp.type);
                    
switch options.conversion.mode
     case 'modelbased'
        details.convroot = fullfile(details.preproot, ...
            [options.conversion.convTime '_' details.prepname]);
    case 'diffWaves'
        details.convroot = fullfile(details.erproot, ...    
            [options.conversion.convTime '_diff_' details.erpname]);
    case 'ERPs'
        details.convroot = fullfile(details.erproot, ...
            [options.conversion.convTime '_' details.erpname]);
    case 'mERPs'
        details.convroot = fullfile(details.erproot, ...
            [options.conversion.convTime '_' details.mergname]);
end

% files
details.logfile     = fullfile(details.proroot, ...
                        [details.subproname '.log']);
details.tonestxt    = fullfile(options.workdir, 'data', 'raw', 'tonesequences', ...
                        'textfiles', options.condition, ['sub' id '.txt']);
details.tonesfile   = fullfile(details.proroot, 'tones', 'tones.mat');
details.eegtones    = fullfile(details.proroot, 'tones', 'eegtones.mat');
details.simfilepre  = fullfile(details.modelroot, 'sim.mat');
details.simfilepost = fullfile(details.modelroot, 'reg.mat');
details.design      = fullfile(details.modelroot, ...
                        [options.stats.design '_design.mat']);
details.eegdesign   = fullfile(details.modelroot, ...
                        [options.stats.design '_design_eeg.mat']);

details.rawfile     = fullfile(details.rawroot, ...
                        [details.filrawname '.bdf']);
details.prepfile    = fullfile(details.preproot, ...
                        [details.prepname '.mat']);

details.artefacts   = fullfile(details.preproot, ...
                        [details.subproname '_' options.preproc.trialdef ...
                        '_nArtefacts.mat']);
details.eyeblinks   = fullfile(details.preproot, ...
                        [details.subproname '_nEyeblinks.mat']);

details.condfile     = fullfile(details.erproot, ...
                        [details.subproname '.mat']);
details.avgfile     = fullfile(details.erproot, ...
                        [options.erp.averaging 'm' ...
                        details.subproname '.mat']);
details.erpfile     = fullfile(details.erproot, ...
                        [details.erpname '.mat']);
details.difffile    = fullfile(details.erproot, ...
                        ['diff_' details.erpname '.mat']);
details.mergfile    = fullfile(details.erproot, ...
                        [details.mergname]);

% conditions
switch options.conversion.mode
    case 'modelbased'
        details.convCon{1} = 'tone';
    case 'diffWaves' 
        details.convCon{1} = 'mmn';
    case 'ERPs'
        details.convCon{1} = 'standard';
        details.convCon{2} = 'deviant';
    case 'mERPs'
        details.convCon{1} = 'deviantplacebo';
        details.convCon{2} = 'standardplacebo';
        details.convCon{3} = 'deviantketamine';
        details.convCon{4} = 'standardketamine';
end

for i = 1: length(details.convCon)
    details.convfile{i} = fullfile(details.convroot, ...
        ['condition_' details.convCon{i} '.nii,']);
    details.smoofile{i} = fullfile(details.convroot, ...
        ['smoothed_condition_' details.convCon{i} '.nii,']);
end

details.spmfile = fullfile(details.statroot, 'SPM.mat');

% fiducials
details.fid.labels  = {'NAS'; 'LPA'; 'RPA'};
details.fid.data    = [1, 85, -41; -83, -20, -65; 83, -20, -65];

% figures
details.eyeblinkfig1    = fullfile(details.preproot, ...
                            [details.subproname '_eyeblinkDetection.fig']);
details.eyeblinkfig2    = fullfile(details.preproot, ...
                            [details.subproname '_eyeblinkConfounds.fig']);
details.erpfig          = fullfile(details.erproot, ...
                            [details.subproname '_ERP.fig']);

%-- general paths and files ----------------------------------------------%
paths.confroot      = fullfile(options.workdir, 'conf');
paths.erproot       = fullfile(options.workdir, 'data', 'pro', 'erpanalysis');
paths.erpfold       = fullfile(paths.erproot, options.erp.type);
paths.erpspmfile    = fullfile(paths.erpfold, options.condition, ...
                    options.erp.contrastName, 'SPM.mat');
paths.erpgafile     = fullfile(paths.erpfold, options.condition, ...
                    'GA', ['GA_' options.condition '_' options.erp.type ...
                    '_' options.erp.electrode '.mat']);         
paths.spmganame     = ['spm_GA_' options.condition '_' options.erp.type ...
                    '.mat'];                
paths.spmgafile     = fullfile(paths.erpfold, options.condition, ...
                    'GA', paths.spmganame);
paths.diffgafile    = fullfile(paths.erpfold, 'drugdiff', ...
                    ['GA_diffwaves_' options.erp.type '.mat']);                
paths.statroot      = fullfile(options.workdir, 'data', 'pro', ...
                    'modelbased', options.stats.design);   
paths.diffroot      = fullfile(paths.statroot, 'drugdiff');                   

% config files
paths.paradigm      = fullfile(paths.confroot, 'mnket_paradigm.mat');
paths.channeldef    = fullfile(paths.confroot, 'mnket_chandef.mat');
paths.montage       = fullfile(paths.confroot, 'mnket_avref_eog.mat');
paths.elec          = fullfile(paths.confroot, 'mnket_sensors.sfp');
paths.trialdef      = fullfile(paths.confroot, ...
                    ['mnket_trialdef_' options.preproc.trialdef '.mat']);

% logging 2nd level analyses
paths.logfile       = fullfile(options.workdir, 'data', 'pro', ...
                    'secondlevel.log');

end
