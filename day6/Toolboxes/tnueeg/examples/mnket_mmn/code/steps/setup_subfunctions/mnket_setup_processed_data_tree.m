function mnket_setup_processed_data_tree( options )
%MNKET_SETUP_PROCESSED_DATA_TREE Creates the data tree required for MNKET
%analysis

disp('MNKET setup: Create folder tree for processed data');

prodataroot     = fullfile(options.workdir, 'data', 'pro');

datasubfolders  = {'subjects', 'tones', 'erpanalysis', 'modelbased'};
conditions      = {'placebo', 'ketamine'};
subjprefix      = 'MMN_';
subjsubfolders  = {'tones', 'model', 'spm_prep', 'spm_erp', 'spm_stat'};


% subfolders of processed data
for folderCell = datasubfolders
    folderName = char(folderCell);
    
    mkdir(prodataroot, folderName);
end

    
% loop over conditions and subjects
for condCell    = conditions
    cond        = char(condCell);
    
    conddataroot = fullfile(prodataroot, 'subjects', cond);
    mkdir(conddataroot);

    for idCell  = options.subjects.all
        id      = char(idCell);

        subjroot = fullfile(conddataroot, [subjprefix id]);
        mkdir(subjroot);
        
        for subfolderCell = subjsubfolders
            subfolderName = char(subfolderCell);
            
            mkdir(subjroot, subfolderName);
        end
        
        disp(['Created pro-data tree for subject ' id ' in condition ' cond]);
    end
end

end

