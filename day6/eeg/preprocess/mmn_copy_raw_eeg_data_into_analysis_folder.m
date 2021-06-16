function mmn_copy_raw_eeg_data_into_analysis_folder( options )
%MMN_COPY_RAW_EEG_DATA_INTO_ANALYSIS_FOLDER Copies raw EEG data from raw directory to current
%analysis folder

% source: where are the raw data currently
rawdatasource   = fullfile(options.rawdir);

% destination: where should I put them
rawdatadest     = fullfile(options.workdir, 'subjects');
destprefix      = 'MMN_';
origprefix      = 'subject';
destsubfolder   = 'eeg';

% loop over conditions and subjects
for idCell  = options.subjects
    id      = char(idCell);
    
    subjsource      = fullfile(rawdatasource, ...
        [origprefix id '.bdf']);
    
    subjdestinationDir = fullfile(rawdatadest,...
        [destprefix id], destsubfolder);
    
    if ~exist(subjdestinationDir, 'dir')
        mkdir(subjdestinationDir);
    end
    subjdestinationFile = fullfile(subjdestinationDir, ...
        [destprefix id '.bdf']);
    
    
    copyfile(subjsource, subjdestinationFile);
    disp(['Copied raw EEG data for subject ' id]);
end

end

