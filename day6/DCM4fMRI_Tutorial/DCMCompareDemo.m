%% DCM for fMRI tutorial
% KCNI summer school, CAMH
% 2021-07-12 (Day 6, Tutorial 2)

% We will go through a very simple demo of DCM for 2 brain regions. We will 
% consider how temporal parietal junction (TPJ) and dorsomedial prefrontal 
% cortex (dmPFC) are activated in the context of mentalizing, i.e.,
% learning about the intentions of others. 
% 
% Agenda:
% 1) Generate advice sequence and predition errors with HGF model
%   i) Generate correct/incorrect advice sequence in the task
%  ii) Use this sequence to obtain prediction errors (epsilon 2)
% 2) Simulate neuronal firing and BOLD time series data using DCM
%   i) Specify connectivity: A (intrinsic), B (modulatory), C (driving input)
%  ii) Use epsilon 2 from HGF to modulate connectivity
% 3) Perform model recovery
%   i) Fit multiple models to the generated BOLD data
%  ii) Perform model comparison

clear all

%% 1) Generate sensory input and prediction errors
sim = generate_advice_and_PEs;

%% 2) Generate neural and BOLD data

% set the number of regions and their names
DCM.n      = 2;
DCM.Y.name = {'TPJ','dmPFC'}; 

% set connectivity matrices for simulating DCM data (modulate b21)
DCM.Ep.A        = [0 0.4; 0.4 0]; % intrinsic
DCM.Ep.B(:,:,2) = [0   0; 0.5 0]; % modulatory 
DCM.Ep.C        = [0.3 0; 0   0]; % driving

% an alternative: modulate b22 instead of b21
% DCM.Ep.A        = [0 0.4; 0.4   0]; % intrinsic
% DCM.Ep.B(:,:,2) = [0   0; 0   0.5]; % modulatory 
% DCM.Ep.C        = [0.3 0; 0     0]; % driving

% Generate neural and BOLD data
DCM = Generate2RegionDCM_epsilon2(DCM,sim);

%% 3) Specify different models and fit them to the generated data

% Model 1: no modulation, only the driving input
DCMInput   = DCM;
DCMInput.a = [0 1; 1 0];           % intrinsic connectivity
DCMInput.b = zeros(2,2,2);         % no modulation
DCMInput.c = [1 0; 0 0];           % driving input enters x_1

% fit and save
DCM = spm_dcm_estimate(DCMInput);
save DCMnomod DCM; clear DCM


% Model 2: PE modulates dmPFC self-inhibition
DCMInput.a        = [0 1; 1 0];    % intrinsic connectivity
DCMInput.b        = zeros(2,2,2);  % no modulation
DCMInput.b(2,2,2) = 1;             % modulation of dmPFC self-inhibition
DCMInput.c        = [1 0; 0 0];    % driving input enters x_1

% fit and save
DCM = spm_dcm_estimate(DCMInput);
save DCMmodb22 DCM; clear DCM


% Fit model 3: PE modulates forward connection from TPJ to dmPFC
DCMInput.a        = [0 1; 1 0];    % intrinsic connectivity
DCMInput.b        = zeros(2,2,2);  % no modulation
DCMInput.b(2,1,2) = 1;             % modulation of the forward connection
DCMInput.c        = [1 0; 0 0];    % driving input enters x_1

% fit and save
DCM = spm_dcm_estimate(DCMInput);
save DCMmodb21 DCM; clear DCM

% Compare the models
model_comparison_settings
spm_jobman('interactive',matlabbatch);


