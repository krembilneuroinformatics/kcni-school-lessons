function output = kcni_setup_paths()
% restores default paths, add project paths including SPM (but without
% sub-folders), sets up batch editor
%
%   output = kcni_setup_paths(input)
%
% IN
%
% OUT
%
% EXAMPLE
%   kcni_setup_paths
%
%   See also
%
% Author:   Andreea Diaconescu
% Created:  2020-06-01
% Copyright (C) 2019 KCNI

% remove all other toolboxes
restoredefaultpath;

pathProject = fileparts(mfilename('fullpath'));

% remove all other toolboxes
restoredefaultpath;

% add project path with all sub-paths
addpath(genpath(pathProject));


%% remove SPM subfolder paths 
% NOTE: NEVER add SPM with subfolders to your path, since it creates
% conflicts with Matlab core functions, e.g., uint16

pathSpm = fileparts(which('spm'));
% remove subfolders of SPM, since it is recommended,
% and fieldtrip creates conflicts with Matlab functions otherwise
rmpath(genpath(pathSpm));
addpath(pathSpm);
dmpad_setup_spm();