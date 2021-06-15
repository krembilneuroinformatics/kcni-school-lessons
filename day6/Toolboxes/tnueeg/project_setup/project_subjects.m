function [ details ] = project_subjects( id, options )
%PROJECT_SUBJECTS Template subjects function for a new project
%   This function defines all your paths and filenames, relative to the
%   project folder (which is saved in the options.workdir). The names in
%   this template function are only examples and you can define the paths
%   and names in whichever way you like.
%   IN:     id          - the subject number as a string, e.g. '0001'
%           optional:
%               options - the struct that holds all analysis options
%   OUT:    details     - a struct that holds all filenames and paths

% pid refers to the project ID, e.g. DPRST

if nargin < 2
    options = project_set_analysis_options;
end

% names
details.pid         = 'PPID'; % enter your project name, e.g. 'DPRST'
details.subjectname = [details.pid '_' id]; 
details.rawname     = [details.subjectname '']; % in most cases, the raw data files will have some additional string
details.prepname    = [details.subjectname '_prep'];
details.erpname     = [options.erp.addfilter options.erp.averaging 'm' details.subjectname];

% directories
details.subjectroot = [options.workdir '/data/subjects/' details.subjectname '/'];
details.behavroot   = [details.subjectroot '/behav/'];
details.smriroot    = [details.subjectroot '/smri/'];
details.digiroot    = [details.subjectroot '/digit/'];
details.rawroot     = [details.subjectroot '/eeg/'];
details.preproot    = [details.subjectroot '/spm_prep/'];
details.statroot    = [details.subjectroot '/spm_stats/'];
details.erproot     = [options.workdir '/data/erpanalysis/'];
switch options.stats.mode
    case 'ERPs'
        details.convroot = [details.erpfold options.stats.convTime '_' details.erpname '/'];
     case 'modelbased'
        details.convroot = [details.preproot options.stats.convTime '_' details.prepname '/'];
end


% files
details.design      = [details.subjectroot 'model/' options.stats.design '_design.mat'];
details.eegdesign   = [details.subjectroot 'model/' options.stats.design '_design_eeg.mat'];
% the 'eegdesign' refers to the regressors of a single-trial analysis after
% they have been corrected for bad trials in the EEG

details.rawfile     = [details.rawroot details.rawname '.eeg'];
details.prepfile    = [details.preproot details.prepname '.mat'];

details.artefacts   = [details.preproot details.subjectname '_' options.preproc.trialdef '_nArtefacts.mat'];
details.eyeblinks   = [details.preproot details.subjectname '_nEyeblinks.mat'];

details.erpfile     = [details.erpfold details.subjectname '.mat'];
details.avgfile     = [details.erpfold options.erp.averaging 'm' details.subjectname '.mat'];
details.filfile     = [details.erpfold details.erpname '.mat'];

% for conversion and smoothing, we need to know the names of the conditions
% in the EEG data sets
switch options.stats.mode
    case 'ERPs'
        details.convCon{1} = 'standard';
        details.convCon{2} = 'deviant';
    case 'modelbased'
        details.convCon{1} = 'tone';
end

for i = 1: length(details.convCon)
    details.convfile{i} = [details.convroot 'condition_' details.convCon{i} '.nii,'];
    details.smoofile{i} = [details.convroot 'smoothed_condition_' details.convCon{i} '.nii,'];
end

% figures
details.eyeblinkfig1    = [details.preproot details.subjectname '_eyeblinkDetection.fig'];
details.eyeblinkfig2    = [details.preproot details.subjectname '_eyeblinkConfounds.fig'];
details.erpfig          = [details.erpfold 'figures/' details.subjectname '_filtered.fig'];

% config files
details.paradigm    = [options.workdir '/config/' pid '_paradigm.mat'];
details.channeldef  = [options.workdir '/config/' pid '_chandef.mat'];
details.montage     = [options.workdir '/config/' pid '_avref_eog.mat'];
details.elec        = [options.workdir '/config/' pid '_sensors.sfp'];
details.fid.labels  = {'NAS'; 'LPA'; 'RPA'};
details.fid.data    = [1, 85, -41; -83, -20, -65; 83, -20, -65];
details.trialdef    = [options.workdir '/config/' pid '_trialdef_' options.preproc.trialdef '.mat'];

end
