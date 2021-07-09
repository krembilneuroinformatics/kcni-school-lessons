function output = kcni_setup_paths()
% -------------------------------------------------------------------------
% Restores default paths, add project paths including SPM (but without
% sub-folders), sets up batch editor.
%
% EXAMPLE
%   kcni_setup_paths
%
% Author:   Andreea Diaconescu
% Created:  2020-06-01
% Copyright (C) 2019 KCNI
% -------------------------------------------------------------------------


%% Main
restoredefaultpath; % remove all other toolboxes
pathProject = fileparts(mfilename('fullpath')); % save path to project
warning off; % to remove obvious path warnings for now
addpath(genpath(pathProject)); % add project path with all sub-paths


%% Remove SPM subfolders from path 
% NOTE: NEVER add SPM with subfolders to your path, since it creates
% conflicts with Matlab core functions, e.g., uint16
% We will remove subfolders of SPM, since it is recommended,
% and fieldtrip creates conflicts with Matlab functions otherwise
pathSpm = fileparts(which('spm'));
rmpath(genpath(pathSpm));
addpath(pathSpm);
warning on