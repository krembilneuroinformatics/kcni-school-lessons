function [ details, paths ] = mmn_subjects( id, options )
%mmn_SUBJECTS Function that sets all filenames and paths
%   IN:     EITHER (for quering both general and subject-specific paths:
%           id                  - the subject number as a string, e.g. '0001'
%           options (optional)  - the struct that holds all analysis options
%           OR (for only quering general paths & files):
%           options - the struct that holds all analysis options 
%   OUT:    details     - a struct that holds all filenames and paths for
%                       the subject with subject number id
%           paths       - a struct that holds all paths and config files
%                       that are not subject-specific

%-- check input -----------------------------------------------------------------------------------%
if isstruct(id)
    options = id;
    id = 'dummy';
elseif ischar(id) && nargin < 2
    options = mmn_set_analysis_options;
end

%-- general paths and files -----------------------------------------------------------------------%
paths.confroot      = fullfile(options.workdir, 'config');
paths.tonesroot     = fullfile(options.workdir, 'tones');
paths.erproot       = fullfile(options.workdir, 'erp');
paths.statroot      = fullfile(options.workdir, 'stats_model');
paths.erpstatroot   = fullfile(options.workdir, 'stats_erp');
% config files
paths.paradigm      = fullfile(paths.confroot, 'mmn_paradigm.mat');
paths.elec          = fullfile(paths.confroot, 'mmn_sensors.sfp');
paths.channeldef    = fullfile(paths.confroot, 'mmn_chandef.mat');
paths.montage       = fullfile(paths.confroot, 'mmn_avref_eog.mat');
paths.trialdef      = fullfile(paths.confroot, ['mmn_trialdef_' options.preproc.trialdef '.mat']);

% erp analysis folders
paths.erpfold       = fullfile(paths.erproot, options.erp.type);
paths.erpdiffold    = fullfile(paths.erproot, options.erp.type);
paths.erpgafold     = fullfile(paths.erpfold, 'GA');
paths.erpspmfold    = fullfile(paths.erpfold, 'SPM');

% erp analysis files
for iCh = 1: numel(options.erp.channels)
    paths.erpgafiles{iCh} = fullfile(paths.erpgafold, ['tnu_ga_' options.erp.type '_' options.erp.channels{iCh} '.mat']);             
end
paths.spmganame     = ['spm_GA_' options.erp.type '.mat'];  
paths.spmgafile     = fullfile(paths.erpspmfold, paths.spmganame);    

% model stats folders
paths.statfold      = fullfile(paths.statroot);

% erp stats folders
paths.erpstatfold   = fullfile(paths.erpstatroot, options.erp.type);

% erp stats files
paths.erpspmfile    = fullfile(paths.erpstatfold, 'SPM.mat');


% names
details.subjectname  = ['MMN_' id];

details.rawfilename  = [details.subjectname];
details.prepfilename = [details.subjectname '_prep'];
details.erpfilename  = [details.subjectname '_' options.erp.type '_erp'];
details.mergfilename = [details.subjectname '_' options.erp.type '_erp_merged'];

% directories
details.subjectroot = fullfile(options.workdir, 'subjects', details.subjectname);

details.rawroot     = fullfile(details.subjectroot, 'eeg');  
details.tonesroot   = fullfile(details.subjectroot, 'tones');  
details.modelroot   = fullfile(details.subjectroot, 'model');
details.preproot    = fullfile(details.subjectroot, 'spm_prep', options.preproc.eyeblinktreatment);
details.eyeblinkthreshold...
                    = options.preproc.eyeblinkthreshold;
details.windowForEyeblinkdetection = 3;
details.statroot    = fullfile(details.subjectroot, 'spm_stats', options.preproc.eyeblinktreatment);
details.erproot     = fullfile(details.subjectroot, 'spm_erp', options.erp.type);
                    
switch options.conversion.mode
     case 'modelbased'
        details.convroot = fullfile(details.preproot, ...
            [options.conversion.convPrefix '_' details.prepfilename '_modelbased']);
    case 'diffWaves'
        details.convroot = fullfile(details.erproot, ...    
            [options.conversion.convPrefix '_diff_' details.erpfilename]);
    case 'ERPs'
        details.convroot = fullfile(details.erproot, ...
            [options.conversion.convPrefix '_' details.erpfilename]);
end

% files
details.logfile     = fullfile(details.subjectroot, [details.subjectname '.log']);
details.tonestxt    = fullfile(paths.tonesroot, 'textfiles', ['sub' id '.txt']);
details.tonesfile   = fullfile(details.tonesroot, 'tones.mat');
details.eegtones    = fullfile(details.tonesroot, 'eegtones.mat');
details.simfilepre  = fullfile(details.modelroot, 'sim.mat');
details.simfilepost = fullfile(details.modelroot, 'reg.mat');
details.design      = fullfile(details.modelroot, [options.stats.design '_design.mat']);
details.eegdesign   = fullfile(details.modelroot, ...
                    [options.stats.design '_design_eeg_' options.preproc.eyeblinktreatment '.mat']);

details.rawfile     = fullfile(details.rawroot, [details.rawfilename '.bdf']);
details.prepfile    = fullfile(details.preproot, [details.prepfilename '.mat']);
details.prepfile_modelbased = fullfile(details.preproot, [details.prepfilename '_modelbased.mat']);
details.ebfile      = fullfile(details.preproot, ['fEBbfdfMspmeeg_' details.rawfilename '.mat']);

details.trialstats  = fullfile(details.preproot, [details.subjectname '_trialStats.mat']);
details.artefacts   = fullfile(details.preproot, [details.subjectname '_nArtefacts.mat']);
details.eyeblinks   = fullfile(details.preproot, [details.subjectname '_nEyeblinks.mat']);

details.redeffile   = fullfile(details.erproot, ['redef_' details.subjectname '.mat']);
details.avgfile     = fullfile(details.erproot, ['avg_' details.subjectname '.mat']);
details.erpfile     = fullfile(details.erproot, [details.erpfilename '.mat']);
details.difffile    = fullfile(details.erproot, ['diff_' details.erpfilename '.mat']);
details.mergfile    = fullfile(details.erproot, [details.mergfilename]);

% conditions
switch options.conversion.mode
    case 'modelbased'
        details.convCon{1} = 'tone';
    case 'diffWaves' 
        details.convCon{1} = 'mmn';
    case 'ERPs'
        details.convCon{1} = 'standard';
        details.convCon{2} = 'deviant';
end

for i = 1: length(details.convCon)
    details.smoofile{i} = fullfile(details.convroot, ['smoothed_condition_' details.convCon{i} '.nii,']);
end

details.spmfile = fullfile(details.statroot, 'SPM.mat');

% fiducials
details.fid.labels  = {'NAS'; 'LPA'; 'RPA'};
details.fid.data    = [1, 85, -41; -83, -20, -65; 83, -20, -65];

% figures
details.ebdetectfig     = fullfile(details.preproot, [details.subjectname '_eyeblinkDetection.fig']);
details.ebspatialfig    = fullfile(details.preproot, [details.subjectname '_eyeblinkConfounds.fig']);
% only needed for EB rejection:
details.eboverlapfig      = fullfile(details.preproot, [details.subjectname '_eyeblinkTrialOverlap.fig']);
% only needed for EB correction:
details.ebcorrectfig    = fullfile(details.preproot, [details.subjectname '_eyeblinkCorrection.fig']);
details.coregdatafig    = fullfile(details.preproot, [details.subjectname '_coregistration_data.fig']);
details.coregmeshfig    = fullfile(details.preproot, [details.subjectname '_coregistration_mesh.fig']);

details.regressorplots  = fullfile(details.modelroot, [details.subjectname '_' ...
    options.preproc.eyeblinktreatment '_regressor_check']);
details.lowhighPEfigs   = fullfile(details.modelroot, [details.subjectname '_' ...
    options.preproc.eyeblinktreatment '_lowhighPE_check']);
details.firstlevelmaskfig = fullfile(details.statroot, [details.subjectname '_firstlevelmask.fig']);

details.erpfigure         = fullfile(details.erproot, [details.subjectname '_ERP_' ...
    options.erp.electrode '.fig']);

end
