function [ D ] = tnueeg_correct_epoched_EB( D, Dconf, options )
%TNUEEG_CORRECT_EPOCHED_EB Applies the EB correction method used during preprocessing to the EEG 
%data set wich was epoched to the onset of all detected eye blinks. Can be used to examine the 
%effects of the correction on the average eyeblink.
%   IN:     D           - the EEG data set epoched to the onsets of EBs
%           Dconf       - the EEG data set that holds the EB confounds used for EB correction during
%                       preprocessing (usually, the final preprocessed D can be used here)
%           options     - the struct that holds all analysis options
%   OUT:    D           - the corrected EEG data set epoched to the onsets of EBs

%-- fetch EB correction matrix --------------------------------------------------------------------%
if ischar(Dconf)
    Dconf = spm_eeg_load(Dconf);
end

% determine EB correction method applied during preprocessing
if isfield(options.preproc, 'eyeblinktreatment') 
    switch(lower(options.preproc.eyeblinktreatment))
        case {'ssp', 'berg'}
            corrMethod = options.preproc.eyeblinktreatment;
        case 'reject'
            error('No eyeblink correction was applied during preprocessing.');
        otherwise
            error('Could not determine the EB correction method that was applied in preprocessing');
    end
elseif isfield(options.preproc, 'eyeCorrMethod')
    corrMethod = options.preproc.eyeCorrMethod;
else
    error('Could not determine the EB correction method that was applied in preprocessing');
end

% get the inverted confounds matrix that was used in the correction of the EEG data
SRC = tnueeg_bergscherg_source_waveforms(Dconf, corrMethod);
confoundsMatrix = SRC.invertedMatrix;

%-- preparation for montage step ------------------------------------------------------------------%
% adopt bad channels from preprocessing
if ~isempty(badchannels(Dconf))
    D = badchannels(D, badchannels(Dconf), 1);
    save(D);
end

label = D.chanlabels(indchantype(D, 'EEG', 'GOOD'))';

montage = [];
montage.labelorg = label;
montage.labelnew = label;

montage.chantypeorg = lower(D.chantype(D.indchannel(label)))';
montage.chantypenew  = lower(montage.chantypeorg);

montage.chanunitorg = D.units(D.indchannel(label))';
montage.chanunitnew  = montage.chanunitorg;

% configure the montage matrix to substract eye-related activity
montage.tra = eye(size(SRC.A, 1)) - SRC.A*confoundsMatrix;

%-- montage step ----------------------------------------------------------------------------------%
Dorig = D;

S1   = [];
S1.D = D;
S1.montage = montage;
S1.keepothers = true;
S1.updatehistory  = false;
S1.prefix = 'corrected_';

Dcorr = spm_eeg_montage(S1); 

if isfield(Dorig,'inv')
    Dcorr.inv = Dorig.inv;
end

%-- clean up --------------------------------------------------------------------------------------%
D = Dcorr;

% change the channel order to the original order
tra = eye(D.nchannels);
montage = [];
montage.labelorg = D.chanlabels';
montage.labelnew = Dorig.chanlabels';

montage.chantypeorg  = lower(D.chantype)';
montage.chantypenew  = lower(Dorig.chantype)';

montage.chanunitorg  = D.units';
montage.chanunitnew  = Dorig.units';

[~, sel2]  = spm_match_str(montage.labelnew, montage.labelorg);
montage.tra = tra(sel2, :);

S2   = [];
S2.D = D;
S2.montage = montage;
S2.keepothers = true;
S2.updatehistory  = 0;
S2.prefix = 'final_';

D = spm_eeg_montage(S2);
delete(Dcorr);

% restore bad channels
if ~isempty(badchannels(Dorig))
    D = badchannels(D, badchannels(Dorig), 1);
end

% update history
D = D.history(mfilename, S1);
save(D);

end

