function options = mnket_set_analysis_options
%MNKET_SET_ANALYSIS_OPTIONS Analysis options function for MNKET project
%   Run this function from the working directory of the analysis (the
%   project folder).
%   IN:     -
%   OUT:    options     - a struct with all analysis parameters for the
%                       different steps of the analysis.

options.workdir     = pwd;
options.condition   = 'placebo'; % 'placebo', 'ketamine'
options.conditions  = {'placebo', 'ketamine'};

%-- subject IDs ----------------------------------------------------------%
options.subjects.pilots     = {'4422', '4478'};
options.subjects.excluded   = {'4459', '4507'}; % in Andreeas study
options.subjects.valid      = {'4431', '4446', '4447', '4458', ...
                               '4482', '4487', '4488', '4548', ...
                               '4494', '4499', '4500', '4520', ...
                               '4532', '4497', '4534'};
options.subjects.all        = {'4431', '4446', '4447', '4458', ...
                               '4482', '4487', '4488', '4548', ...
                               '4494', '4499', '4500', '4520', ...
                               '4532', '4497', '4534', '4459', ...
                               '4507', '4422', '4478'};                        
%-- preparation ----------------------------------------------------------%
options.prepare.subjectIDs  = options.subjects.all;% model
options.prepare.overwrite   = 0; % whether to overwrite any previous prep
                           
%-- modeling -------------------------------------------------------------%
options.model.subjectIDs    = options.subjects.all;
options.model.overwrite     = 0; % whether to overwrite any previous model

%-- preprocessing --------------------------------------------------------%
options.preproc.subjectIDs      = options.subjects.all;
options.preproc.overwrite       = 0; % whether to overwrite any prev. prepr
options.preproc.keep            = 1;  % whether to keep intermediate data

options.preproc.keepotherchannels = 1;
options.preproc.lowpassfreq     = 30;
options.preproc.highpassfreq    = 0.5; % try 0.1 for P300?
options.preproc.downsamplefreq  = 256;

options.preproc.trialdef            = 'tone'; % 'MMN', 'tone'
options.preproc.epochwin            = [-100 400];
options.preproc.baselinecorrection  = 1;

options.preproc.mrifile             = 'template';
options.preproc.eyeblinkchannels    = {'VEOG'};

options.preproc.badchanthresh   = 0.2; % proportion of bad trials
options.preproc.badtrialthresh  = 80; % in microVolt

%-- erp ------------------------------------------------------------------%
options.erp.subjectIDs  = options.subjects.all;                        
options.erp.overwrite   = 1; % whether to overwrite any previous erp

options.erp.type        = 'roving';  % roving (sta=6, dev>5), MMN (sta=6, dev=1), 
                            % tone (nothing), memory (t6, t8, t10), 
                            % repetitions (t1, t2, ..., t11)
options.erp.electrode   = 'Fz';
options.erp.averaging   = 's'; % s (standard), r (robust)
switch options.erp.averaging
    case 'r'
        options.erp.addfilter = 'f';
    case 's'
        options.erp.addfilter = '';
end

options.erp.contrastWeighting   = 1;
options.erp.contrastPrefix      = 'diff_';
options.erp.contrastName        = 'mmn';

%-- conversion2images ----------------------------------------------------%
options.conversion.subjectIDs   = options.subjects.all;
options.conversion.overwrite    = 0; % whether to overwrite any prev. conv.
options.conversion.mode         = 'modelbased'; %'ERPs', 'modelbased', 'mERPs', 'diffWaves'
options.conversion.space        = 'sensor';
options.conversion.convTime     = 'whole'; % 'early', 'late', 'whole','ERP'
switch options.conversion.convTime
    case 'early'
        options.conversion.convTimeWindow = [100 250];
    case 'late'
        options.conversion.convTimeWindow = [250 400];
    case 'whole'
        options.conversion.convTimeWindow = [100 400];
    case 'ERP'
        options.conversion.convTimeWindow = [-100 400];
end
options.conversion.smooKernel   = [16 16 0];

%-- stats ----------------------------------------------------------------%
options.stats.subjectIDs    = options.subjects.all;
options.stats.overwrite     = 0; % whether to overwrite any previous stats
options.stats.mode          = 'ERPs'; %'ERPs', 'modelbased', 'mERPs', 'diffWaves'
options.stats.design        = 'epsilon'; % 'epsilon', 'HGF', 'epsilonS', 'plustime'
switch options.stats.design
    case 'epsilon'
        options.stats.regressors = {'epsi2', 'epsi3'};
end
options.stats.pValueMode    = 'clusterFWE';
options.stats.exampleID     = '4422';


end