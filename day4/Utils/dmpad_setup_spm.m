function dmpad_setup_spm(modality)
% sets up SPM with reasonable parameters
if nargin < 1
    modality = 'EEG';
end

% init batch editor
spm_jobman('initcfg');

% to initialize field trip etc.
spm('defaults', modality);

% large mat files (>2GB) can only be saved with 7.3
spm_get_defaults('mat.format', '-v7.3');

% this should speed up GLM estimation:
spm_get_defaults('stats.maxmem', 2^31); % 2 GB RAM
spm_get_defaults('stats.resmem', true); % store GLM temp files in memory, not on disk

% change to true for cluster job where no graphics can be output
spm_get_defaults('cmdline', false);