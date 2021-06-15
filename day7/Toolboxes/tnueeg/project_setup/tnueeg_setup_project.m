function tnueeg_setup_project( rootdir, projectname )
%TNUEEG_SETUP_PROJECT Utility function for setting up the folders for a new
%project
%   This function sets up the folder structure for a new project according
%   to the tnueeg default. It also copies the tnueeg template project_
%   functions into the code folder of the project. These should be renamed
%   and changed according to your project needs.
%   IN:     rootdir     - the path to your project
%           projectname - name of your project (e.g., PID such as DPRST)
%   OUT:    -

%   You will need to add the tnueeg toolbox to your Matlab path manually. 
%   Make sure you track the latest version of the toolbox using GIT.

% where is this function (this is also where we find the template
% functions)
functionpath = which('tnueeg_setup_project.m');
[templateroot, ~, ~] = fileparts(functionpath);

% root directory for new project
projectroot = [rootdir '/' projectname];
mkdir(projectroot);

% create subfolders
mkdir(projectroot, 'code')
mkdir(projectroot, 'code/steps')
mkdir(projectroot, 'code/scripts')
mkdir(projectroot, 'data')
mkdir(projectroot, 'config')
% ... add your own folders here

% add template functions to project code
copyfile([templateroot '/project_set_analysis_options.m'], [projectroot '/code']);
copyfile([templateroot '/project_master_script.m'], [projectroot '/code']);
copyfile([templateroot '/project_subjects.m'], [projectroot '/code']);
copyfile([templateroot '/project_analyze_subject.m'], [projectroot '/code']);

copyfile([templateroot '/project_dummy_function.m'], [projectroot '/code/steps']);
copyfile([templateroot '/script_project_dummy.m'], [projectroot '/code/scripts']);

% make sure Matlab knows all the functions and scripts in the code folder
addpath(genpath([projectroot '/code/']));

end

