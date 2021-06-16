%% PROJECT Master Script %%
% List the steps/functions/scripts for analyzing your EEG data set.
% Optimally, letting this master script run will produce all the final
% results that you report in your publication, including figures. 

% Example from an MMN study:

% Use the tone sequence to simulate an agent's beliefs and PEs using the
% HGF model, save the resulting trajectories to be used as regressors in
% the single-trial EEG analysis.
script_project_model;

% Analyze subjecsts' response times in the distraction task.
script_project_behavior;

% Preprocess subjects' EEG data.
script_project_preprocess;

% Run a standard ERP analysis using the average responses to deviant and
% standard trials in sensor space.
script_project_ERP;

% Compute the SPMs associated with the ERP contrasts.
script_project_erpbased_stats;

% Single-trial model-based EEG analysis
script_project_modelbased_stats;

% Collect all results and produce the figures
script_project_results;
