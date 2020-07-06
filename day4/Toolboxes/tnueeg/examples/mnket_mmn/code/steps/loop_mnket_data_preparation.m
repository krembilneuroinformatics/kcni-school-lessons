%% Loops over subjects in MNKET study and does the data preparation step %%

options = mnket_set_analysis_options;

for idCell = options.subjects.pilots
    id = char(idCell);
    
    D = mnket_data_preparation(id);
    
end
