function [ D ] = tnueeg_mark_blink_artefacts( D, options )
%TNUEEG_MARK_BLINK_ARTEFACTS Detects eye blink events based on thresholding
%   Detects eye blink events in an EEG data set by thresholding the
%   indicated eye channel(s).
%   IN:     D       - continuous EEG data set
%           options - the struct that holds all analysis options
%   OUT:    D       - continuous EEG data set with marked eye blink events

S = [];
S.D = D;
S.mode = 'mark';
S.badchanthresh = 1;
S.methods.channels = options.preproc.eyeblinkchannels;
        
switch options.preproc.eyeblinkdetection
    case 'sdThresholding'
        S.methods.fun = 'sdthresh';
        S.methods.settings.threshold = options.preproc.eyeblinkthreshold; % SD of EOG amplitude
        S.methods.settings.excwin = 0; % set this to zero to manually exclude trials with EB overlap
        % set the excwin to 1000 to use SPM event-based rejection.
        S.prefix = 'b';
    case 'ampThresholding'
        S.methods.fun = 'ampthresh';
        S.methods.settings.threshold = options.preproc.eyeblinkthreshold; % EOG amplitude in uV
        S.methods.settings.excwin = 1000;
        S.prefix = 'b';
    case 'ampThreshUnfiltered'       
        S.methods.fun = 'threshchan';
        S.methods.settings.threshold = options.preproc.eyeblinkthreshold; % in mV (applied to EOG amplitude)
        S.methods.settings.excwin = 1000;
        % excision window: Window (in ms) to mark as bad around each jump 
        % (for mark mode only), 0 - do not mark data as bad
end
S.append = true;
% 1: if other artefact detection has already been applied, 
% only the remaining clean channels will be used for this session.
% 0: all channels will be scanned for artefacts

D = tnueeg_spm_eeg_artefact(S); 

if ~options.preproc.keep
    delete(S.D);
end

end

