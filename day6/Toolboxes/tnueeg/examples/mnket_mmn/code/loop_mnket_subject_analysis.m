%% Loops over subjects in MNKET study and executes all analysis steps %%

options = mnket_set_analysis_options;

for idCell = options.subjects.all
    id = char(idCell);
    
    mnket_analyze_subject(id);
    
end
