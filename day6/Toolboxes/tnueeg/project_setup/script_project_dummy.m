%% Dummy script for TNU EEG analysis %%

options = project_set_analysis_options;
disp('start of dummy script');

for idCell = options.dummy.subjectIDs
    id = char(idCell);
    
    D = project_dummy_function(id);
            
    disp(['finished dummy analyzing subject ' id]);
end

cd(options.workdir);