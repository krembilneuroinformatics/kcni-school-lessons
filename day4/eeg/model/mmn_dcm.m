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
DCM.options.analysis = 'ERP'; % analyze evoked responses
DCM.options.model    = 'ERP'; % ERP model
DCM.options.spatial  = 'ECD'; % spatial model
DCM.options.Tdcm(1)  = 0;     % start of peri-stimulus time to be modelled
DCM.options.Tdcm(2)  = 350;   % end of peri-stimulus time to be modelled
DCM.options.Nmodes   = 8;     % nr of modes for data selection
DCM.options.h        = 1;     % nr of DCT components
DCM.options.onset    = 60;    % selection of onset (prior mean)
DCM.options.D        = 1;     % downsampling
DCM.options.Nmax     = 300;   % maximal number of EM iterations
DCM.options.trials   = [2 3]; % index of ERPs within ERP/ERF file: trials with high and low PE, and not other

%--------------------------------------------------------------------------
% Data and spatial model
%--------------------------------------------------------------------------
DCM = spm_dcm_erp_data(DCM);

%--------------------------------------------------------------------------
% Location priors for dipoles
%--------------------------------------------------------------------------
DCM.Lpos = [[-42; -22; 7] [46; -14; 8] [-61; -32; 8] [59; -25; 8] [46; 20; 8]];
DCM.Sname = {'left A1', 'right A1', 'left STG', 'right STG', 'right IFG'};

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

DCM.C = [1; 1; 0; 0; 0];


%--------------------------------------------------------------------------
% Between trial effects
%--------------------------------------------------------------------------
DCM.xU.X = [-1; 1];
DCM.xU.name = {'linear effect'};


%--------------------------------------------------------------------------
% Invert
%--------------------------------------------------------------------------
DCM.name = file_name;
DCM = spm_dcm_erp(DCM);






