%% Loops over subjects in MNKET study and does the PREPROCESSING step %%

options = mnket_set_analysis_options;

for idCell = options.subjects.pilots
    id = char(idCell);
    
    D = mnket_preprocessing(id);
    
end
