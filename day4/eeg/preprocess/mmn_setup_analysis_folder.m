function mmn_setup_analysis_folder(options)
%MMN_SETUP_ANALYSIS_FOLDER Creates project directory tree and collects data for the MNKET project

if nargin < 1
    options = mmn_set_analysis_options;
end

%-- create folder tree ----------------------------------------------------------------------------%
if ~exist(options.workdir, 'dir')
    mkdir(options.workdir);
end

cd(options.workdir);
diary('analysis_setup.log');

for subfolder = {'config', 'subjects', 'tones', 'erp', 'stats_erp', 'stats_model'}
    if ~exist(fullfile(options.workdir, char(subfolder)), 'dir')
        mkdir(fullfile(options.workdir, char(subfolder)));
    end
end
disp(['Created analysis folder tree at ' options.workdir]);

%-- raw eeg data ----------------------------------------------------------------------------------%
mmn_copy_raw_eeg_data_into_analysis_folder(options);
disp('Copied raw EEG data to analysis subfolder subjects');

%-- cap info --------------------------------------------------------------------------------------%
copyfile(fullfile(options.codedir, '*.mat'), fullfile(options.workdir, 'config'));
disp('Copied cap info to analysis subfolder config');

end

