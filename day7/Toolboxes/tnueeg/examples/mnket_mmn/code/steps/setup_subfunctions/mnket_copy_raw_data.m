function mnket_copy_raw_data( options, sourceprojectroot )
%MNKET_COPY_RAW_DATA Copies raw EEG and experimental (tone sequence) data 
%from MNKET project to current analysis folder

disp('MNKET setup: Copy raw data to new analysis folder');

% experimental data (tone sequences)
expdatasource   = fullfile(sourceprojectroot, 'data', 'tones');
expdatadest     = fullfile(options.workdir, 'data', 'raw', 'tonesequences');

mkdir(expdatadest);
copyfile(expdatasource, expdatadest);

% source: where are the raw data currently
rawdatasource   = fullfile(sourceprojectroot, 'data', 'subjects');
conditions      = {'placebo', 'ketamine'};
srcprefix       = 'MMN_';
srcsubfolder    = 'eeg';

% destination: where should I put them
rawdatadest     = fullfile(options.workdir, 'data', 'raw');
destprefix      = 'TNU_MNKET_';
destsubfolder   = 'eegdata';

% loop over conditions and subjects
for condCell    = conditions
    cond        = char(condCell);

    for idCell  = options.subjects.all
        id      = char(idCell);

        subjsource      = fullfile(rawdatasource, cond, ...
            [srcprefix id], srcsubfolder);
        subjdestination = fullfile(rawdatadest, ...
            [destprefix id], destsubfolder);
        
        if ~exist(subjdestination, 'dir')
            mkdir(subjdestination);
        end
        
        copyfile(subjsource, subjdestination);
        disp(['Copied data for subject ' id ' in condition ' cond]);
    end
end

end

