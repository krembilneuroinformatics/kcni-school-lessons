% --- Analysis script for MMN ketamine EEG dataset --- %

options = mnket_set_analysis_options;

loop_mnket_subject_analysis;
mnket_2ndlevel_erpbased;
mnket_2ndlevel_modelbased;

mnket_results_report_modelbased;
mnket_results_report_erpbased;


%{
%% modeling
% check tone sequences and create tones.mat
script_mnket_check_tones(options);
% simulation of optimal Bayesian agent
% do this on Brutus/Euler
script_mnket_simulate_subjects(options);
% add regressors of interest to sim structs
script_mnket_save_trajectories(options);
% create designs for EEG analysis
script_mnket_create_designs(options);
% correct one subject
script_mnket_correct_sub4534_regressors(options);
%}
