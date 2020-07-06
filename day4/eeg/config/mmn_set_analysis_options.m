function options = mmn_set_analysis_options(maindir)
%mmn_SET_ANALYSIS_OPTIONS Analysis options function for mmn project
%   IN:     -
%   OUT:    options     - a struct with all analysis parameters for the
%                       different steps of the analysis.

%-- where to find the data -----------------------------------------------%
options.maindir = maindir;

% [~, uid] = unix('whoami'); 
% switch uid(1: end-1)     
%     case {'drea'}
%         options.maindir = '/Users/drea/Documents/Courses/KCNISummerSchool/eeg';
%     otherwise
%         error(['Undefined user. Please specify a user in mmn_set_analysis_options ' ...
%             'and provide the path to the data']);
% end

options.workdir = fullfile(options.maindir, 'results');
options.rawdir  = fullfile(options.maindir, 'data');
options.codedir = fileparts(mfilename('fullpath'));

%-- subject IDs ----------------------------------------------------------%
options.subjects    = {'1'};
                        
%-- preparation ----------------------------------------------------------%
options.prepare.subjectIDs  = options.subjects; % data preparation (tone sequences)
options.prepare.overwrite   = 0; % whether to overwrite any previous prep
                           
%-- modeling -------------------------------------------------------------%
options.model.subjectIDs    = options.subjects; % modeling with the HGF
options.model.overwrite     = 0; % whether to overwrite any previous model

%-- preprocessing --------------------------------------------------------%
options.preproc.subjectIDs      = options.subjects;
options.preproc.overwrite       = 0; % whether to overwrite any prev. prepr
options.preproc.keep            = 1;  % whether to keep intermediate data

% swap channel option: this is where we decide what to do about the data sets with apparently
% swapped electrodes C2 and F1 (see readme and swapchannels.pdf for details)
options.preproc.swapchannels    = 'reject'; % 'swap'(swap channels back), 'reject'(mark as bad), 
                                            % '' (do nothing about it)

options.preproc.rereferencing   = 'average';
options.preproc.keepotherchannels = 1;
options.preproc.lowpassfreq     = 30;
options.preproc.highpassfreq    = 0.5; 
options.preproc.downsamplefreq  = 256;

options.preproc.trialdef            = 'tone'; % 'MMN', 'tone' - choose 'tone' for modelbased analysis
options.preproc.epochwin            = [-100 400];
options.preproc.baselinecorrection  = 1;

options.preproc.eyeblinktreatment   = 'reject'; % 'reject', 'ssp'
options.preproc.mrifile             = 'template';
options.preproc.eyeblinkchannels    = {'VEOG'};
options.preproc.windowForEyeblinkdetection = 3; % first event of interest (and optionally last)
% NOTE: This sets the default index of the first even of interest in the EEG file, however, this 
% will be adjusted individually for subjects if their EEG file requires a different value. For all
% adjustments, see mmn_subjects.
options.preproc.eyeblinkthreshold   = 3; % for SD thresholding: in standard deviations, for amp in uV
% NOTE: This sets the default threshold for detecting eye blink events in the EOG, however, this 
% will be adjusted individually for subjects if their EOG requires a different threshold. For all
% adjustments, see mmn_subjects.
options.preproc.eyeconfoundcomps    = 1;
options.preproc.eyeblinkmode        = 'eventbased'; % uses EEG triggers for trial onsets
options.preproc.eyeblinkwindow      = 0.5; % in s around blink events
options.preproc.eyeblinktrialoffset = 0.1; % in s: EBs won't hurt <100ms after tone onset
options.preproc.eyeblinkEOGchannel  = 'VEOG'; % EOG channel (name/idx) to plot
options.preproc.eyebadchanthresh    = 0.4; % prop of bad trials due to EBs
options.preproc.eyecorrectionchans  = {'Fp1', 'Fz', 'AF8', 'T7', 'Oz'};

% in case we use the SSP eye blink correction, this section defines the amount of pre-cleaning
options.preproc.preclean.doFilter           = true;
options.preproc.preclean.lowPassFilterFreq  = 10;
options.preproc.preclean.doBadChannels      = true;
options.preproc.preclean.doRejection        = true;
options.preproc.preclean.badtrialthresh     = 500;
options.preproc.preclean.badchanthresh      = 0.5;
options.preproc.preclean.rejectPrefix       = 'cleaned_';

options.preproc.badchanthresh   = 0.2; % proportion of bad trials
options.preproc.badtrialthresh  = 80; % in microVolt

%-- erp ------------------------------------------------------------------%
options.erp.subjectIDs  = options.subjects;                        
options.erp.overwrite   = 1; % whether to overwrite any previous erp

options.erp.type        = 'roving';  % roving (sta=6, dev>=5), mmnad (sta=6, dev=1), 
                            % tone (nothing), memory (t6, t8, t10), 
                            % repetitions (t1, t2, ..., t11)
options.erp.electrode   = 'C1';
options.erp.averaging   = 's'; % s (standard), r (robust)
switch options.erp.averaging
    case 'r'
        options.erp.addfilter = 'f';
    case 's'
        options.erp.addfilter = '';
end
options.erp.percentPE = 15; % for ERP type lowhighPE: how many percent PEs

options.erp.contrastWeighting   = 1;
options.erp.contrastPrefix      = 'diff_';
options.erp.contrastName        = 'mmn';
% these channels are set after inspecting the main results of the modelbased statistics: we plot all
% channels' grand averages + 1.96 * standard error, which lie in the peak of significant clusters of
% 2nd level contrasts
options.erp.channels            = {'C3', 'C1', 'Cz', ...
                                    'FC1', 'FC2', 'FCz', ...
                                    'F1', 'F2', 'Fz', ...
                                    'P7', 'P8', 'P9', 'P10', ...
                                    'TP7'};

%-- conversion2images ----------------------------------------------------%
options.conversion.subjectIDs   = options.subjects;
options.conversion.overwrite    = 0; % whether to overwrite any prev. conv.
options.conversion.mode         = 'modelbased'; %'ERPs', 'modelbased', 'mERPs', 'diffWaves'
options.conversion.space        = 'sensor';
options.conversion.convPrefix   = 'whole'; 
options.conversion.convTimeWindow = [100 400];
options.conversion.smooKernel   = [16 16 0];

%-- stats ----------------------------------------------------------------%
options.stats.subjectIDs    = options.subjects;
options.stats.overwrite     = 0; % whether to overwrite any previous stats
options.stats.mode          = 'modelbased'; %'ERPs', 'modelbased', 'mERPs', 'diffWaves'
options.stats.design        = 'epsilon'; % 'epsilon', 'HGF', 'epsilonS', 'plustime'
switch options.stats.design
    case 'epsilon'
        options.stats.regressors = {'epsi2', 'epsi3'};
end
options.stats.pValueMode    = 'clusterFWE';
options.stats.exampleID     = '1';
end
