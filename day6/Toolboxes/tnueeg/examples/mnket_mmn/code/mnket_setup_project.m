function mnket_setup_project
%MNKET_SETUP_PROJECT Creates project directory tree and collects data for
%the MNKET project
%   Pull the MNKET code from the git repo into a subfolder 'code' in your 
%   projectfolder. Add the code to your Matlab path. Run this function from
%   the projectfolder. It will create all subfolders for you and copy
%   existing data into the right place.

sourceprojectfolder = ...
    '/home/laew/prj/tmp_mnket/mnket_spm3_m15b_noEB/';

options = mnket_set_analysis_options;

diary('project_setup.log');

% get all the data
disp('MNKET setup: DATA');
mkdir('data');
mkdir('data', 'raw');
mkdir('data', 'pro');

mnket_copy_raw_data(options, sourceprojectfolder);
mnket_setup_processed_data_tree(options);
mnket_rsync_model_results(options, sourceprojectfolder);

% get all the configs
disp('MNKET setup: CONFIG');
mkdir('conf');
mkdir('tmp');
copyfile(fullfile(sourceprojectfolder, 'configs'), 'tmp');
movefile(fullfile(options.workdir, 'tmp', 'mmn_sensors.sfp'), ...
    fullfile(options.workdir, 'conf', 'mnket_sensors.sfp'));
movefile(fullfile(options.workdir, 'tmp', 'paradigm.mat'), ...
    fullfile(options.workdir, 'conf', 'mnket_paradigm.mat'));
movefile(fullfile(options.workdir, 'tmp', 'mmn_avref_eog.mat'), ...
    fullfile(options.workdir, 'conf', 'mnket_avref_eog.mat'));
movefile(fullfile(options.workdir, 'tmp', 'spm_templates', 'biosemi64.sfp'), ...
    fullfile(options.workdir, 'conf', 'biosemi64_sensors.sfp'));
copyfile(fullfile(options.workdir, 'tmp', 'Biosemi_Cap_coords_all.xls'), ...
    fullfile(options.workdir, 'conf'));
rmdir('tmp', 's')

diary OFF

end

