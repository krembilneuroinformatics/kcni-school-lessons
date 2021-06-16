%% Loops over subjects in DPRST study and executes all analysis steps %%

options = dprst_set_analysis_options;

for idCell = options.subjectIDs
    id = char(idCell);
    
    dprst_analyze_subject(id);
    
end
