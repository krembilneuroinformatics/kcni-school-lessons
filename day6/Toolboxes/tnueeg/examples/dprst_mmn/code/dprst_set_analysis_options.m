function options = dprst_set_analysis_options
%DPRST_SET_ANALYSIS_OPTIONS Analysis options function for DPRST project
%   Run this function from the working directory of the analysis (the
%   project folder).
%   IN:     -
%   OUT:    options     - a struct with all analysis parameters for the
%                       different steps of the analysis.

options.workdir = pwd;
options.task = 'MMN';
options.part = 'anta'; %'anta', 'agon'

%-- subject IDs ----------------------------------------------------------%
options = dprst_get_part_specific_options(options);

%-- preparation ----------------------------------------------------------%
options.prepare.subjectIDs  = options.subjectIDs;% model
options.prepare.overwrite   = 0; % whether to overwrite any previous prep
                           
%-- modeling -------------------------------------------------------------%
options.model.subjectIDs    = options.subjectIDs;
options.model.overwrite     = 0; % whether to overwrite any previous model

%-- preprocessing --------------------------------------------------------%
options.preproc.subjectIDs      = options.subjectIDs;
options.preproc.overwrite       = 1; % whether to overwrite any prev. prepr
options.preproc.keep            = 1; % whether to keep intermediate data

options.preproc.rereferencing       = 'avref'; % avref, noref
options.preproc.keepotherchannels   = 1;
options.preproc.lowpassfreq         = 30;
options.preproc.highpassfreq        = 0.5;
options.preproc.downsamplefreq      = 250;

options.preproc.trialdef            = 'tone'; % tone, oddball
options.preproc.trlshift            = 25; % set to 125 for pilots in anta?
options.preproc.epochwin            = [-100 450];
options.preproc.baselinecorrection  = 1;

options.preproc.mrifile             = 'subject';
options.preproc.eyeblinkchannels    = {'EOG'};
options.preproc.eyeblinkdetection   = 'sdThresholding';
options.preproc.eyeblinkthreshold   = 3; % for SD thresholding: in standard deviations, for amp in uV
options.preproc.eyeblinkmode        = 'eventbased'; % uses EEG triggers for trial onsets
options.preproc.eyeblinkwindow      = 0.5; % in s around blink events
options.preproc.eyeblinktrialoffset = 0.1; % in s: EBs won't hurt <100ms after tone onset
options.preproc.eyeblinkEOGchannel  = 'EOG'; % EOG channel (name/idx) to plot
options.preproc.eyebadchanthresh    = 0.4; % prop of bad trials due to EBs
options.preproc.badtrialthresh      = 75; % in microVolt
options.preproc.badchanthresh       = 0.2; % prop of bad trials (artefacts)
options.preproc.eyeconfoundcomps    = 1;

%-- erp ------------------------------------------------------------------%
options.erp.subjectIDs 	= options.subjectIDs;
options.erp.overwrite   = 1; % whether to overwrite any previous erp

options.erp.type        = 'phases_oddball'; % roving, phases_oddball, 
                                            % phases_roving, split_phases
switch options.erp.type
    case 'roving'
        options.erp.conditions = {'standard', 'deviant'};
    case {'phases_oddball', 'phases_roving'}
        options.erp.conditions = {'volDev', 'stabDev', ...
            'volStan', 'stabStan'};
end
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
options.conversion.subjectIDs       = options.subjectIDs;
options.conversion.overwrite        = 0; % whether to overwrite prev. conv.

options.conversion.mode             = 'modelbased'; %'ERPs', 'modelbased', 
                                                    %'mERPs', 'diffWaves'
options.conversion.space            = 'sensor';
options.conversion.convPrefix       = 'whole'; % whole, early, late, ERP
options.conversion.convTimeWindow   = [100 450];
options.conversion.smooKernel       = [16 16 0];

%-- stats ----------------------------------------------------------------%
options.stats.subjectIDs    = options.subjectIDs;
options.stats.overwrite     = 0; % whether to overwrite any previous stats

options.stats.mode          = 'ERP';        % 'modelbased', 'ERP'
options.stats.priors        = 'volTrace';   % omega35, default, mypriors, 
                                            % kappa2, peIncrease, volTrace
options.stats.design        = 'epsilon';    % 'sepsilon', 'PEs', 'HGF', 
                                            %'epsilon', 'prediction'
switch options.stats.design
    case 'epsilon'
        options.stats.regressors = {'epsi2', 'epsi3'};
end
options.stats.pValueMode    = 'clusterFWE';
options.stats.exampleID     = '0001';

end

function optionsOut = dprst_get_part_specific_options(optionsIn)

optionsOut = optionsIn;

switch optionsOut.part
    case 'anta'
        % subjects
        optionsOut.tests.subjectIDs    = {'9997', '9996', '6666'};
        optionsOut.pilots.subjectIDs   = {'0001', '0003', '0005', ...
                                       '0012', '0014', '0008'};
        optionsOut.subjectIDs          = {'0019', '0013', '0010', '0021', ...
                                       '0002', '0026', '0027', '0028', ...
                                       '0018', '0032', '0004', '0025', ...
                                       '0033', '0034', '0035', '0024', ...
                                       '0016', '0031', '0038', '0039', ...
                                       '0029', '0030', '0042', '0045', ...
                                       '0046', '0047', '0048', '0049', ...
                                       '0052', '0053', '0055', '0077', ...
                                       '0056', '0057', '0059', '0060', ...
                                       '0063', '0066', '0068', '0069', ...
                                       '0070', '0073', '0074', '0075', ...
                                       '0080', '0081', '0084', '0085', ...
                                       '0086', '0087', '0089', '0090', ...
                                       '0093', '0095', '0096', '0079', ...
                                       '0097', '0098', '0100', '0101', ...
                                       '0103', '0105', '0106', '0065', ...
                                       '0107', '0109', '0110', '0104', ...
                                       '0061', '0067', '0072', '0102', ...
                                       '0078'};
        optionsOut.noBehav.subjectIDs  = {'0008', '0027', '0095'};
        optionsOut.noEEG.subjectIDs    = {'0040', '0094'}; 
                                        % 0094: no headphones
        
    case 'agon'
        % subjects
        optionsOut.pilots.subjectIDs   = {'0111', '0112', '0113', ...
                                       '0117', '0118', '0119'};
        optionsOut.subjectIDs          = {'0111', '0112', '0113', ...
                                       '0117', '0118', '0119', ...
                                       '0116', '0121', '0122', '0124', ...
                                       '0125', '0126', '0128', '0129', ...
                                       '0132', '0133', '0134', '0137', ...
                                       '0138', '0141', '0037'};
        optionsOut.all.subjectIDs      = {'0111', '0112', '0113', ...
                                       '0117', '0118', '0119', ...
                                       '0116', '0121', '0122', '0124', ...
                                       '0125', '0126', '0128', '0129', ...
                                       '0132', '0133', '0134', '0137', ...
                                       '0138', '0141', '0037'};
        optionsOut.problems.subjectIDs = {'0111', '0126'}; 
                                        % 0111: had to repeat MMN
                                        % 0126: problems with elecs
        
end

end
