function [fh, Dbefore, Dafter] = tnueeg_check_eb_correction_on_average( Dinit, Dconf, corrFig, options)
%TNUEEG_CHECK_EB_CORRECTION_ON_AVERAGE Calculates the average eyeblink epoch before and after the
%EB correction method was applied.
%   IN:     Dinit       - EEG data set epoched to EB events, not corrected, not averaged
%           Dconf       - EEG data set holding the spatical confounds used for correction
%                       (typically, the final preprocessed file)
%           options     - the struct that holds all analysis options
%   OUT:    Dbefore     - EEG data set holding average EB epoch, uncorrected
%           Dafter      - EEG data set holding average EB epoch, corrected as during preproc

%-- preparation -----------------------------------------------------------------------------------%
if ischar(Dinit)
    Dinit   = spm_eeg_load(fullfile(Dinit)); 
end

[filePath, ~, fileExt] = fileparts(Dinit.fullfile);

if ischar(Dconf)
    Dconf   = spm_eeg_load(fullfile(Dconf)); 
end

%-- get average EB response before and after EB correction ----------------------------------------%
Dinit = copy(Dinit, fullfile(filePath, ['EB_epoched' fileExt]));
Dbefore = tnueeg_average(Dinit, 's');

if isfield(Dinit, 'sconfounds')
    Dcorr = rmfield(Dinit, 'sconfounds');
else
    Dcorr = Dinit;
end
Dcorr = tnueeg_correct_epoched_EB(Dcorr, Dconf, options);

Dafter  = tnueeg_average(Dcorr, 's');

%-- plot the comparison in selected channels ------------------------------------------------------%
if isfield(options.preproc, 'eyecorrectionchans')
    channels = options.preproc.eyecorrectionchans;
else
    if ismember('Fz', chanlabels(Dconf))
        channels = {'Fz', 'Cz', 'Pz', 'Oz'};
    else 
        channels = {'1', '2', '3', '4'};
    end
end

fh = tnueeg_diagnostics_effect_of_EB_corr(Dbefore, Dafter, channels, 1);
saveas(fh, corrFig);

end