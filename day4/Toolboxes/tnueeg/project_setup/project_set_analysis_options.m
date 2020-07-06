function options = project_set_analysis_options
%PROJECT_SET_ANALYSIS_OPTIONS Template options function for a new project
%   This is a template function for your own project. Enter your values in
%   the fields marked by %%%. 
%   Run this function from the working directory of the analysis (the
%   project folder)
%   IN:     -
%   OUT:    options     - a struct with all analysis parameters for the
%                       different steps of the analysis.

options.workdir = pwd;

% subjects
options.subjects.pilots     = {}; %%% enter subject IDs as strings, e.g. '0001', '0002'
options.subjects.all        = {}; %%%

% model
options.model.subjectIDs    = {}; %%%

% preprocessing
options.preproc.subjectIDs      = {}; %%%
options.preproc.keep            = 1;  % whether to keep all intermediate data sets
options.preproc.overwrite       = 1; % whether to overwrite any previous prepoc
options.preproc.lowpassfreq     = 30; %%% 
options.preproc.highpassfreq    = 0.5; %%%
options.preproc.downsamplefreq  = 300; %%%

options.preproc.trialdef            = ''; %%% enter a name for your trial definition
options.preproc.epochwin            = []; %%% enter a start and end time (in ms) around the events for epoching, e.g. [-100 400]. This defines your within-trial time. 
options.preproc.baselinecorrection  = 1; % whether to perform bc (1) or not (0)

options.preproc.badchanthresh   = 0.2; %%% proportion of bad trials within one channel that needs to be reached to mark the whole channel as bad
options.preproc.badtrialthresh  = 80; %%% amplitude threshold (in microVolt) for marking a trial as bad

% classical ERPs
options.erp.subjectIDs  = {}; %%%
options.erp.type        = ''; %%% enter a name for your ERP trial definition
options.erp.averaging   = 's'; % s (standard), r (robust) % consider robust averaging for ERP analyses with sufficient trialnumbers per condition
switch options.erp.averaging
    case 'r'
        options.erp.addfilter = 'f';
    case 's'
        options.erp.addfilter = '';
end

% SPM stats
options.stats.subjectIDs    = {}; %%%
options.stats.mode          = ''; %%% enter a name for your statistics type, e.g. 'ERPs', 'modelbased'
options.stats.convTime      = ''; %%% enter a name for your conversion window, e.g. 'whole' for whole epoch
switch options.stats.convTime
    case 'whole' %%% add new cases
        options.stats.convTimeWindow = options.preproc.epochwin; % in ms after event onset, e.g. [150 300]
end
% the conversion window acts like a mask for your statistics, i.e. you will
% only search for significant effects within that time window, and only
% correct for multiple comparisons within that time window.

options.stats.design = 'epsilon'; %%% enter a name for your design, e.g. 'epsilon', 'HGF'

options.scndlevel.subjectIDs = {}; %%%

%%% you can add more options 

end