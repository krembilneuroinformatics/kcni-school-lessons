function mmn_dcm(id, options)
%mmn_dcm Computes DCMs for one subject from the mmn study.
%   IN:     id                  - subject identifier, e.g '0001'
%   OUT:    D                   - DCM structure file


%% General options
% analysis options
if nargin < 2
    options = mmn_set_analysis_options;
end

% paths and files
[details, ~] = mmn_subjects(id, options);

% prepare spm
spm('defaults', 'EEG');

% record what we're doing
diary(details.logfile);
mmn_display_analysis_step_header('DCM', id, options.dcm);

% check destination folder
if ~exist(details.dcmroot, 'dir')
    mkdir(details.dcmroot);
end

%% Model definition
%--------------------------------------------------------------------------
% Analysis directory
%--------------------------------------------------------------------------
% Set output directory
cd(details.dcmroot);

% Set output file name
file_name = details.dcmfile;


%--------------------------------------------------------------------------
% Data filename
%--------------------------------------------------------------------------
% Set data file name
DCM.xY.Dfile = details.erpfile;


%--------------------------------------------------------------------------
% Parameters and options used for setting up model
%--------------------------------------------------------------------------
DCM.options = options.dcm;

%--------------------------------------------------------------------------
% Data and spatial model
%--------------------------------------------------------------------------
DCM = spm_dcm_erp_data(DCM);

%--------------------------------------------------------------------------
% Location priors for dipoles
%--------------------------------------------------------------------------
DCM.Lpos  = options.dcm.sources.mni;
DCM.Sname = options.dcm.sources.name;

%--------------------------------------------------------------------------
% Spatial model
%--------------------------------------------------------------------------
DCM = spm_dcm_erp_dipfit(DCM);


%--------------------------------------------------------------------------
% Specify connectivity model
%--------------------------------------------------------------------------
% Forward connections
DCM.A{1,1} = [0 0 0 0 0
              0 0 0 0 0
              1 0 0 0 0
              0 1 0 0 0
              0 0 0 1 0];
          
% Backward connections
DCM.A{1,2} = [0 0 1 0 0
              0 0 0 1 0
              0 0 0 0 0
              0 0 0 0 1
              0 0 0 0 0];
          
% Lateral connections          
DCM.A{1,3} = [0 0 0 0 0
              0 0 0 0 0
              0 0 0 1 0
              0 0 1 0 0
              0 0 0 0 0];

% PE modulation
DCM.B{1,1} = [1 0 1 0 0
              0 1 0 1 0
              1 0 0 0 0
              0 1 0 0 1
              0 0 0 1 0];

% Input
DCM.C = [1; 1; 0; 0; 0];


%--------------------------------------------------------------------------
% Between trial effects
%--------------------------------------------------------------------------
DCM.xU.X    = options.dcm.contrast.code;
DCM.xU.name = options.dcm.contrast.type;


%--------------------------------------------------------------------------
% Invert
%--------------------------------------------------------------------------
DCM.name = file_name;
DCM = spm_dcm_erp(DCM);






