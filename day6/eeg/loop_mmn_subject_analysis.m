function loop_mmn_subject_analysis( options )
%LOOP_mmn_SUBJECT_ANALYSIS Loops over all subjects in the mmn study and executes all analysis 
%steps
%   IN:     options     - the struct that holds all analysis options
%   OUT:    -

if nargin < 1 
    options = mmn_set_analysis_options;
end

for idCell = options.subjects
    id = char(idCell);
    
    mmn_analyze_subject(id, options);
    
end
