function project_analyze_subject( id )
%PROJECT_ANALYZE_SUBJECT Runs all analysis steps for a given subject
%   IN:     id  - the subject number as a string, e.g. '0001'
%   OUT:    -

% EXAMPLE
% start by preprocessing
project_preprocess(id);

% average data set for ERP anaylsis and plot subject-specific ERPs
project_average(id);

% convert EEG data to a (set of) 3D image(s) for statistics and spatially 
% smooth the images
project_convert(id);
project_smooth(id);

% comupte the statistics for the subject
project_1stlevel(id);


end