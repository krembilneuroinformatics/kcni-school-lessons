% --- Analysis script for DPRST MMN dataset --- %

options = dprst_set_analysis_options;

loop_dprst_subject_analysis;
% dprst_2ndlevel_erpbased;
% dprst_2ndlevel_modelbased;
% 
% dprst_results_report_modelbased;
% dprst_results_report_erpbased;


%{
% script for global options
options = dprst_set_analysis_options;

% simulate Bayesian observer
script_dprst_simulate_bayesian(options);
script_dprst_design(options);

% preprocess all subjects
dprst_correct_elec_tnu(options);
script_dprst_preprocess(options);

% do the classical ERP analysis
script_dprst_ERP(options);
script_dprst_plot_subject_ERPs(options);
dprst_grand_mean(options);

% statistics: prepare regressors(options); conversion & smoothing
script_dprst_prepare_regressors(options);
script_dprst_convert(options);

% statistics: first level
script_dprst_1stlevel(options);

% statistics: second level
dprst_2ndlevel(options);

%}